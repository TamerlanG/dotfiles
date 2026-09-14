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
            "<leader>gP",
            function()
                local ref = require("user.git").base_branch()
                if not ref then
                    vim.notify("diffview: could not resolve PR base branch", vim.log.levels.ERROR)
                    return
                end
                vim.cmd("DiffviewOpen " .. ref .. "...HEAD --imply-local")
            end,
            desc = "Review Current PR (side-by-side)",
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
