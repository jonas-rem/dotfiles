
-- Function to check if a file exists
local function file_exists(name)
  local f = io.open(name, "r")
  if f then f:close() end
  return f ~= nil
end

-- Decide which server to use based on the presence of files
local function get_server_config()
  if file_exists("compile_commands.json") then
    return "clangd"
  elseif file_exists("tags") then
    return "ctags"
  else
    return "clangd" -- default
  end
end

-- Set up your LSP server based on the configuration
local server = get_server_config()

vim.lsp.config.clangd = {
  cmd = { 'clangd', '--background-index' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp' },
}

vim.lsp.enable({'clangd'})

--vim.lsp.set_log_level("error")

-- Workaround for slow file indexing that leads to hangs and inferior performance
-- https://github.com/neovim/neovim/issues/23725#issuecomment-1561364086
local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
   -- disable lsp watcher. Too slow on linux
   wf._watchfunc = function()
     return function() end
   end
end
