return {
  -- UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
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
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
    keys = {
      {"\\", "<CMD>Oil<CR>", mode = "n", desc = "Open parent directory"},
    },
  },
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    config = function()
      require 'plugin_configs.toggleterm'
    end,
  },

  -- Editor
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = true,
  },

  -- Completion
  {
    'saghen/blink.cmp',
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = {
      {
        'Kaiser-Yang/blink-cmp-dictionary',
        dependencies = { "nvim-lua/plenary.nvim" },
      }
    },
    opts = {
      keymap = {
        preset = "super-tab",
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ['<Right>'] = { 'cancel' },
      },
      cmdline = {
        keymap = {
          preset = "cmdline",
          ['<Down>'] = { 'select_next', 'fallback' },
          ['<Up>'] = { 'select_prev', 'fallback' },
          ['<Right>'] = { 'cancel' },
        }
      },
      sources = {
        default = { "dictionary", "snippets", "lsp", "path", "buffer" },
        providers = {
          dictionary = {
            module = 'blink-cmp-dictionary',
            name = 'Dict',
            min_keyword_length = 3,
            async = true,
            score_offset = -1000,
            max_items = 20,
            opts = {
              dictionary_files = { "/usr/share/dict/words" },
            },
          }
        },
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },
    },
    opts_extend = { "sources.default" },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate"
  },

  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {"<space><space>", "<CMD>Telescope commands<CR>", mode = "n", desc = "Open live grep"},
      {"<space>g", "<CMD>Telescope live_grep<CR>", mode = "n", desc = "Live grep"},
      {"<space>b", "<CMD>Telescope buffers<CR>", mode = "n", desc = "Open buffers"},
      {"<space>h", "<CMD>Telescope help_tags<CR>", mode = "n", desc = "Open help tags"},
    },
  },
  {
    "danielfalk/smart-open.nvim",
    config = function()
      require("telescope").load_extension("smart_open")
    end,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      "kkharji/sqlite.lua",
    },
    keys = {
      {"<space>f", "<CMD>Telescope smart_open<CR>", mode = "n", desc = "Open file with smart open"},
    },
  },

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Copilot
  {
    "github/copilot.vim",
    lazy=false,
    config = function()
      vim.g.copilot_filetypes = {
        gitcommit = true,
        markdown = true,
        yaml = true
      }
    end,
  },
}
