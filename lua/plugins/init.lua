return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "lervag/vimtex",
    lazy = false,
    ft = "tex",
    init = function()
      vim.g.vimtex_quickfix_ignore_filters = {
        "Underfull",
        "Overfull",
        "Package fontspec Warning",
        "Package pgfplots Warning",
        "Package fancyhdr Warning",
      }
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        continuous = 1,
        callback = 1,
      }
    end,
  },
  {
    "jbyuki/nabla.nvim",
    ft = "tex",
    keys = {
      { "<leader>lp", function() require("nabla").popup() end, desc = "Equation preview" },
      { "<leader>lt", function() require("nabla").toggle_virt() end, desc = "Toggle inline math" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "markdown",
        "markdown_inline",
      },
      highlight = {
        enable = true,
        disable = { "latex" },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local conf = require "nvchad.configs.cmp"
      for _, source in ipairs(conf.sources) do
        if source.name == "nvim_lsp" then
          source.option = {
            markdown_oxide = {
              keyword_pattern = [[\(\k\| \|\/\|#\)\+]]
            }
          }
          break
        end
      end
      return conf
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
        enable = true,
        separator = " › ",
        hide_keyword = false,
        show_file = true,
        folder_level = 1,
        color_mode = true,
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "Zeioth/markmap.nvim",
    build = "yarn global add markmap-cli",
    cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
    config = function()
      require("markmap").setup({
        html_output = "/tmp/markmap.html",
        preview = true,
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        surrounds = {
          ["c"] = {
            add = function()
              local cmd = require("nvim-surround.config").get_input("Command: ")
              if cmd then
                return { { "\\" .. cmd .. "{" }, { "}" } }
              end
            end,
          },
        
          ["e"] = {
            add = function()
              local env = require("nvim-surround.config").get_input("Environment: ")
              if env then
                return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
              end
            end,
          },
        }
      })
    end,
  },
}
