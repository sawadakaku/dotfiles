local utils = require('utils')
local opt = utils.opt
local autocmd = utils.autocmd
local map = utils.map

map('n', '<Leader>ff', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], {noremap = true})
-- map('n', '<Leader>r', [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], {noremap = true})
map('n', '<Leader>b', [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], {noremap = true})
map('n', '<Leader>fh', [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], {noremap = true})
map('n', '<Leader>fo', [[<Cmd>lua require('telescope.builtin').jumplist()<CR>]], {noremap = true})

require('telescope').setup({
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    live_grep_args = {
      auto_quoting = true
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
})
require('telescope').load_extension('fzf')
local ok, _ = pcall(require, 'notify')
if ok then
  require('telescope').load_extension('notify')
  map('n', '<Leader>fn', [[<Cmd>lua require('telescope').extensions.notify.notify()<CR>]], {noremap = true})
end

-- local ok, _ = pcall(require, 'neoclip')
-- if ok then
--   require('telescope').load_extension('neoclip')
--   vim.api.nvim_set_keymap('n', '<Leader>fc', [[<Cmd>lua require('telescope').extensions.neoclip.neoclip()<CR>]], {noremap = true})
-- end
local ok, _ = pcall(require, 'aerial')
if ok then
  require('telescope').load_extension('aerial')
  map('n', '<Leader>fa', [[<Cmd>lua require('telescope').extensions.aerial.aerial()<CR>]], {noremap = true})
end

require('telescope').load_extension('frecency')
map("n", "<leader><leader>", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", {noremap = true})

require("telescope").load_extension("live_grep_args")
map("n", "<leader>r", "<Cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", {noremap = true})

require("telescope").load_extension("ui-select")
