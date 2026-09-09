local ft_js = {
  "tsx",
  "jsx",
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
}

--- Get project root directory
---@return string|nil
function get_project_root()
  return vim.fs.root(0, ".git") or vim.env.PWD
end

return {
  {
    "pmizio/typescript-tools.nvim",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    ft = ft_js,
    opts = {
      settings = {
        code_lens = "off",
        complete_function_calls = false,
        include_completions_with_insert_text = true,
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        tsserver_path = nil,
        tsserver_max_memory = 32000,
        tsserver_format_options = {
          allowIncompleteCompletions = false,
        },
        tsserver_file_preferences = {
          completions = { completeFunctionCalls = false },
          includeInlayParameterNameHints = "none",
          includeCompletionsForModuleExports = true,
          init_options = {
            preferences = {
              disableSuggestions = true,
            },
          },
          importModuleSpecifierPreference = "project-relative",
          jsxAttributeCompletionStyle = "braces",
        },
        tsserver_locale = "en",
        disable_member_code_lens = true,
        jsx_close_tag = { enable = false },
      },
      root_dir = function(bufnr, onDir)
        onDir(get_project_root())
      end,
    },
  },
  {
    "dmmulroy/tsc.nvim",
    opts = {
      auto_start_watch_mode = false,
      use_trouble_qflist = false,
      flags = {
        watch = false,
      },
    },
    keys = {
      { "<leader>lf", ft = { "typescript", "typescriptreact" }, "<cmd>TSC<cr>",     desc = "Type Check" },
      { "<leader>lc", ft = { "typescript", "typescriptreact" }, "<cmd>TSCOpen<cr>", desc = "Type Check Quickfix" },
    },
    ft = {
      "typescript",
      "typescriptreact",
    },
    cmd = {
      "TSC",
      "TSCOpen",
      "TSCClose",
    },
  },
}
