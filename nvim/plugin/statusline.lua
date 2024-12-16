-- Built-in statusline

---@class utils
---@field fs table
---@field stl table
local U = require("utils")

local group_id = vim.api.nvim_create_augroup("Statusline", {})
local hl_groups = U.stl.hl_groups

local M = {}

function M.mode()
  local mode = vim.api.nvim_get_mode().mode
  local mode_str, hl = U.stl.get_mode_hl(mode)
  return U.stl.hl(string.format(" %s ", mode_str), hl) .. " "
end

---Record file name of normal buffers, key:val = fname:buffers_with_fname
---@type table<string, number[]>
local fnames = {}

---Update path diffs for buffers with the same file name
---@param bufs integer[]
---@return nil
local function update_pdiffs(bufs)
  bufs = vim.tbl_filter(vim.api.nvim_buf_is_valid, bufs)

  for i, path_diff in
    ipairs(vim.tbl_filter(function(d)
      return d ~= ""
    end, U.fs.diff(vim.tbl_map(vim.api.nvim_buf_get_name, bufs))))
  do
    local _buf = bufs[i]
    vim.b[_buf]._stl_pdiff = path_diff
  end
end

---Add a normal buffer to `fnames`, calc diff for buffer with non-unique
---file names
---@param buf integer buffer number
---@return nil
local function add_buf(buf)
  if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].bt ~= "" then
    return
  end

  local fname = vim.fs.basename(vim.api.nvim_buf_get_name(buf))
  if fname == "" then
    return
  end

  if not fnames[fname] then
    fnames[fname] = {}
  end

  local bufs = fnames[fname] -- buffers with the same name as the removed buf
  table.insert(bufs, buf)

  update_pdiffs(bufs)
end

for _, buf in ipairs(vim.api.nvim_list_bufs()) do
  add_buf(buf)
end

vim.api.nvim_create_autocmd({ "BufAdd", "BufFilePost" }, {
  group = group_id,
  desc = "Track new buffer file name.",
  callback = function(info)
    -- Delay adding buffer to fnames to ensure attributes, e.g.
    -- `bt`, are set for special buffers, for example, terminal buffers
    vim.schedule(function()
      add_buf(info.buf)
    end)
  end,
})

vim.api.nvim_create_autocmd({ "BufDelete", "BufFilePre" }, {
  group = group_id,
  desc = "Remove deleted buffer file name from record.",
  callback = function(info)
    if vim.bo[info.buf].bt ~= "" then
      return
    end

    local fname = vim.fs.basename(vim.api.nvim_buf_get_name(info.buf))
    local bufs = fnames[fname] -- buffers with the same name as the removed buf
    if not bufs then
      return
    end

    for i, buf in ipairs(bufs) do
      if buf == info.buf then
        table.remove(bufs, i)
        break
      end
    end

    local num_bufs = #bufs
    if num_bufs == 0 then
      fnames[fname] = nil
      return
    end

    if num_bufs == 1 then
      vim.b[bufs[1]]._stl_pdiff = nil
      return
    end

    -- Still have multiple buffers with the same file name,
    -- update path diffs for the remaining buffers
    update_pdiffs(bufs)
  end,
})

function M.fname()
  local symbols = {
    modified = "[+]",
    readonly = "[-]",
    unnamed = "[No Name]",
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
    local file_symbols = {}
    if vim.b._stl_pdiff then
      table.insert(file_symbols, string.format("[%s]", vim.b._stl_pdiff))
    end
    if vim.bo.modifiable == false or vim.bo.readonly == true then
      table.insert(file_symbols, symbols.readonly)
    end
    if is_new_file() then
      table.insert(file_symbols, symbols.newfile)
    end
    if vim.bo.modified then
      table.insert(file_symbols, symbols.modified)
    end
    return U.stl.escape(fname) .. (#file_symbols > 0 and " " .. table.concat(file_symbols, " ") or "")
  end

  -- Terminal buffer, show terminal command and id
  if vim.bo.bt == "terminal" then
    local id, cmd = bname:match("^term://.*/(%d+):(.*)")
    return id and cmd and string.format("%s (%s)", U.stl.escape(cmd), id) or "%F"
  end

  -- Other special buffer types
  local prefix, suffix = bname:match("^%s*(%S+)://(.*)")
  if prefix and suffix then
    return string.format("[%s] %s", U.stl.escape(U.stl.snake_to_camel(prefix)), U.stl.escape(suffix))
  end

  if bname == "" and vim.bo.ft ~= "" and vim.bo.ft ~= "qf" then
    return string.format("[%s]", U.stl.escape(U.stl.snake_to_camel(vim.bo.ft)))
  end

  return "%F"
end

function M.branch()
  local branch = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.head or ""
  return branch ~= "" and string.format("*%s", U.stl.escape(branch)) or ""
end

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  group = group_id,
  desc = "Update diagnostics cache for the status line.",
  callback = function(info)
    local b = vim.b[info.buf]
    local diag_cnt_cache = { 0, 0, 0, 0 }
    for _, diagnostic in ipairs(info.data.diagnostics) do
      diag_cnt_cache[diagnostic.severity] = diag_cnt_cache[diagnostic.severity] + 1
    end
    b.diag_str_cache = nil
    b.diag_cnt_cache = diag_cnt_cache
  end,
})

