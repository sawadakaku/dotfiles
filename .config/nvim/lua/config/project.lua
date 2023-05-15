local utils = require('utils')
local map = utils.map

require('project_nvim').setup()

require('telescope').load_extension('projects')
map("n", "<leader>p", "<Cmd>lua require('telescope').extensions.projects.projects()<CR>", {noremap = true})
