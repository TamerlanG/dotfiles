vim.filetype.add({
  filename = {
    ["buildkite.yml"] = "yaml.buildkite",
    ["buildkite.yaml"] = "yaml.buildkite",
  },
  pattern = {
    ["buildkite%..*%.yml"] = "yaml.buildkite",
    ["buildkite%..*%.yaml"] = "yaml.buildkite",
    [".*/.buildkite/pipeline%.yml"] = "yaml.buildkite",
    [".*/.buildkite/pipeline%.yaml"] = "yaml.buildkite",
    [".*/.buildkite/pipeline%..*%.yml"] = "yaml.buildkite",
    [".*/.buildkite/pipeline%..*%.yaml"] = "yaml.buildkite",
    [".*/.buildkite/pipelines/.*%.yml"] = "yaml.buildkite",
    [".*/.buildkite/pipelines/.*%.yaml"] = "yaml.buildkite",
    [".*/.buildkite/steps/.*%.yml"] = "yaml.buildkite",
  },
})
