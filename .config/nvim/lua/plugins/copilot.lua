return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = false,
      auto_trigger = true,
    },
    copilot_node_command = "node",
    filetypes = {
      javascript = true,
      typescript = true,
      lua = true,
      yaml = true,
      markdown = true,
    }
  }
}
