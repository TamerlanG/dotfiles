vim.filetype.add({
  pattern = {
    ["roles/tasks/*.{yml,yaml}"] = "yaml.ansible",
    ["*play*.{yml,yaml}"] = "yaml.ansible",
  },
})
