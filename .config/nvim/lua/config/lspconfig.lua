local lsp_util = require('config.lsp_util')

require('nvim-lsp-installer').on_server_ready(function(server)
  local opts = {
    capabilities = lsp_util.capabilities,
    on_attach = lsp_util.on_attach,
    -- handlers = {
    --   ["textDocument/publishDiagnostics"] = vim.lsp.with(
    --   vim.lsp.diagnostic.on_publish_diagnostics, {
    --     -- Disable virtual_text
    --     virtual_text = true
    --   })
    -- }
  }
  server:setup(opts)
end)

-- require'lspconfig'.clangd.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   cmd = {
--     "/mnt/filer-a-7/disk1/koudai/clang-terrier/latest/bin/clangd",
--     "--header-insertion=never"
--   },
--   filetypes = { "terrier", "c", "cpp", "objc", "objcpp", "cuda" }
-- })