function M.diag()
  if vim.b.diag_str_cache then
    return vim.b.diag_str_cache
  end
  local diag = {}
  local buf_cnt = vim.b.diag_cnt_cache or {}
  for serverity_nr, severity in ipairs({ "error", "warn", "info", "hint" }) do
    local cnt = buf_cnt[serverity_nr] or 0
    if cnt > 0 then
      local icon_text = U.stl.get_diag_sign_text(serverity_nr)
      table.insert(diag, U.stl.hl(icon_text .. cnt, hl_groups[severity]))
    end
  end
  local str = #diag > 0 and string.format(" %s ", table.concat(diag, " ")) or ""
  vim.b.diag_str_cache = str
  return str
end

local spinner_end_keep = 2000 -- ms
local spinner_status_keep = 600 -- ms
local spinner_progress_keep = 80 -- ms
local spinner_timer = vim.uv.new_timer()

local spinner_icon_done = "✔"
local spinner_icons = {
  "⠋",
  "⠙",
  "⠹",
  "⠸",
  "⠼",
  "⠴",
  "⠦",
  "⠧",
  "⠇",
  "⠏",
}

---Id and additional info of language servers in progress
---@type table<integer, { name: string, timestamp: integer, type: "begin"|"report"|"end"|nil }>
local server_info = {}

