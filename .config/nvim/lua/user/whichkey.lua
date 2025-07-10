local status_ok, which_key = pcall(require, "which-key")
local status_ok_snacks, Snacks = pcall(require, "snacks")

if not status_ok or not status_ok_snacks then
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
  { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
  { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
  { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
  { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
  { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
  { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
  -- find
  { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
  { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
  { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
  { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
  { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
  { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
  -- git
  { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
  { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
  { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
  { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
  { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
  { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
  { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
  -- Grep
  { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
  { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
  { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
  { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
  -- search
  { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
  { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
  { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
  { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
  { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
  { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
  { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
  { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
  { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
  { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
  { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
  { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
  { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
  { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
  { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
  { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
  { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
  { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
  { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
  { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
  { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
  -- LSP
  { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
  { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
  { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
  { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
  { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
  { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
  { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
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
