local compile = function()
  local nightfox = require('nightfox')
  nightfox.setup({
    options = {
      -- Compiled file's destination location
      compile_path = vim.fn.stdpath("cache") .. "/nightfox",
      compile_file_suffix = "_compiled", -- Compiled file suffix
      transparent = true,    -- Disable setting background
      terminal_colors = false, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
      dim_inactive = true,   -- Non focused panes set to alternative background
      styles = {              -- Style to be applied to different syntax groups
        comments = "NONE",    -- Value is any valid attr-list value `:help attr-list`
        conditionals = "NONE",
        constants = "NONE",
        functions = "NONE",
        keywords = "NONE",
        numbers = "NONE",
        operators = "NONE",
        strings = "NONE",
        types = "NONE",
        variables = "NONE",
      },
      inverse = {             -- Inverse highlight for different types
        match_paren = false,
        visual = false,
        search = false,
      },
      modules = {             -- List of various plugins and additional options
        -- ...
      },
    }
  })
  nightfox.compile()
end
-- HACK: no need to call startup once this is compiled
compile()
vim.cmd("colorscheme nordfox")
