vim.filetype.add({
  pattern = {
    ["roles/tasks/*.{yml,yaml}"] = "yaml.ansible",
    [".*/ansible/.*%.ya?ml"] = "yaml.ansible",
  },
})
