return {
    "axkirillov/unified.nvim",
    cmd = "Unified",
    keys = {
        {
            "<leader>gp",
            function()
                local sha = require("user.git").merge_base()
                if not sha then
                    vim.notify("unified: could not resolve PR base branch", vim.log.levels.ERROR)
                    return
                end
                vim.cmd("Unified " .. sha)
            end,
            desc = "Review Current PR (inline)",
        },
        {
            "<leader>gu",
            function()
                require("unified").toggle()
            end,
            desc = "Toggle inline diff (vs HEAD)",
        },
        { "<leader>gU", "<cmd>Unified reset<cr>", desc = "Close inline diff" },
        {
            "]h",
            function()
                require("unified.navigation").next_hunk()
            end,
            desc = "Next hunk",
        },
        {
            "[h",
            function()
                require("unified.navigation").previous_hunk()
            end,
            desc = "Prev hunk",
        },
    },
    opts = {
        file_tree = { focus = true },
    },
}
