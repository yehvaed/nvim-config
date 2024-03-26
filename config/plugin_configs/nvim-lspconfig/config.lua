local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
  require('lspconfig')[server].setup({
    capabilities = lsp_capabilities
  })
end

local lsp = require('lspconfig')
lsp.gopls.setup({})
