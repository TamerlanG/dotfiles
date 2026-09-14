local M = {}

local function git(...)
    local out = vim.fn.systemlist({ "git", ... })
    if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
        return out[1]
    end
end

local candidates = { "main", "master", "develop" }

--- Resolve the branch a PR from HEAD would target.
--- Order: upstream/HEAD, upstream/{main,master,develop}, then origin, then local.
---@return string|nil
function M.base_branch()
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

--- Merge-base of HEAD and the PR base branch: the point this branch forked from.
---@return string|nil sha
function M.merge_base()
    local base = M.base_branch()
    return base and git("merge-base", base, "HEAD")
end

return M
