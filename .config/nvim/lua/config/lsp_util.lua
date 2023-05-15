-- ╒══════════════════════════════════════════════════════════╕
-- │                        on_attach                         │
-- ╘══════════════════════════════════════════════════════════╛

local on_attach = function(_, _)
    local map = vim.api.nvim_set_keymap
    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {silent = true, noremap = true})
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {silent = true, noremap = true})
    map('v', '=', "<cmd>lua vim.lsp.buf.range_formatting()<CR>", {noremap = true})
    -- map("v", "gl", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", {noremap = true})
end

local ok, _ = pcall(require, 'lspsaga')
if ok then
  local on_attach_original = on_attach
  on_attach = function(client, bufnr)
    on_attach_original(client, bufnr)
    local map = vim.api.nvim_set_keymap
    map("n", "gr", "<cmd>Lspsaga rename<cr>", {silent = true, noremap = true})
    map("n", "gx", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
    map("x", "gx", ":<c-u>Lspsaga range_code_action<cr>", {silent = true, noremap = true})
    map("n", "K",  "<cmd>Lspsaga hover_doc<cr>", {silent = true, noremap = true})
    map("n", "gh", "<cmd>Lspsaga show_line_diagnostics<cr>", {silent = true, noremap = true})
    map("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})
    map("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})
    -- map("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
    -- map("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})
  end
end

local ok, aerial = pcall(require, 'aerial')
if ok then
  local on_attach_old = on_attach
  on_attach = function(client, bufnr)
    on_attach_old(client, bufnr)
    aerial.on_attach(client, bufnr)
  end
end


-- ╒══════════════════════════════════════════════════════════╕
-- │                       capabilities                       │
-- ╘══════════════════════════════════════════════════════════╛

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
end

return {
  on_attach = on_attach,
  capabilities = capabilities
}
