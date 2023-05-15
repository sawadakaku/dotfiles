require('luasnip/loaders/from_vscode').load({
  paths = { '~/.local/share/nvim/site/pack/packer/start/friendly-snippets' }
})

vim.cmd [[command! EditSnippet lua require('luasnip.loaders').edit_snippet_files()]]

