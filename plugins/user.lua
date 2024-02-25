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
  { "mrjones2014/smart-splits.nvim", lazy = false },
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function()
      require("neo-tree").setup {
        filesystem = {
          hijack_netrw_behavior = "disabled", -- set to 'disabled' to not hijack netrw
        },
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  -- nerdtree
  -- {'preservim/nerdtree', lazy = false},
  -- netrw
  {
    "prichrd/netrw.nvim",
    config = function()
      require("netrw").setup {
        icons = {
          symlink = "", -- Symlink icon (directory and file)
          directory = "", -- Directory icon
          file = "", -- File icon
        },
        use_devicons = true, -- Uses nvim-web-devicons if true, otherwise use the file icon specified above
        mappings = {}, -- Custom key mappings
      }
    end,
    lazy = false,
  },
  {
    "tikhomirov/vim-glsl",
    ft = { "glsl", "vert", "frag", "geom" },
    config = function()
      -- configuration goes here
    end,
  },
  {
    "nvim-treesitter/playground",
    requires = {
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = "TSPlaygroundToggle",
    config = function()
      require("nvim-treesitter.configs").setup {
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
      }
    end,
  },
  {
    "fedepujol/move.nvim",
    opts = {
      --- Config
    },
  },
  {

    "madskjeldgaard/cppman.nvim",
    requires = {
      { "MunifTanjim/nui.nvim" },
    },
    lazy = false,
    config = function()
      local cppman = require "cppman"
      cppman.setup()

      -- Make a keymap to open the word under cursor in CPPman
      vim.keymap.set("n", "<leader>mw", function() cppman.open_cppman_for(vim.fn.expand "<cword>") end)

      -- Open search box
      vim.keymap.set("n", "<leader>mf", function() cppman.input() end)
    end,
  },
}
-- opts = function()
--   -- Enabled it
--   return {
--     enabled = function()
--       return true
--     end
--   }
-- end,
