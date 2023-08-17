local servers = { 'clangd', 'pyright' }

local lspconfig = require('lspconfig')

lspconfig.clangd.setup{}
lspconfig.pyright.setup{}
