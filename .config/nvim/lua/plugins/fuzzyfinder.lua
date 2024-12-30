return {
  {
    'prochri/telescope-all-recent.nvim',
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
      -- optional, if using telescope for vim.ui.select
      "stevearc/dressing.nvim"
    },
  },
  {
    'nvim-telescope/telescope-ui-select.nvim'
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      '<leader>f',
      '<leader>g',
      '<leader>b',
      '<leader>h',
    },
    opts = {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {
            -- even more opts
          }
        }
      }
    },
    config = function()
      local builtin = require('telescope.builtin')
      local map = require('utils').map
      map('n', '<leader>f', function() require'telescope.builtin'.find_files() end, { desc = 'Telescope find files' })
      map('n', '<leader>g', builtin.live_grep, { desc = 'Telescope live grep' })
      map('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' })
      map('n', '<leader>h', builtin.help_tags, { desc = 'Telescope help tags' })
      require('telescope').load_extension('ui-select')
    end
  },
}
