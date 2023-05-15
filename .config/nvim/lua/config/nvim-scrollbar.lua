require("scrollbar").setup()
local ok, _ = pcall(require, 'hlslens')
if ok then
  require("scrollbar.handlers.search").setup()
end

