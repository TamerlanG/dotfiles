return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    linters = {
      eslint_d = {
        args = {
          "--no-warn-ignored",
          "--format",
          "json",
          "--stdin",
          "--stdin-filename",
          function()
            return vim.api.nvim_buf_get_name(0)
          end,
        },
      },
    },
  },
  config = function()
    local lint = require("lint")

    -- normal setup
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
      markdown = { "vale" },
    }

    -- helper: check if eslint config exists in project root
    local function has_eslint_config()
      local configs = {
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        "eslint.config.js",
        "eslint.config.cjs",
        "eslint.config.mjs",
      }

      local cwd = vim.fn.getcwd()
      for _, name in ipairs(configs) do
        if vim.fn.filereadable(cwd .. "/" .. name) == 1 then
          return true
        end
      end
      return false
    end

    -- autocommand for linting
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd("BufWritePost", {
      group = lint_augroup,
      callback = function()
        local ft = vim.bo.filetype
        -- only run eslint_d if there’s config
        if ft:match("javascript") or ft:match("typescript") or ft == "svelte" then
          if has_eslint_config() then
            lint.try_lint("eslint_d")
          end
        else
          lint.try_lint()
        end
      end,
    })
  end,
}
