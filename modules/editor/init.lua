vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = false

vim.o.completeopt = "menuone,noselect,popup"
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = false
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.mouse = "nv"
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = false
vim.o.scrolloff = 10
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.wrap = false

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ "n" }, "<Leader>ef", ":Explore<CR>")
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>yy", '"+yy')
vim.keymap.set({ "n" }, "<leader>Y", '"+Y')
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.diagnostic.config {
  virtual_text = true
}

require"nvim-treesitter".install {
  "c",
  "bash",
  "sql",
  "markdown",
  "lua",
  "nix",
  "python",
  "javascript",
  "zig"
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "c",
    "bash",
    "sql",
    "markdown",
    "lua",
    "nix",
    "python",
    "javascript",
    "zig"
  },
  callback = function()
    vim.treesitter.start()
  end
})

vim.lsp.config("luals", {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  }
})

vim.lsp.enable("pyright")
vim.lsp.enable("ts_ls")
vim.lsp.enable("nixd")
vim.lsp.enable("luals")
vim.lsp.enable("marksman")
vim.lsp.enable("clangd")
vim.lsp.enable("gopls")
vim.lsp.enable("zls")
vim.lsp.enable("sqls")
vim.lsp.enable("bashls")

local builtin = require "telescope.builtin"
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
require("telescope").load_extension "fzf"

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function (event)
    vim.lsp.completion.enable(true, event.data.client_id, event.buf, {
      autotrigger = true
    })
    vim.keymap.set("n", "gd", builtin.lsp_definitions)
    vim.keymap.set("n", "gr", builtin.lsp_references)
    vim.keymap.set("n", "gI", builtin.lsp_implementations)
    vim.keymap.set("n", "<leader>D", builtin.lsp_type_definitions)
    vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols)
    vim.keymap.set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols)
    vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
    vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
  end
})

require("catppuccin").setup {
  flavour = "mocha",
  integrations = {
    mason = true,
    lsp_trouble = true,
  },
  color_overrides = {
    mocha = {
      base = "#000000",
      mantle = "#000000",
      crust = "#000000",
    },
  },
}

vim.cmd.colorscheme "catppuccin"

