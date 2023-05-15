require("todo-comments").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

local ok, _ = pcall(require, 'trouble')
if ok then
  vim.api.nvim_set_keymap("n", "<leader>xt", "<cmd>TodoTrouble<cr>", {silent = true, noremap = true})
end
