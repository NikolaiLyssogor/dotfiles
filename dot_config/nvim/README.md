# nvim

## codecompanion.nvim
- Store your API key in a text file somewhere and encrypt it using `gpg --symmetric --cipher-algo AES256 --batch --passphrase " " secret.txt`

## Quarto

**NOTE**: This is not a super-stable plugin. Use at your own risk
In order to configure the markdman language server, you need to put the following in `$home/.config/marksman/config.toml`:

```toml
[core]
markdown.file_extensions = ["md", "markdown", "qmd"]
```

## Debugging
`gdb` is not supported on MacOS. You need to `brew install llvm` and provide the full path to `llvm-vscode` to `nvim-dap` in order to use it

## Autocmds
- Sometimes when editing the markdown `autocmd` in `vim-options.lua`, you need to delete old sessions that have markdown files in them, such as your notes folder, in order to get the changes to take effect.