vim.api.nvim_create_autocmd("LspProgress", {
  desc = "Update LSP progress info for the status line.",
  group = group_id,
  callback = function(info)
    if spinner_timer then
      spinner_timer:start(spinner_progress_keep, spinner_progress_keep, vim.schedule_wrap(vim.cmd.redrawstatus))
    end

    local id = info.data.client_id
    local now = vim.uv.now()
    server_info[id] = {
      name = vim.lsp.get_client_by_id(id).name,
      timestamp = now,
      type = info.data and info.data.params and info.data.params.value and info.data.params.value.kind,
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
    "%s %s ",
    table.concat(
      vim.tbl_map(function(id)
        return U.stl.escape(server_info[id].name)
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
    table.insert(diff_str, U.stl.hl(string.format("+%d", added), hl_groups.diff_add))
  end
  if changed > 0 then
    table.insert(diff_str, U.stl.hl(string.format("~%d", changed), hl_groups.diff_change))
  end
  if removed > 0 then
    table.insert(diff_str, U.stl.hl(string.format("-%d", removed), hl_groups.diff_remove))
  end
  return #diff_str > 0 and string.format("%s", table.concat(diff_str, " ")) or ""
end

function M.info()
  if vim.bo.bt ~= "" then
    return ""
  end

  local filetype = M.filetype()
  local branch = M.branch()
  local gitdiff = M.gitdiff()

  local info = {}
  if filetype ~= "" then
    table.insert(info, filetype)
  end
  if branch ~= "" then
    table.insert(info, branch)
  end
  if gitdiff ~= "" then
    table.insert(info, gitdiff)
  end
  return #info > 0 and string.format("(%s)", table.concat(info, ", ")) or ""
end

function M.encoding()
  local encoding = vim.opt.fileencoding:get()
  if encoding == "" or encoding == "utf-8" then
    return ""
  end
  return string.format(" %s ", string.upper(encoding))
end

function M.fileformat()
  return string.format("%s ", string.upper(vim.bo.fileformat))
end

function M.position()
  local line = vim.fn.line(".")
  local col = vim.fn.charcol(".")
  return string.format("%d:%d ", line, col)
end

function M.progress()
  local cur = vim.fn.line(".")
  local total = vim.fn.line("$")
  if cur == 1 then
    return "TOP "
  elseif cur == total then
    return "BOT "
  else
    return string.format("%d%%%% ", math.floor(cur / total * 100))
  end
end

function M.filetype()
  local ft = vim.bo.filetype or ""
  if ft == "" then
    return ""
  end
  return string.format("%s", U.stl.escape(ft))
end

function M.debug()
  if package.loaded["dap"] and require("dap").status() ~= "" then
    local dap = "  " .. require("dap").status() .. " "
    return U.stl.hl(dap, hl_groups.debug)
  end
  return ""
end

function M.overseer()
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
    local pieces = {}
    for _, status in ipairs(STATUS.values) do
      local status_tasks = tasks_by_status[status]
      if icons[status] and status_tasks then
        table.insert(pieces, U.stl.hl(string.format("%s%s", icons[status], #status_tasks), hl_groups[status]))
      end
    end
    if #pieces > 0 then
      return " " .. table.concat(pieces, " ") .. " "
    end
  end
  return ""
end

function M.lazy()
  local ok, status = pcall(require, "lazy.status")
  if ok and status.has_updates() then
    local updates = " " .. status.updates() .. " "
    return U.stl.hl(updates, hl_groups.lazy)
  end
  return ""
end

function M.noice()
  ---@diagnostic disable-next-line: undefined-field
  if package.loaded["noice"] and require("noice").api.status.command.has() then
    ---@diagnostic disable-next-line: undefined-field
    local command = require("noice").api.status.command.get()
    return U.stl.hl(string.format(" %s ", command), hl_groups.history_command)
  end
  return ""
end

-- stylua: ignore
local components = {
  align        = [[%=]],
  debug        = [[%{%v:lua.STL.debug()%}]],
  diag         = [[%{%v:lua.STL.diag()%}]],
  encoding     = [[%{%v:lua.STL.encoding()%}]],
  fileformat   = [[%{%v:lua.STL.fileformat()%}]],
  flag         = [[%{%&bt==#''?'':(&bt==#'help'?'%h ':(&pvw?'%w ':''))%}]],
  fname        = [[%{%v:lua.STL.fname()%}]],
  info         = [[%{%v:lua.STL.info()%}]],
  lazy         = [[%{%v:lua.STL.lazy()%}]],
  lsp_progress = [[%{%v:lua.STL.lsp_progress()%}]],
  mode         = [[%{%v:lua.STL.mode()%}]],
  noice        = [[%{%v:lua.STL.noice()%}]],
  overseer     = [[%{%v:lua.STL.overseer()%}]],
  padding      = [[ ]],
  position     = [[%{%v:lua.STL.position()%}]],
  progress     = [[%{%v:lua.STL.progress()%}]],
  truncate     = [[%<]],
}

local stl = table.concat({
  components.mode,
  components.flag,
  components.fname,
  components.padding,
  components.info,
  components.align,
  components.truncate,
  components.lsp_progress,
  components.diag,
  components.noice,
  components.lazy,
  components.overseer,
  components.debug,
  components.encoding,
  components.padding,
  components.fileformat,
  components.padding,
  components.progress,
  components.padding,
  components.position,
})

local stl_lazy = function()
  local lazy = require("lazy")
  local lazy_str = U.stl.hl(" Lazy ", hl_groups.normal)
  local lazy_status = "loaded: " .. lazy.stats().loaded .. "/" .. lazy.stats().count
  return lazy_str .. " " .. lazy_status .. " " .. components.lazy
end

local stl_mason = function()
  local mason = require("mason-registry")
  local mason_str = U.stl.hl(" Mason ", hl_groups.normal)
  local mason_status = "Installed: " .. #mason.get_installed_packages() .. "/" .. #mason.get_all_package_specs()
  return mason_str .. " " .. mason_status
end

local stl_oil = function()
  local mode = vim.api.nvim_get_mode().mode
  local _, hl = U.stl.get_mode_hl(mode)
  local oil_str = U.stl.hl(" Oil ", hl)
  local oil_dir = vim.fn.fnamemodify(require("oil").get_current_dir() or "", ":~")
  return oil_str .. " " .. oil_dir
end

function M.get()
  local ft = vim.bo.filetype
  if vim.g.vscode then
    return ""
  end
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

vim.api.nvim_create_autocmd({ "FileChangedShellPost", "DiagnosticChanged", "LspProgress" }, {
  group = group_id,
  command = "redrawstatus",
})

_G.STL = M

vim.opt_global.statusline = [[%!v:lua.STL.get()]]
