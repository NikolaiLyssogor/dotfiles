local api = vim.api

---@class HighlightsModule
---@field active boolean
---@field private _saved table<string, vim.api.keyset.get_hl_info|false>
---@field private _purple string
---@field private _groups string[]
local M = {
  active = false,
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

---@param purple? string
---@param recapture? boolean
function M.enable_review_mode(purple, recapture)
  if purple then
    M._purple = purple
  end

  if recapture or next(M._saved) == nil then
    M._capture()
  end

  M.active = true

  -- Force all GitSigns sign-related groups to purple.
  -- Setting fg explicitly breaks any links and makes the result deterministic.
  for _, name in ipairs(M._groups) do
    api.nvim_set_hl(0, name, { fg = M._purple })
  end
end

function M.disable_review_mode()
  if not M.active then
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

  M.active = false
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

      if M.active then
        vim.schedule(function()
          M.enable_review_mode(M._purple, true)
        end)
      end
    end,
  })
end

return M
