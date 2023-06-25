return {
	-- Configure AstroNvim updates
	updater = {
		remote = "origin",   -- remote to use
		channel = "stable",  -- "stable" or "nightly"
		version = "latest",  -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "nightly",  -- branch name (NIGHTLY ONLY)
		commit = nil,        -- commit hash (NIGHTLY ONLY)
		pin_plugins = nil,   -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		auto_quit = false,   -- automatically quit the current session after a successful update
		remotes = {          -- easily add new remotes to track
			--   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
			--   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
			--   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
		},
	},

	-- Set colorscheme to use
	colorscheme = "astrodark",

	-- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
	diagnostics = {
		virtual_text = true,
		underline = true,
	},

	lsp = {
		-- customize lsp formatting options
		formatting = {
			-- control auto formatting on save
			format_on_save = {
				enabled = true, -- enable or disable format on save globally
				allow_filetypes = { -- enable format on save for specified filetypes only
					-- "go",
				},
				ignore_filetypes = { -- disable format on save for specified filetypes
					-- "python",
				},
			},
			disabled = { -- disable formatting capabilities for the listed language servers
				-- disable lua_ls formatting capability if you want to use StyLua to format your lua code
				-- "lua_ls",
			},
			timeout_ms = 1000, -- default format timeout
			-- filter = function(client) -- fully override the default formatting function
			--   return true
			-- end
		},
		-- enable servers that you already have installed without mason
		servers = {
			-- "pyright"
		},
	},

	-- Configure require("lazy").setup() options
	lazy = {
		defaults = { lazy = true },
		performance = {
			rtp = {
				-- customize default disabled vim plugins
				disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
			},
		},
	},

	-- This function is run last and is a good place to configuring
	-- augroups/autocommands and custom filetypes also this just pure lua so
	-- anything that doesn't fit in the normal config locations above can go here
	polish = function()
		-- Map <leader>qq to open a terminal in the current directory of the file
		vim.api.nvim_set_keymap("n", "<leader>qq", ":let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>Acd $VIM_DIR<CR>",
			{ noremap = true })

		-- Map cd to change directory to the current directory of the file
		vim.api.nvim_set_keymap("n", "cd", ":let $VIM_DIR=expand('%:p:h')<CR>:cd $VIM_DIR<CR>",
			{ noremap = true })
		-- Set up custom filetypes
		-- vim.filetype.add {
		--   extension = {
		--     foo = "fooscript",
		--   },
		--   filename = {
		--     ["Foofile"] = "fooscript",
		--   },
		--   pattern = {
		--     ["~/%.config/foo/.*"] = "fooscript",
		--   },
		-- }

		-- Map <leader>w to do the same thing that CTRL-W already does
		-- vim.api.nvim_set_keymap("n", "<leader>w", "<C-w>", { noremap = true })

		-- Map <ESC> to do what <CTRL-\> <CTRL-N> does to exit terminal mode
		vim.api.nvim_set_keymap("t", "<ESC>", "<C-\\><C-n>", { noremap = true })

		-- Map go to definition to gd
		-- For some reason the automatic ones don't always come up
		-- https://github.com/neovim/nvim-lspconfig
		vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
		vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true })
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { noremap = true })
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { noremap = true })
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { noremap = true })
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { noremap = true })
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { noremap = true })
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { noremap = true })
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { noremap = true })
		vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, { noremap = true })
		vim.keymap.set('n', '<space>la', vim.lsp.buf.code_action, { noremap = true })
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true })


		-- Change local dir to ~/bar on startup
		vim.cmd("cd ~/bar")

		-- Fix error "warning: multiple different client offset_encodings detected for buffer, this is not supported yet
		-- https://www.reddit.com/r/neovim/comments/wmj8kb/i_have_nullls_and_clangd_attached_to_a_buffer_c/
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.offsetEncoding = 'utf-8'
		require('lspconfig').clangd.setup {
			capabilities = capabilities
		}

		-- Keymappings for smart splits
		-- https://github.com/mrjones2014/smart-splits.nvim
		vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left, { noremap = true })
		vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down, { noremap = true })
		vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up, { noremap = true })
		vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right, { noremap = true })
		-- moving between split
		vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { noremap = true })
		vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { noremap = true })
		vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { noremap = true })
		vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { noremap = true })
		-- swapping buffers between window
		vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left, { noremap = true })
		vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down, { noremap = true })
		vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up, { noremap = true })
		vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right, { noremap = true })
	end,
}
