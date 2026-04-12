local config = {
  virtual_lines = { current_line = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "single",
    source = "always",
    header = "",
    prefix = "",
    suffix = "",
  },
}

local icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = "󰊕 ",
  Interface = " ",
  Keyword = " ",
  Method = "ƒ ",
  Module = "󰏗 ",
  Property = " ",
  Snippet = " ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

-- Icons
local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
  completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end


vim.diagnostic.config(config)
vim.lsp.enable("typescript", { filetype = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" } })
vim.lsp.enable("lua_ls", { filetype = "lua" })
vim.lsp.enable("yaml", { filetype = { "yaml", "yaml.buildkite", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" } })
vim.lsp.enable("python", { filetype = "python" })
vim.lsp.enable("go", { filetype = { "go", "gomod", "gowork", "gotmpl" } })
vim.lsp.enable("zig", { filetype = { "zig", "zir" } })
vim.lsp.enable("gh_actions", { filetype = "yaml.ghactions" })
vim.lsp.enable("terraform", { filetype = { "terraform", "terraform-vars", "tf" } })
vim.lsp.enable("ansible", { filetype = "yaml.ansible" })
vim.lsp.enable("c", { filetype = { "c", "cpp", "objc", "objcpp", "cuda" } })
vim.lsp.enable("racket", { filetype = "racket" })
vim.lsp.enable("bash", { filetype = { "bash", "sh" } })
