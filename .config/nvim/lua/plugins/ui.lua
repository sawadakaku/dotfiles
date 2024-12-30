return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'config.plugins.lualine'
    end,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    event = 'VeryLazy',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      vim.cmd([[nnoremap \ :Neotree toggle reveal<cr>]])
    end,
  },
  {
    'stevearc/oil.nvim',
    event = 'VeryLazy',
    config = function()
      require("oil").setup()
      local map = require('utils').map
      map('n', '-', '<cmd>Oil<cr>')
    end,
  },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      chunk = {
        enable = true
      },
    }
  },
  {
    'kevinhwang91/nvim-bqf',
    event = 'VeryLazy',
    config = true,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
  {
    'petertriho/nvim-scrollbar',
    config = true
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      cmdline = {
        format = {
          copilot = { pattern = '^:%s*CopilotChat%s+', icon = '🤖' }
        }
      }
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    }
  },
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    config = function()
      require 'config.plugins.toggleterm'
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd[[colorscheme tokyonight]]
    end,
  },
  {
    'shortcuts/no-neck-pain.nvim',
    event = 'VeryLazy',
    config = function()
      vim.api.nvim_create_user_command('Zen', function(args)
        require('no-neck-pain').toggle()
      end, {})
    end,
  }
}
