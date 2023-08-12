return {
	-- You can also add new plugins here as well:
	-- Add plugins, the lazy syntax
	-- "andweeb/presence.nvim",
	-- {
	--   "ray-x/lsp_signature.nvim",
	--   event = "BufRead",
	--   config = function()
	--     require("lsp_signature").setup()
	--   end,
	-- },
	{ 'mrjones2014/smart-splits.nvim', lazy = false },
	{
  	'tikhomirov/vim-glsl',
  	ft = {'glsl', 'vert', 'frag', 'geom'},
  	config = function()
    	-- configuration goes here
  	end
	},
	{
		'nvim-treesitter/playground',
		requires = {
			'nvim-treesitter/nvim-treesitter'
		},
		cmd = 'TSPlaygroundToggle',
		config = function()
			require "nvim-treesitter.configs".setup {
				playground = {
					enable = true,
					disable = {},
					updatetime = 25,    -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = 'o',
						toggle_hl_groups = 'i',
						toggle_injected_languages = 't',
						toggle_anonymous_nodes = 'a',
						toggle_language_display = 'I',
						focus_language = 'f',
						unfocus_language = 'F',
						update = 'R',
						goto_node = '<cr>',
						show_help = '?',
					},
				}
			}
		end
	},
	{

		'madskjeldgaard/cppman.nvim',
		requires = {
			{ 'MunifTanjim/nui.nvim' }
		},
		lazy = false,
		config = function()
			local cppman = require "cppman"
			cppman.setup()

			-- Make a keymap to open the word under cursor in CPPman
			vim.keymap.set("n", "<leader>mw", function()
				cppman.open_cppman_for(vim.fn.expand("<cword>"))
			end)

			-- Open search box
			vim.keymap.set("n", "<leader>mf", function()
				cppman.input()
			end)
		end
	}
}
-- opts = function()
--   -- Enabled it
--   return {
--     enabled = function()
--       return true
--     end
--   }
-- end,
