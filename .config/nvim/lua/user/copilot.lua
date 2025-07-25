require("copilot").setup({
  panel = {
    enabled = false,
  },
  suggestion = {
    enabled = false,
    auto_trigger = true,
    debounce = 75,
  },
  filetypes = {
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
    yaml = true,
  },
  copilot_node_command = "node", -- Node.js version must be > 16.x
  server_opts_overrides = {},
})
