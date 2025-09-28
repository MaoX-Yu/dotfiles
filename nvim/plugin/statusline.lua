local utils = require("utils")
local hl_groups = utils.stl.hl_groups
local au = vim.api.nvim_create_autocmd

local group = vim.api.nvim_create_augroup("mao.statusline", { clear = true })

local M = {}

function M.mode()
  return vim.api.nvim_get_mode().mode
end

function M.fname()
  local symbols = {
    unnamed = "[Scratch]",
    newfile = "[New]",
  }
  local function is_new_file()
    local filename = vim.fn.expand("%")
    return filename ~= "" and vim.bo.buftype == "" and vim.fn.filereadable(filename) == 0
  end
  local bname = vim.api.nvim_buf_get_name(0)

  -- Normal buffer
  if vim.bo.bt == "" then
    -- Unnamed normal buffer
    if bname == "" then
      return symbols.unnamed
    end
    local fname = vim.fn.expand("%:t")
    if is_new_file() then
      fname = string.format("%s %s", fname, symbols.newfile)
    end
    return utils.stl.escape(fname)
  end

  -- Terminal buffer, show terminal command and id
  if vim.bo.bt == "terminal" then
    local id, cmd = bname:match("^term://.*/(%d+):(.*)")
    return id and cmd and string.format("%s (%s)", utils.stl.escape(cmd), id) or "%F"
  end

  -- Other special buffer types
  local prefix, suffix = bname:match("^%s*(%S+)://(.*)")
  if prefix and suffix then
    return string.format("[%s] %s", utils.stl.escape(utils.stl.snake_to_camel(prefix)), utils.stl.escape(suffix))
  end

  if bname == "" and vim.bo.ft ~= "" and vim.bo.ft ~= "qf" then
    return string.format("[%s]", utils.stl.escape(utils.stl.snake_to_camel(vim.bo.ft)))
  end

  return "%F"
end

function M.fileinfo()
  local info = {}
  if vim.bo.fileencoding ~= "" then
    local fileencoding = string.upper(string.sub(vim.bo.fileencoding, 1, 1))
    table.insert(info, fileencoding)
  else
    table.insert(info, "-")
  end

  if vim.o.encoding ~= "" then
    local encoding = string.upper(string.sub(vim.o.encoding, 1, 1))
    table.insert(info, encoding)
  else
    table.insert(info, "-")
  end

  if vim.bo.fileformat == "dos" then
    table.insert(info, "\\")
  elseif vim.bo.fileformat == "mac" then
    table.insert(info, "/")
  else
    table.insert(info, ":")
  end

  if not vim.bo.modifiable or vim.bo.readonly then
    if vim.bo.modified then
      table.insert(info, "%%*")
    else
      table.insert(info, "%%%%")
    end
  else
    if vim.bo.modified then
      table.insert(info, "**")
    else
      table.insert(info, "--")
    end
  end

  return table.concat(info, "")
end

function M.branch()
  local branch = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.head or ""
  return branch ~= "" and string.format(" %s", utils.stl.escape(branch)) or ""
end

au("DiagnosticChanged", {
  group = group,
  desc = "Update diagnostics cache for the status line.",
  callback = function(args)
    local count = vim.diagnostic.count(args.buf)
    local active_diag = {}
    local inactive_diag = {}
    for severity_nr, severity in ipairs({ "error", "warn", "info", "hint" }) do
      local cnt = count[severity_nr] or 0
      if cnt > 0 then
        local signs_text = vim.tbl_get(vim.diagnostic.config() --[[@as vim.diagnostic.Opts]], "signs", "text")
          or { "E:", "W:", "I:", "H:" }
        table.insert(active_diag, utils.stl.hl(signs_text[severity_nr] .. cnt, hl_groups[severity]))
        table.insert(inactive_diag, signs_text[severity_nr] .. cnt)
      end
    end
    vim.b[args.buf].active_diag_cache = table.concat(active_diag, " ")
    vim.b[args.buf].inactive_diag_cache = table.concat(inactive_diag, " ")
  end,
})

function M.diag(active)
  if active then
    return vim.b.active_diag_cache or ""
  else
    return vim.b.inactive_diag_cache or ""
  end
end

local spinner_end_keep = 2000 -- ms
local spinner_status_keep = 600 -- ms
local spinner_progress_keep = 120 -- ms
local spinner_timer = vim.uv.new_timer()

local spinner_icon_done = "[DONE]"
local spinner_icons = {
  "[    ]",
  "[=   ]",
  "[==  ]",
  "[ == ]",
  "[  ==]",
  "[   =]",
  "[    ]",
}

---Id and additional info of language servers in progress
---@type table<integer, { name: string, timestamp: integer, type: "begin"|"report"|"end"|nil }>
local server_info = {}

