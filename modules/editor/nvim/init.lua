vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = false

vim.g.loaded_perl_provider = false
vim.g.loaded_ruby_provider = false
vim.g.loaded_python3_provider = false
vim.g.loaded_node_provider = false

vim.o.completeopt = "menuone,noselect"
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
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>yy", [["+yy]])
vim.keymap.set({ "n" }, "<leader>Y", [["+Y]])
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.diagnostic.config {
  virtual_text = true
}

require("nvim-treesitter.configs").setup {
  highlight = { enable = true },
}

local cmp = require "cmp"
local luasnip = require "luasnip"

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = { completeopt = "menu,menuone,noinsert" },

  mapping = cmp.mapping.preset.insert {
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-y>"] = cmp.mapping.confirm { select = false },
    ["<C-Space>"] = cmp.mapping.complete {},
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
local servers = {
  ts_ls = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  },
  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
  },
  nixd = {
    cmd = { "nixd" },
    filetypes = { "nix" },
    root_markers = { "flake.nix", ".git" },
  },
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
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
    },
  },
}

for name, config in pairs(servers) do
  config.capabilities = capabilities
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end

local builtin = require "telescope.builtin"
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
require("telescope").load_extension "fzf"

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function ()
    local builtin = require("telescope.builtin")
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

