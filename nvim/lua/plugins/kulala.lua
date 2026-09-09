local function repair_kulala_queries()
  local query_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "queries", "kulala_http")
  local source_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "kulala.nvim", "tree-sitter-kulala-http", "queries", "kulala_http")
  local stat = vim.uv.fs_lstat(query_dir)

  if stat and (stat.type ~= "link" or vim.uv.fs_stat(query_dir)) then
    return
  end

  if stat and stat.type == "link" then
    local ok = vim.uv.fs_unlink(query_dir)

    if not ok then
      return
    end
  end

  if not vim.uv.fs_stat(source_dir) then
    return
  end

  vim.fn.mkdir(query_dir, "p")

  for name, kind in vim.fs.dir(source_dir) do
    if kind == "file" then
      vim.uv.fs_copyfile(vim.fs.joinpath(source_dir, name), vim.fs.joinpath(query_dir, name))
    end
  end
end

local function setup_kulala(_, opts)
  repair_kulala_queries()

  local logger = require("kulala.logger")
  local notify = logger.notify

  logger.notify = function(message, ...)
    if message == "Tree-sitter parser is ready!" then
      return
    end

    return notify(message, ...)
  end

  require("kulala").setup(opts)
end

return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  config = setup_kulala,
  opts = {
    ui = {
      max_response_size = 5000000, -- 1MB
    },
  },
}