au("LspProgress", {
  desc = "Update LSP progress info for the status line.",
  group = group,
  callback = function(args)
    if spinner_timer then
      spinner_timer:start(spinner_progress_keep, spinner_progress_keep, vim.schedule_wrap(vim.cmd.redrawstatus))
    end

    local id = args.data.client_id
    local now = vim.uv.now()
    server_info[id] = {
      name = vim.lsp.get_client_by_id(id).name,
      timestamp = now,
      type = args.data and args.data.params and args.data.params.value and args.data.params.value.kind,
    } -- Update LSP progress data
    -- Clear client message after a short time if no new message is received
    vim.defer_fn(function()
      -- No new report since the timer was set
      local type = (server_info[id] or {}).type
      local last_timestamp = (server_info[id] or {}).timestamp
      if (not type or type == "end") and (not last_timestamp or last_timestamp == now) then
        server_info[id] = nil
        if vim.tbl_isempty(server_info) and spinner_timer then
          spinner_timer:stop()
        end
        vim.cmd.redrawstatus()
      end
    end, spinner_end_keep)
  end,
})

function M.lsp_progress()
  if vim.tbl_isempty(server_info) then
    return ""
  end

  local buf = vim.api.nvim_get_current_buf()
  local server_ids = {}
  for id, _ in pairs(server_info) do
    if vim.tbl_contains(vim.lsp.get_buffers_by_client_id(id), buf) then
      table.insert(server_ids, id)
    end
  end
  if vim.tbl_isempty(server_ids) then
    return ""
  end

  local now = vim.uv.now()
  ---@return boolean
  local function allow_changing_state()
    return not vim.b.spinner_state_changed or now - vim.b.spinner_state_changed > spinner_status_keep
  end

  if #server_ids == 1 and server_info[server_ids[1]].type == "end" then
    if vim.b.spinner_icon ~= spinner_icon_done and allow_changing_state() then
      vim.b.spinner_state_changed = now
      vim.b.spinner_icon = spinner_icon_done
    end
  else
    local spinner_icon_progress = spinner_icons[math.ceil(now / spinner_progress_keep) % #spinner_icons + 1]
    if vim.b.spinner_icon ~= spinner_icon_done then
      vim.b.spinner_icon = spinner_icon_progress
    elseif allow_changing_state() then
      vim.b.spinner_state_changed = now
      vim.b.spinner_icon = spinner_icon_progress
    end
  end

  return string.format(
    " %s %s",
    table.concat(
      vim.tbl_map(function(id)
        return utils.stl.escape(server_info[id].name)
      end, server_ids),
      ", "
    ),
    vim.b.spinner_icon
  )
end

function M.gitdiff(active)
  local diff = vim.b.gitsigns_status_dict or {}
  local added = diff.added or 0
  local changed = diff.changed or 0
  local removed = diff.removed or 0

  local diff_str = {}
  if added > 0 then
    if active then
      table.insert(diff_str, utils.stl.hl(string.format("+%d", added), hl_groups.diff_add))
    else
      table.insert(diff_str, string.format("+%d", added))
    end
  end
  if changed > 0 then
    if active then
      table.insert(diff_str, utils.stl.hl(string.format("~%d", changed), hl_groups.diff_change))
    else
      table.insert(diff_str, string.format("~%d", changed))
    end
  end
  if removed > 0 then
    if active then
      table.insert(diff_str, utils.stl.hl(string.format("-%d", removed), hl_groups.diff_remove))
    else
      table.insert(diff_str, string.format("-%d", removed))
    end
  end
  return table.concat(diff_str, " ")
end

function M.position()
  return "%l:%c%V"
end

function M.progress()
  local cur = vim.fn.line(".")
  local total = vim.fn.line("$")
  if cur == 1 then
    return "TOP"
  elseif cur == total then
    return "BOT"
  else
    return string.format("%d%%%%", math.floor(cur / total * 100))
  end
end

function M.filetype()
  return vim.bo.filetype or ""
end

function M.debug(active)
  if package.loaded["dap"] and require("dap").status() ~= "" then
    local dap = "  " .. require("dap").status()
    if active then
      return utils.stl.hl(dap, hl_groups.debug)
    else
      return dap
    end
  end
  return ""
end

function M.overseer(active)
  local pieces = ""
  if package.loaded["overseer"] then
    local constants = require("overseer.constants")
    local task_list = require("overseer.task_list")
    local util = require("overseer.util")
    local STATUS = constants.STATUS
    local icons = {
      [STATUS.FAILURE] = "F:",
      [STATUS.CANCELED] = "C:",
      [STATUS.SUCCESS] = "S:",
      [STATUS.RUNNING] = "R:",
    }
    local tasks = task_list.list_tasks()
    local tasks_by_status = util.tbl_group_by(tasks, "status")
    pieces = vim
      .iter(ipairs(STATUS.values))
      :map(function(_, status)
        local status_tasks = tasks_by_status[status]
        if icons[status] and status_tasks then
          if active then
            return utils.stl.hl(string.format("%s%s", icons[status], #status_tasks), hl_groups[status])
          else
            return string.format("%s%s", icons[status], #status_tasks)
          end
        end
      end)
      :join(" ")
  end
  return pieces
end

function M.lazy(active)
  local ok, status = pcall(require, "lazy.status")
  if ok and status.has_updates() then
    local updates = status.updates()
    if active then
      return utils.stl.hl(updates, hl_groups.lazy)
    else
      return updates
    end
  end
  return ""
end

local showcmd_msg = ""
vim.ui_attach(vim.api.nvim_create_namespace("showcmd_msg"), { ext_messages = true }, function(event, ...)
  if event == "msg_showcmd" then
    local content = ...
    showcmd_msg = #content > 0 and content[1][2] or showcmd_msg
  end
end)
function M.showcmd_msg(active)
  if showcmd_msg ~= "" then
    if active then
      return utils.stl.hl(showcmd_msg, hl_groups.showcmd)
    else
      return showcmd_msg
    end
  end
  return ""
end

local STL = {}

function STL.stl_left(active)
  local left = {}

  local mode = M.mode()
  local mode_str = utils.stl.get_mode(mode)
  table.insert(left, mode_str)

  local branch = M.branch()
  if branch ~= "" then
    table.insert(left, branch)
  end

  local diag = M.diag(active)
  if diag ~= "" then
    table.insert(left, diag)
  end

  local fileinfo = M.fileinfo()
  table.insert(left, fileinfo)

  local fname = M.fname()
  table.insert(left, fname)

  return table.concat(left, "  ")
end

function STL.stl_right(active)
  local right = {}

  local lsp_progress = M.lsp_progress()
  if lsp_progress ~= "" then
    table.insert(right, lsp_progress)
  end

  local showcmd = M.showcmd_msg(active)
  if showcmd ~= "" then
    table.insert(right, showcmd)
  end

  local lazy = M.lazy(active)
  if lazy ~= "" then
    table.insert(right, lazy)
  end

  local overseer = M.overseer(active)
  if overseer ~= "" then
    table.insert(right, overseer)
  end

  local debug_str = M.debug(active)
  if debug_str ~= "" then
    table.insert(right, debug_str)
  end

  local diff = M.gitdiff(active)
  if diff ~= "" then
    table.insert(right, diff)
  end

  local filetype = M.filetype()
  if filetype ~= "" then
    table.insert(right, filetype)
  end

  local position = M.position()
  table.insert(right, position)

  local progress = M.progress()
  table.insert(right, progress)

  return table.concat(right, "  ")
end

local function stl()
  return table.concat({
    [[ ]],
    [[%{%(nvim_get_current_win()==#g:actual_curwin) ? luaeval('STL.stl_left(true)') : luaeval('STL.stl_left()')%}]],
    [[%=]],
    [[%<]],
    [[%{%(nvim_get_current_win()==#g:actual_curwin) ? luaeval('STL.stl_right(true)') : luaeval('STL.stl_right()')%}]],
    [[ ]],
  })
end

local stl_lazy = function()
  local lazy = require("lazy")
  local lazy_status = string.format("loaded: %s/%s", lazy.stats().loaded, lazy.stats().count)
  return string.format(" [Lazy]  %s  %s", lazy_status, M.lazy(true))
end

local stl_mason = function()
  local mason = require("mason-registry")
  local mason_status = "Installed: " .. #mason.get_installed_packages() .. "/" .. #mason.get_all_package_specs()
  return string.format(" [Mason]  %s", mason_status)
end

local stl_oil = function()
  local oil_dir = vim.fn.fnamemodify(require("oil").get_current_dir() or "", ":~")
  return string.format(" [Oil]  %s", oil_dir)
end

function STL.get()
  local ft = vim.bo.filetype
  if ft == "dashboard" then
    return "%#Normal#"
  end
  if ft == "lazy" then
    return stl_lazy()
  end
  if ft == "mason" then
    return stl_mason()
  end
  if ft == "oil" then
    return stl_oil()
  end
  return stl()
end

au({ "FileChangedShellPost", "DiagnosticChanged", "LspProgress" }, {
  group = group,
  callback = function(args)
    vim.api.nvim__redraw({ buf = args.buf, statusline = true })
  end,
})

_G.STL = STL

vim.go.statusline = [[%!v:lua.STL.get()]]
