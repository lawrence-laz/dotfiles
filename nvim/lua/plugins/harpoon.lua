return {
	-- https://github.com/ThePrimeagen/init.lua/blob/249f3b14cc517202c80c6babd0f9ec548351ec71/after/plugin/harpoon.lua
	"ThePrimeagen/harpoon",
	config = function(_, opts)
		require "harpoon".setup({})
	end
}
