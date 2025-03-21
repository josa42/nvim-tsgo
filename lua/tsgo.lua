local M = {}

local root_dir = function(fname)
  return vim.fs.root(fname or 0, { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' })
end

local au_group = vim.api.nvim_create_augroup('josa42/nvim-tsgo', {
  clear = true,
})

local function setup_directly(opts)
  vim.api.nvim_create_autocmd('FileType', {
    group = au_group,

    pattern = opts.filetypes,
    desc = 'Start tsgo LSP',

    callback = function(args)
      vim.lsp.start({
        name = 'tsgo',
        cmd = { opts.tsgo_bin, 'lsp', '--stdio' },
        root_dir = opts.root_dir(args.buf),
      })
    end,
  })
end

local function setup_lspconfig(configs, opts)
  configs.tsgo = {
    default_config = {
      cmd = { opts.tsgo_bin, 'lsp', '--stdio' },
      filetypes = opts.filetypes,
      root_dir = opts.root_dir,
    },
  }
  configs.tsgo.setup({})
end

-- Setup tsgo LSP
--
-- @param opts table
-- @param opts.tsgo_bin string: Path to tsgo binary
-- @param opts.filetypes table: List of filetypes to attach tsgo LSP to
function M.setup(opts)
  local ok, configs = pcall(require, 'lspconfig.configs.foo')

  -- optional opts
  opts = vim.tbl_extend('keep', opts or {}, {
    use_lspconfig = true,
    -- TODO use these filetypes once jsx is supported
    -- { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' }
    filetypes = { 'javascript', 'typescript' },
    tsgo_bin = 'tsgo',
  })

  opts = vim.tbl_extend('force', opts, {
    root_dir = root_dir,
  })

  if ok and opts.use_lspconfig then
    setup_lspconfig(configs, opts)
  else
    setup_directly(opts)
  end
end

return M
