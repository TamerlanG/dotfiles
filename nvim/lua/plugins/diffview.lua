-- Side-by-side diffs and history in a dedicated tab. Every opener toggles: if
-- the current tab is already a diffview, it closes instead.
local function toggle(cmd)
    return function()
        if require("diffview.lib").get_current_view() then
            vim.cmd("DiffviewClose")
        else
            vim.cmd(cmd)
        end
    end
end

local function git(top, args)
    local res = vim.system(vim.list_extend({ "git", "-C", top }, args), { text = true }):wait()
    return res.code == 0 and res.stdout or nil
end

local function split_z(out)
    return vim.split(out or "", "\0", { trimempty = true })
end

-- Diffview never lists untracked files when the left side is a commit
-- (GitAdapter:show_untracked). Mark them intent-to-add so `git diff <sha>`
-- reports them as added, and drop those index entries again when that view
-- closes (view_closed fires for every view, hence the identity check).
---@type { top: string, paths: string[], view: table|nil }|nil
local intent_to_add

---@param view? table closed view; nil releases unconditionally
local function release_untracked(view)
    if not intent_to_add or (view and view ~= intent_to_add.view) then
        return
    end
    local top, paths = intent_to_add.top, intent_to_add.paths
    intent_to_add = nil
    -- Keep anything the user really staged while the view was open;
    -- intent-to-add entries are not listed by `diff --cached`.
    local staged = {}
    for _, p in ipairs(split_z(git(top, { "diff", "--cached", "--name-only", "-z" }))) do
        staged[p] = true
    end
    local reset = vim.tbl_filter(function(p)
        return not staged[p]
    end, paths)
    if #reset > 0 then
        git(top, vim.list_extend({ "reset", "-q", "--" }, reset))
    end
end

local function track_untracked()
    local top = vim.trim(git(vim.fn.getcwd(), { "rev-parse", "--show-toplevel" }) or "")
    if top == "" then
        return
    end
    local paths = split_z(git(top, { "ls-files", "-z", "--others", "--exclude-standard" }))
    if #paths > 0 and git(top, vim.list_extend({ "add", "--intent-to-add", "--" }, paths)) then
        intent_to_add = { top = top, paths = paths }
    end
end

-- Working tree vs merge-base(base, HEAD): everything this branch would merge,
-- including uncommitted and untracked changes. Same base as gitsigns' inline
-- <leader>gp.
local function pr_diff()
    if require("diffview.lib").get_current_view() then
        vim.cmd("DiffviewClose")
        return
    end
    local sha = require("user.git").merge_base()
    if not sha then
        vim.notify("diffview: could not resolve PR base branch", vim.log.levels.ERROR)
        return
    end
    track_untracked()
    vim.cmd("DiffviewOpen " .. sha)
    if intent_to_add then
        intent_to_add.view = require("diffview.lib").get_current_view()
        if not intent_to_add.view then
            release_untracked()
        end
    end
end

local close = { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } }

return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
        { "<leader>gD", toggle("DiffviewOpen"), desc = "Diff working tree (tab)" },
        { "<leader>gP", pr_diff, desc = "Review PR (diffview, toggle)" },
        { "<leader>gH", toggle("DiffviewFileHistory"), desc = "Repo history" },
        { "<leader>gF", toggle("DiffviewFileHistory --follow %"), desc = "File history" },
        {
            "<leader>gF",
            "<Esc><cmd>'<,'>DiffviewFileHistory --follow<cr>",
            mode = "x",
            desc = "Selection history",
        },
    },
    opts = {
        enhanced_diff_hl = true,
        hooks = { view_closed = release_untracked },
        keymaps = {
            view = { close },
            file_panel = { close },
            file_history_panel = { close },
        },
    },
    init = function()
        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = function()
                release_untracked()
            end,
        })
    end,
}
