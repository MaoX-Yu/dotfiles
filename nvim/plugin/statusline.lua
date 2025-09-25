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
    modified = "[+]",
    readonly = "[-]",
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
    local file_symbols = { "" }
    if is_new_file() then
      table.insert(file_symbols, symbols.newfile)
    end
    if vim.bo.modifiable == false or vim.bo.readonly == true then
      table.insert(file_symbols, symbols.readonly)
    end
    if vim.bo.modified then
      table.insert(file_symbols, symbols.modified)
    end
    return utils.stl.escape(fname) .. table.concat(file_symbols, " ")
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

function M.branch()
  local branch = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.head or ""
  return branch ~= "" and string.format(" %s", utils.stl.escape(branch)) or ""
end

au("DiagnosticChanged", {
  group = group,
  desc = "Update diagnostics cache for the status line.",
  callback = function(args)
    local count = vim.diagnostic.count(args.buf)
    local diag = vim
      .iter(ipairs({ "error", "warn", "info", "hint" }))
      :map(function(severity_nr, severity)
        local cnt = count[severity_nr] or 0
        if cnt > 0 then
          local signs_text = vim.tbl_get(vim.diagnostic.config() --[[@as vim.diagnostic.Opts]], "signs", "text")
            or { "E:", "W:", "I:", "H:" }
          return utils.stl.hl(signs_text[severity_nr] .. cnt, hl_groups[severity])
        end
      end)
      :join(" ")
    vim.b[args.buf].diag_str_cache = diag
  end,
})

function M.diag()
  return vim.b.diag_str_cache or ""
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

function M.gitdiff()
  local diff = vim.b.gitsigns_status_dict or {}
  local added = diff.added or 0
  local changed = diff.changed or 0
  local removed = diff.removed or 0

  local diff_str = {}
  if added > 0 then
    table.insert(diff_str, utils.stl.hl(string.format("+%d", added), hl_groups.diff_add))
  end
  if changed > 0 then
    table.insert(diff_str, utils.stl.hl(string.format("~%d", changed), hl_groups.diff_change))
  end
  if removed > 0 then
    table.insert(diff_str, utils.stl.hl(string.format("-%d", removed), hl_groups.diff_remove))
  end
  return #diff_str > 0 and table.concat(diff_str, " ") or ""
end

function M.encoding()
  local encoding = vim.o.fileencoding
  if encoding == "" or encoding == "utf-8" then
    return ""
  end
  return string.upper(encoding)
end

function M.fileformat()
  local fileformat = {
    dos = "CRLF",
    unix = "LF",
    mac = "CR",
  }
  return fileformat[vim.bo.fileformat]
end

function M.position()
  local line = vim.fn.line(".")
  local col = vim.fn.charcol(".")
  return string.format("%d:%d", line, col)
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

function M.debug()
  if package.loaded["dap"] and require("dap").status() ~= "" then
    local dap = "  " .. require("dap").status()
    return utils.stl.hl(dap, hl_groups.debug)
  end
  return ""
end

function M.overseer()
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
          return utils.stl.hl(string.format("%s%s", icons[status], #status_tasks), hl_groups[status])
        end
      end)
      :join(" ")
  end
  return pieces
end

function M.lazy()
  local ok, status = pcall(require, "lazy.status")
  if ok and status.has_updates() then
    local updates = status.updates()
    return utils.stl.hl(updates, hl_groups.lazy)
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
function M.showcmd_msg()
  return showcmd_msg ~= "" and utils.stl.hl(string.format("%s", showcmd_msg), hl_groups.showcmd) or ""
end

local STL = {}

function STL.stl_left()
  local left = {}

  local mode = M.mode()
  local mode_str = utils.stl.get_mode(mode)
  table.insert(left, mode_str)

  local branch = M.branch()
  if branch ~= "" then
    table.insert(left, branch)
  end

  local diff = M.gitdiff()
  if diff ~= "" then
    table.insert(left, diff)
  end

  local diag = M.diag()
  if diag ~= "" then
    table.insert(left, diag)
  end

  local fname = M.fname()
  table.insert(left, fname)

  return table.concat(left, "  ")
end

function STL.stl_right()
  local right = {}

  local lsp_progress = M.lsp_progress()
  if lsp_progress ~= "" then
    table.insert(right, lsp_progress)
  end

  local showcmd = M.showcmd_msg()
  if showcmd ~= "" then
    table.insert(right, showcmd)
  end

  local lazy = M.lazy()
  if lazy ~= "" then
    table.insert(right, lazy)
  end

  local debug_str = M.debug()
  if debug_str ~= "" then
    table.insert(right, debug_str)
  end

  local overseer = M.overseer()
  if overseer ~= "" then
    table.insert(right, overseer)
  end

  local fileencoding = M.encoding()
  if fileencoding ~= "" then
    table.insert(right, fileencoding)
  end

  local filetype = M.filetype()
  if filetype ~= "" then
    table.insert(right, filetype)
  end

  local fileformat = M.fileformat()
  if fileformat ~= "" then
    table.insert(right, fileformat)
  end

  local progress = M.progress()
  table.insert(right, progress)

  local position = M.position()
  table.insert(right, position)

  return table.concat(right, "  ")
end

local stl = table.concat({
  [[ ]],
  [[%{%v:lua.STL.stl_left()%}]],
  [[%=]],
  [[%<]],
  [[%{%v:lua.STL.stl_right()%}]],
  [[ ]],
})

local stl_lazy = function()
  local lazy = require("lazy")
  local lazy_status = string.format("loaded: %s/%s", lazy.stats().loaded, lazy.stats().count)
  return string.format(" [Lazy]  %s  %s", lazy_status, M.lazy())
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
  return stl
end

au({ "FileChangedShellPost", "DiagnosticChanged", "LspProgress" }, {
  group = group,
  callback = function(args)
    vim.api.nvim__redraw({ buf = args.buf, statusline = true })
  end,
})

_G.STL = STL

vim.go.statusline = [[%!v:lua.STL.get()]]
