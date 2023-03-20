require('plugins')
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

vim.cmd([[
let g:checkpatch_enabled = 1
let g:checkpatch_path = "/home/jonas/git/zephyrproject/zephyr/scripts/checkpatch.pl"
]])

require'lualine'.setup{
	options = { theme = 'gruvbox'}
}

require'gitsigns'.setup()

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

