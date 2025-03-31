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

local function setup_filetype_settings()
  local filetype_settings = {
    python = { tabstop = 4, shiftwidth = 4, expandtab = true },
    java   = { tabstop = 4, shiftwidth = 4, expandtab = true },
    c      = { tabstop = 8, shiftwidth = 8, expandtab = false},
  }

  local ft = vim.bo.filetype  -- Get the current buffer's filetype
  local settings = filetype_settings[ft]
  if settings then
    -- Apply the settings for this filetype
    vim.bo.tabstop = settings.tabstop
    vim.bo.shiftwidth = settings.shiftwidth
    vim.bo.expandtab = settings.expandtab
  end
end

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
  contrast = "soft", -- can be "hard", "soft" or empty string
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
--vim.o.background = "light"
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

local jdtls_config = {
  cmd = {
    '/home/jonas/git/jdt-language-server-1.30.1-202312071447/bin/jdtls',
    '-data',
    '/home/jonas/jdtls_workspace';
  },
  root_dir = vim.fn.getcwd(),
}

local function jdtls_setup(event)
  require'jdtls'.start_or_attach(jdtls_config)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = setup_filetype_settings
})

vim.api.nvim_create_autocmd('FileType', {
    group = java_cmds,
    pattern = { 'java' },
    desc = 'Setup jdtls',
    callback = jdtls_setup,
})

require'gitsigns'.setup()

-- Chat GPT API
require'gp'.setup{
  openai_api_key = os.getenv("OPENAI_API_KEY"),
  agents = {
  -- Disable existing default agents
  --  { name = "CodeGPT4o" },
  --  { name = "ChatGPT3-5" },
  --  { name = "CodeGPT3-5" },
    { name = "ChatGPT4o-mini",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-4o-mini", temperature = 0.8, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = "You are a general AI assistant.\n\n"
      	.. "The user provided the additional info about how they would like you to respond:\n\n"
      	.. "- If you're unsure don't guess and say you don't know instead.\n"
      	.. "- Ask question if you need clarification to provide better answer.\n"
      	.. "- Don't elide any code from your output if the answer requires coding.\n"
      	.. "- Give a short answer, if the question can be answered in a reasonable way.\n",
    },
    { name = "ChatGPT4o",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-4o", temperature = 0.8, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = "You are a general AI assistant.\n\n"
      	.. "The user provided the additional info about how they would like you to respond:\n\n"
      	.. "- If you're unsure don't guess and say you don't know instead.\n"
      	.. "- Ask question if you need clarification to provide better answer.\n"
      	.. "- Don't elide any code from your output if the answer requires coding.\n"
      	.. "- Give a short answer, if the question can be answered in a reasonable way.\n",
    },
    { name = "o1-mini",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "o1-mini", temperature = 0.8, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = "You are a general AI assistant.\n\n"
    },
    { name = "ChatGPT3-5", disable = true },
    {
      name = "CodeGPT4o",
      chat = false,
      command = true,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-4o", temperature = 0.8, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = "You are an AI working as a code editor.\n\n"
      	.. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
      	.. "START AND END YOUR ANSWER WITH:\n\n```",
    },
  },
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
