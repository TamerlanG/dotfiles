---@brief
--- https://github.com/lttb/gh-actions-language-server
---
--- Language server for GitHub Actions.
---
--- The projects [forgejo](https://forgejo.org/) and [gitea](https://about.gitea.com/)
--- design their actions to be as compatible to github as possible
--- with only [a few differences](https://docs.gitea.com/usage/actions/comparison#unsupported-workflows-syntax) between the systems.
--- The `gh_actions_ls` is therefore enabled for those `yaml` files as well.
---
--- The `gh-actions-language-server` can be installed via `npm`:
---
--- ```sh
--- npm install -g gh-actions-language-server
--- ```

return {
  cmd = { 'gh-actions-language-server', '--stdio' },
  filetypes = { 'yaml.github' },
  init_options = { sessionToken = vim.env.GHCRIO },
  single_file_support = true,
  -- `root_dir` ensures that the LSP does not attach to all yaml files
  root_dir = function(bufnr, on_dir)
    local parent = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
    if
        vim.endswith(parent, '/.github/workflows')
        or vim.endswith(parent, '/.forgejo/workflows')
        or vim.endswith(parent, '/.gitea/workflows')
    then
      on_dir(parent)
    end
  end,
  handlers = {
    ["textDocument/publishDiagnostics"] = function(err, result, ctx)
      --
      result.diagnostics = vim.tbl_filter(function(diagnostic)
        -- silence annoying context warnings https://github.com/github/vscode-github-actions/issues/222
        if diagnostic.message:match("Context access might be invalid:") then
          return false
        end

        return true
      end, result.diagnostics)

      vim.lsp.handlers[ctx.method](err, result, ctx)
    end,
  },

  capabilities = {
    workspace = {
      didChangeWorkspaceFolders = {
        dynamicRegistration = true,
      },
    },
  },
}
