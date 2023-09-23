local pickers = require "telescope.pickers"            -- Main module which is used to create a new picker
local finders = require "telescope.finders"            -- Provides interfaces to fill the picker with items
local conf = require("telescope.config").values        -- User configuration
local actions = require "telescope.actions"            -- Holds all actions that can be mapped by a user
local action_state = require "telescope.actions.state" -- Gives us a few utility functions we can use to get the current picker, current selection or current line

package.loaded['scripts.my-commands'] = nil

local commands = {
	{ name = "Git: Blame",          exec = require 'gitsigns'.blame_line },
	{ name = "Git: Toggle deleted", exec = require 'gitsigns'.toggle_deleted },
	{ name = "blue",                exec = "" },
}

local my_commands = function(opts)
	opts = opts or {}
	pickers.new(opts, {
		prompt_title = "my_commands",
		finder = finders.new_table {
			results = commands,
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry.name,
					ordinal = entry.name,
				}
			end
		},
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				-- print(vim.inspect(selection))
				-- vim.api.nvim_put({ selection[1] }, "", false, true)
				print(vim.inspect(selection.value.exec))
				if type(selection.value.exec) == "string" then
					vim.cmd(selection.value.exec)
				elseif type(selection.value.exec) == "function" then
					-- print(vim.inspect(selection.value.exec))
					selection.value.exec()
				end
			end)
			return true
		end,
	}):find()
end

local M = function()
	my_commands(require("telescope.themes").get_dropdown {})
end

M()

return M
