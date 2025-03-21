# Nvim Code Commands

## Usage

```lua
require("tsgo").setup()
```

```lua
require("tsgo").setup({
    -- optional: path to tsgo binary
    tsgo_bin = "tsgo",
    -- optional: filetypes to attach tsgo LSP to
    filetypes = { 'javascript', 'typescript' },
})
```

<br><br>

## Credit

- [guard.nvim](https://github.com/nvimdev/guard.nvim)

## License

[MIT © Josa Gesell](LICENSE)
