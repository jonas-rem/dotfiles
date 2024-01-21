local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Have packer manage itself

  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'sharkdp/fd'
  use 'lewis6991/gitsigns.nvim'
  -- Chat GPT
  use 'robitx/gp.nvim'

  -- Colorscheme
  use 'ellisonleao/gruvbox.nvim'

  -- Statusline
  use 'nvim-lualine/lualine.nvim'

  -- Language Server
  use 'neovim/nvim-lspconfig'

  -- Tables
  use 'dhruvasagar/vim-table-mode'

  use 'nvim-treesitter/nvim-treesitter'
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
