require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "texlab", "markdown_oxide", "pyright" }
vim.lsp.enable(servers)

local nvlsp = require "nvchad.configs.lspconfig"

vim.lsp.config("markdown_oxide", {
  on_init = nvlsp.on_init,
  capabilities = vim.tbl_deep_extend('force',
    nvlsp.capabilities,
    {
      workspace = {
        didChangeWatchedFiles = { dynamicRegistration = true }
      }
    }
  ),
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
  end,
})
