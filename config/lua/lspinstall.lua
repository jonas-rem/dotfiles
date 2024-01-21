local function find_compile_commands(folders)
    for _, folder in ipairs(folders) do
       local cc_json_path = vim.fn.glob(vim.fn.fnamemodify(folder, ':p') .. "compile_commands.json")
       if vim.fn.filereadable(cc_json_path) == 1 then
           return cc_json_path
       end
    end
    return nil
end

local compile_commands_path = find_compile_commands({
    "build",
    "armgcc",
})


local servers = { 'clangd', 'ccls', 'pyright' }
local lspconfig = require('lspconfig')
local clangd_cmd = {"clangd"}

if compile_commands_path then
    table.insert(clangd_cmd, "--compile-commands-dir=" .. compile_commands_path)
end

--vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'
--lspconfig.ccls.setup {
--  init_options = {
--    compilationDatabaseDirectory = "build";
--    index = {
--      threads = 0;
--    };
--    clang = {
--      excludeArgs = { "-frounding-math"} ;
--    };
--  }
--}
--
lspconfig.clangd.setup {
    --cmd = clangd_cmd,
    --root_dir = function()
    --    return vim.fn.getcwd()
    --end
}

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

vim.lsp.set_log_level("debug")

-- Workaround for slow file indexing that leads to hangs and inferior performance
-- https://github.com/neovim/neovim/issues/23725#issuecomment-1561364086
local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
   -- disable lsp watcher. Too slow on linux
   wf._watchfunc = function()
     return function() end
   end
end
