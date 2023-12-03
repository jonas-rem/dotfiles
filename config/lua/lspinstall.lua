local servers = { 'clangd', 'pyright' }

local lspconfig = require('lspconfig')

lspconfig.clangd.setup{}

lspconfig.pyright.setup{
   settings = {
      python = {
         analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true
         }
      }
   }
}

-- Workaround for slow file indexing that leads to hangs and inferior performance
-- https://github.com/neovim/neovim/issues/23725#issuecomment-1561364086
local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
   -- disable lsp watcher. Too slow on linux
   wf._watchfunc = function()
     return function() end
   end
end
