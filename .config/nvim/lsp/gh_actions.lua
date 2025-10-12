local function fetch_github_repo(repo_name, token, org, workspace_path)
  local cmd = {
    "curl",
    "-H",
    "Authorization: Bearer " .. token,
    "-H",
    "User-Agent: Neovim",
    "https://api.github.com/repos/" .. org .. "/" .. repo_name,
  }

  local result = vim.system(cmd):wait()
  if not result or not result.stdout then
    print("No result from GitHub API")
    return {}
  end

  local raw_json = result.stdout
  if raw_json == "" then
    print("Empty JSON from GitHub API")
    return {}
  end

  local ok, data = pcall(vim.json.decode, raw_json)
  if not ok or type(data) ~= "table" then
    print("Failed to decode JSON from GitHub API")
    return {}
  end

  local repo_info = {
    id = data.id,
    owner = org,
    name = repo_name,
    workspaceUri = "file://" .. workspace_path,
    organizationOwned = true,
  }
  return repo_info
end

local get_gh_actions_init_options = function(org, workspace_path, session_token)
  org = org
  workspace_path = workspace_path or vim.fn.getcwd()
  session_token = session_token or os.getenv("GHCRIO")

  local function get_repo_name()
    local handle = io.popen("git remote get-url origin 2>/dev/null")
    if not handle then
      return nil
    end

    local result = handle:read("*a")
    handle:close()
    if not result or result == "" then
      return nil
    end
    -- Remove trailing newline
    result = result:gsub("%s+$", "")
    -- Extract repo name from URL
    local repo = result:match("([^/:]+)%.git$")
    return repo
  end
  local repo_name = get_repo_name()

  if not repo_name then
    print("Could not determine repository name from git remote")
    return {
      sessionToken = session_token,
      repos = {},
    }
  end

  local repo_info = fetch_github_repo(repo_name, session_token, org, workspace_path)
  return {
    sessionToken = session_token,
    repos = {
      repo_info,
    },
  }
end


return {
  cmd = { 'gh-actions-language-server', '--stdio' },
  filetypes = { 'yaml.github' },
  init_options = get_gh_actions_init_options("volvo-cars"),
  single_file_support = true,
  -- `root_dir` ensures that the LSP does not attach to all yaml files
  root_dir = function(bufnr, on_dir)
    local parent = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
    if
        vim.endswith(parent, '/.github/workflows')
    then
      on_dir(parent)
    end
  end,
  handlers = {
    ['actions/readFile'] = function(_, result)
      if type(result.path) ~= 'string' then
        return nil, { code = -32602, message = 'Invalid path parameter' }
      end
      local file_path = vim.uri_to_fname(result.path)
      if vim.fn.filereadable(file_path) == 1 then
        local f = assert(io.open(file_path, 'r'))
        local text = f:read('*a')
        f:close()
        return text, nil
      else
        return nil, { code = -32603, message = 'File not found: ' .. file_path }
      end
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
