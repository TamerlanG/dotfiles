-- Inline PR review: diff every buffer against merge-base(base, HEAD), show
-- deleted lines as virtual text, highlight added/changed lines, word-diff
-- within changed lines, and list all hunks across the repo in quickfix.
local function toggle_pr_review()
    local gs = require("gitsigns")
    if require("gitsigns.config").config.base ~= nil then
        gs.toggle_deleted(false)
        gs.toggle_linehl(false)
        gs.toggle_word_diff(false)
        gs.reset_base(true)
        vim.cmd.cclose()
        return
    end
    local sha = require("user.git").merge_base()
    if not sha then
        vim.notify("gitsigns: could not resolve PR base branch", vim.log.levels.ERROR)
        return
    end
    gs.change_base(sha, true, function()
        gs.toggle_deleted(true)
        gs.toggle_linehl(true)
        gs.toggle_word_diff(true)
        gs.setqflist("all")
    end)
end

return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        { "<leader>gp", toggle_pr_review, desc = "Review Current PR (inline, toggle)" },
    },
    opts = {
        on_attach = function(bufnr)
            local gs = require("gitsigns")
            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
            end

            map("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gs.nav_hunk("next")
                end
            end, "Next hunk")
            map("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gs.nav_hunk("prev")
                end
            end, "Prev hunk")

            map("n", "<leader>gh", gs.preview_hunk_inline, "Preview hunk")
            map("n", "<leader>ga", gs.stage_hunk, "Stage hunk")
            map("v", "<leader>ga", function()
                gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Stage selection")
            map("n", "<leader>gA", gs.stage_buffer, "Stage buffer")
            map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
            map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
            map("v", "<leader>gr", function()
                gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Reset selection")
            map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
            map("n", "<leader>gv", gs.diffthis, "Diff this file (side-by-side)")
            map("n", "<leader>gw", function()
                gs.blame_line({ full = true })
            end, "Blame line")
            map("n", "<leader>gt", gs.toggle_current_line_blame, "Toggle line blame")
            map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
        end,
    },
}
