local async = require("neotest.async")
local lib = require("neotest.lib")
local ts = lib.treesitter

async.run(function()
	local parse_queries = [[
      ;;query
      (TestDecl)
    ]]
	local tree = ts.parse_positions("main.zig", parse_queries)
	vim.print(tree:to_list())
end)
