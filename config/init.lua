require('plugins')
require('lspinstall')
require('keymaps')
-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --
vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.wo.cursorline = true
vim.opt.number = true
vim.opt.colorcolumn = "80,100"
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg=0, bg=Black })
vim.opt.list = true
vim.opt.listchars = {
  space = '⋅',
  trail = '␣',
  extends = '◀',
  precedes = '▶',
  tab = '▶ '
}
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 8
vim.opt.undodir = vim.fn.expand('~/.vim/undodir')
vim.opt.undofile = true

vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.loaded_ruby_provider = 0

require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    operators = true,
    comments = true
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {
    Function = {fg = "#ebdbb2"}, -- light1
    Title = { link = "GruvboxOrangeBold" } -- e.g. for rst documents
  },
  dim_inactive = false,
  transparent_mode = false,
})

vim.opt.termguicolors = true
vim.o.background = "dark"
vim.cmd('colorscheme gruvbox')

-- Handle rsti files as rst
vim.cmd [[
augroup filetypedetect_rsti
  autocmd!
  autocmd BufRead,BufNewFile *.rsti setfiletype rst
augroup END
]]

require'lualine'.setup{
	options = { theme = 'gruvbox'}
}

require'gitsigns'.setup()

-- Chat GPT API
require'gp'.setup{
  openai_api_key = os.getenv("OPENAI_API_KEY")
}

require'nvim-treesitter.configs'.setup {
 -- A list of parser names, or "all" (the five listed parsers should always be installed)
  --ensure_installed = { "c", "lua", "vim", "vimdoc", "python" },
  ensure_installed = { " ... " },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
  },
}
