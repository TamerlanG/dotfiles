return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = {
        "DiffviewOpen",
        "DiffviewClose",
        "DiffviewToggleFiles",
        "DiffviewFocusFiles",
        "DiffviewRefresh",
        "DiffviewFileHistory",
    },
    keys = {
        {
            "<leader>gv",
            function()
                if next(require("diffview.lib").views) == nil then
                    vim.cmd("DiffviewOpen")
                else
                    vim.cmd("DiffviewClose")
                end
            end,
            desc = "Diffview Toggle",
        },
        {
            "<leader>gV",
            "<cmd>DiffviewFileHistory %<cr>",
            desc = "Diffview File History (current file)",
        },
        {
            "<leader>gp",
            function()
                local function git(...)
                    local out = vim.fn.systemlist({ "git", ... })
                    if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
                        return out[1]
                    end
                end
                local candidates = { "main", "master", "develop" }
                local function base()
                    for _, remote in ipairs({ "upstream", "origin" }) do
                        -- remote HEAD (set by clone or `git remote set-head <remote> -a`)
                        local ref = git("symbolic-ref", "-q", "--short", "refs/remotes/" .. remote .. "/HEAD")
                        if ref then
                            return ref
                        end
                        for _, b in ipairs(candidates) do
                            if git("rev-parse", "--verify", "-q", remote .. "/" .. b) then
                                return remote .. "/" .. b
                            end
                        end
                    end
                    for _, b in ipairs(candidates) do
                        if git("rev-parse", "--verify", "-q", b) then
                            return b
                        end
                    end
                end
                local ref = base()
                if not ref then
                    vim.notify("diffview: could not resolve PR base branch", vim.log.levels.ERROR)
                    return
                end
                vim.cmd("DiffviewOpen " .. ref .. "...HEAD --imply-local")
            end,
            desc = "Review Current PR (vs base branch)",
        },

        {
            "<leader>gH",
            "<cmd>DiffviewFileHistory<cr>",
            desc = "Diffview File History (repo)",
        },
    },
    opts = {
        enhanced_diff_hl = true,
        view = {
            merge_tool = {
                layout = "diff3_mixed",
                disable_diagnostics = true,
            },
        },
    },
}
