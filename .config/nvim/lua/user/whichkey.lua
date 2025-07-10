local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  print("Failed to load which-key")
  return
end

-- Setup configuration for which-key
local setup = {
  preset = "modern",
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  win = {
    border = "rounded",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 2, 2, 2, 2 },
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
  show_help = true,
}

-- Key mappings specification
local spec = {
  -- Telescope related mappings
  {
    "<leader>F",
    "<cmd>Telescope live_grep theme=ivy<cr>",
    desc = "Find Text",
    nowait = true,
    remap = false,
  },
  {
    "<leader>f",
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false}, { hidden = true })<cr>",
    desc = "Find files",
    nowait = true,
    remap = false,
  },
  {
    "<leader>t",
    group = "Telescope",
    nowait = true,
    remap = false,
  },
  {
    "<leader>ty",
    "<cmd>Telescope yaml_schema<cr>",
    desc = "Yaml Schema",
    nowait = true,
    remap = false,
  },

  -- Buffer related mappings
  {
    "<leader>b",
    group = "Buffers",
    nowait = true,
    remap = false,
  },
  {
    "<leader>bb",
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    desc = "List Buffers",
  },
  {
    "<leader>bo",
    "<cmd>%bd|e#<cr>",
    desc = "Close all buffers except current",
  },

  -- Git related mappings
  {
    "<leader>g",
    group = "Git",
    nowait = true,
    remap = false,
  },
  {
    "<leader>gR",
    "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
    desc = "Reset Buffer",
    nowait = true,
    remap = false,
  },
  {
    "<leader>gb",
    "<cmd>Telescope git_branches<cr>",
    desc = "Checkout branch",
    nowait = true,
    remap = false,
  },
  {
    "<leader>gc",
    "<cmd>Telescope git_commits<cr>",
    desc = "Checkout commit",
    nowait = true,
    remap = false,
  },
  {
    "<leader>gd",
    "<cmd>Gitsigns diffthis HEAD<cr>",
    desc = "Diff",
    nowait = true,
    remap = false,
  },
  {
    "<leader>gg",
    "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
    desc = "Lazygit",
    nowait = true,
    remap = false,
  },
  {
    "<leader>gj",
    "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
    desc = "Next Hunk",
    nowait = true,
    remap = false,
  },
  {
    "<leader>gk",
    "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
    desc = "Prev Hunk",
    nowait = true,
    remap = false,
  },
  {
    "<leader>gl",
    "<cmd>lua require 'gitsigns'.blame_line()<cr>",
    desc = "Blame",
    nowait = true,
    remap = false,
  },
  {
    "<leader>go",
    "<cmd>Telescope git_status<cr>",
    desc = "Open changed file",
    nowait = true,
    remap = false,
  },
  {
    "<leader>gp",
    "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
    desc = "Preview Hunk",
    nowait = true,
    remap = false,
  },
  {
    "<leader>gr",
    "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
    desc = "Reset Hunk",
    nowait = true,
    remap = false,
  },
  {
    "<leader>gs",
    "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
    desc = "Stage Hunk",
    nowait = true,
    remap = false,
  },
  {
    "<leader>gu",
    "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
    desc = "Undo Stage Hunk",
    nowait = true,
    remap = false,
  },

  -- LSP related mappings
  {
    "<leader>l",
    group = "LSP",
    nowait = true,
    remap = false,
    icon = { icon = "🔍" },
  },
  {
    "<leader>lI",
    "<cmd>Mason<cr>",
    desc = "Installer Info",
    nowait = true,
    remap = false,
  },
  {
    "<leader>lf",
    function()
      require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end,
    desc = "Format",
    remap = false,
  },
  {
    "<leader>li",
    "<cmd>LspInfo<cr>",
    desc = "Info",
    nowait = true,
    remap = false,
  },
  {
    "<leader>lj",
    "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
    desc = "Next Diagnostic",
    nowait = true,
    remap = false,
  },
  {
    "<leader>lk",
    "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
    desc = "Prev Diagnostic",
    nowait = true,
    remap = false,
  },
  {
    "<leader>ll",
    function()
      require("lint").try_lint()
    end,
    desc = "Lint File",
    nowait = true,
    remap = false,
  },
  {
    "<leader>lq",
    "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",
    desc = "Quickfix",
    nowait = true,
    remap = false,
  },
  {
    "<leader>lr",
    "<cmd>lua vim.lsp.buf.rename()<cr>",
    desc = "Rename",
    nowait = true,
    remap = false,
  },
  {
    "<leader>ls",
    "<cmd>Telescope lsp_document_symbols<cr>",
    desc = "Document Symbols",
    nowait = true,
    remap = false,
  },
  {
    "<leader>lw",
    "<cmd>Telescope lsp_workspace_diagnostics<cr>",
    desc = "Workspace Diagnostics",
    nowait = true,
    remap = false,
  },

  -- Search
  {
    "<leader>s",
    group = "Search",
    nowait = true,
    remap = false,
  },
  {
    "<leader>sC",
    "<cmd>Telescope commands<cr>",
    desc = "Commands",
    nowait = true,
    remap = false,
  },
  {
    "<leader>sM",
    "<cmd>Telescope man_pages<cr>",
    desc = "Man Pages",
    nowait = true,
    remap = false,
  },
  {
    "<leader>sR",
    "<cmd>Telescope registers<cr>",
    desc = "Registers",
    nowait = true,
    remap = false,
  },
  {
    "<leader>sb",
    "<cmd>Telescope git_branches<cr>",
    desc = "Checkout branch",
    nowait = true,
    remap = false,
  },
  {
    "<leader>sc",
    "<cmd>Telescope colorscheme<cr>",
    desc = "Colorscheme",
    nowait = true,
    remap = false,
  },
  {
    "<leader>sh",
    "<cmd>Telescope help_tags<cr>",
    desc = "Find Help",
    nowait = true,
    remap = false,
  },
  {
    "<leader>sk",
    "<cmd>Telescope keymaps<cr>",
    desc = "Keymaps",
    nowait = true,
    remap = false,
  },
  {
    "<leader>sr",
    "<cmd>Telescope oldfiles<cr>",
    desc = "Open Recent File",
    nowait = true,
    remap = false,
  },


  -- Neovim Configs
  {
    "<leader>p",
    group = "Configs",
  },
  {
    "<leader>pl",
    "<cmd>Lazy<cr>",
    desc = "Lazy",
    nowait = true,
    remap = false,
    icon = { icon = "🦥" },
  },

  -- Other mappings
  {
    "<leader>e",
    "<cmd>NvimTreeToggle<cr>",
    desc = "Explorer",
    nowait = true,
    remap = false,
    icon = { icon = "🌲" },
  },
  {
    "<leader>w",
    "<cmd>w!<CR>",
    desc = "Save",
    nowait = true,
    remap = false,
  },
}

-- Apply the setup and key mappings
which_key.setup(setup)
which_key.add(spec)
