local api = vim.api

---@class HighlightsModule
---@field private _active boolean
---@field private _saved table<string, vim.api.keyset.get_hl_info|false>
---@field private _purple string
---@field private _groups string[]
local M = {
  _active = false,
  _saved = {},
  _purple = "#9b42f5",
  _groups = {},
}

local function capitalise(s)
  return s:sub(1, 1):upper() .. s:sub(2)
end

---@return string[]
local function build_gitsigns_groups()
  local groups = {} ---@type string[]

  local kinds = { "", "Nr", "Ln", "Cul" }
  local types = { "add", "change", "delete", "changedelete", "topdelete", "untracked" }
  local staged_prefixes = { "", "Staged" }

  for _, staged in ipairs(staged_prefixes) do
    for _, kind in ipairs(kinds) do
      for _, ty in ipairs(types) do
        local name = ("GitSigns%s%s%s"):format(staged, capitalise(ty), kind)
        groups[#groups + 1] = name
      end
    end
  end

  return groups
end

---@param name string
---@return vim.api.keyset.get_hl_info|nil
local function safe_get_hl(name)
  local ok, hl = pcall(api.nvim_get_hl, 0, { name = name, link = true })
  if not ok then
    return nil
  end
  return hl
end

---@param name string
---@param hl vim.api.keyset.get_hl_info
local function set_hl_exact(name, hl)
  -- nvim_get_hl() may return extra fields; nvim_set_hl() is tolerant.
  api.nvim_set_hl(0, name, hl)
end

function M._capture()
  M._saved = {}

  for _, name in ipairs(M._groups) do
    local hl = safe_get_hl(name)
    if hl == nil then
      M._saved[name] = false
    else
      M._saved[name] = hl
    end
  end
end

---Load changed files from the qflist into a buffer.
---@param qf table
function M.load_changed_files(qf)
  local items = type(qf) == "table" and qf.items or nil
  if type(items) ~= "table" then
    return
  end

  ---@type table<integer, true>
  local seen = {}
  local MAX_FILE_SIZE = 1024 * 1024

  for _, item in ipairs(items) do
    if type(item) == "table" then
      local bufnr = item.bufnr
      if type(bufnr) == "number" and bufnr > 0 and not seen[bufnr] then
        seen[bufnr] = true
        vim.schedule(function()
          local filename = vim.api.nvim_buf_get_name(bufnr)

          if filename and filename ~= "" then
            local size = vim.fn.getfsize(filename)
            -- getfsize returns -1 if file doesn't exist, -2 if directory
            if size >= 0 and size <= MAX_FILE_SIZE then
              vim.fn.bufload(bufnr)
            end
          else
            -- If we can't determine size, load it anyway
            vim.fn.bufload(bufnr)
          end
        end)
      end
    end
  end
end

---@param purple? string
---@param recapture? boolean
function M.enable_review_mode(purple, recapture)
  Snacks.picker.git_branches({ confirm = "gitsigns_change_base" })

  if purple then
    M._purple = purple
  end

  if recapture or next(M._saved) == nil then
    M._capture()
  end

  M._active = true

  -- Force all GitSigns sign-related groups to purple.
  -- Setting fg explicitly breaks any links and makes the result deterministic.
  for _, name in ipairs(M._groups) do
    api.nvim_set_hl(0, name, { fg = M._purple })
  end
end

function M.disable_review_mode()
  if not M._active then
    return
  end

  for name, saved in pairs(M._saved) do
    if saved == false then
      -- Clear if it didn't exist when captured.
      api.nvim_set_hl(0, name, {})
    else
      set_hl_exact(name, saved)
    end
  end

  require("gitsigns").reset_base(true)
  M._active = false

  vim.notify("Review mode is disabled.", vim.log.levels.INFO)
end

---@param purple? string
---@param recapture? boolean
function M.toggle_review_mode(purple, recapture)
  if not M._active then
    M.enable_review_mode(purple, recapture)
  else
    M.disable_review_mode()
  end
end

---@param opts? { purple?: string }
function M.setup(opts)
  M._groups = build_gitsigns_groups()
  if opts and opts.purple then
    M._purple = opts.purple
  end

  -- If the colorscheme changes:
  -- - discard the saved snapshot (it no longer applies)
  -- - if review mode is active, recapture + reapply purple *after* other ColorScheme handlers run
  api.nvim_create_autocmd("ColorScheme", {
    group = api.nvim_create_augroup("user_review_mode_hl", { clear = true }),
    callback = function()
      M._saved = {}

      if M._active then
        vim.schedule(function()
          M.enable_review_mode(M._purple, true)
        end)
      end
    end,
  })
end

return M
