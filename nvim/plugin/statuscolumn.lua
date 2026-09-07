-- Statuscolumn
-- Inspired by: https://github.com/Bekaboo/dot/tree/master/.config/nvim

local ffi = require("ffi")

---@class mao.stc.candidate
---@field priority integer sign priority used to pick the best sign of a row
---@field cell string highlighted sign text for normal rows
---@field cul_cell string highlighted sign text for the cursorline row

---@class mao.stc.sign_row
---@field non_git? mao.stc.candidate best non-git sign on this line
---@field git? mao.stc.candidate best git sign on this line
---@field git_v? mao.stc.candidate best non-delete git sign on this line

---@class mao.stc.fold_cells
---@field [string] string cached fold column cell indexed by its character

---@class mao.stc.shared_data
---@field win integer
---@field wp ffi.cdata* winpos_T C struct for window attributes
---@field display_tick? integer display tick
---@field signs? table<integer, mao.stc.sign_row> viewport signs indexed by line number
---@field num_fmt_abs? string format string for the absolute line number
---@field num_fmt_pad? string format string for right aligned numbers/blank cells
---@field nu? boolean @number
---@field rnu? boolean @relativenumber
---@field nuw? integer @numberwidth
---@field scl? string @signcolumn
---@field fdc? string @foldcolumn
---@field show_nu? boolean whether to show line number (either &nu or &rnu is true)
---@field show_scl? boolean whether to show sign column
---@field show_fdc? boolean whether to show fold column
---@field cur? integer[] cursor position
---@field cul_hl_active? boolean whether to use cursorline highlight in the status column
---@field foldopen? string fold open sign
---@field foldclose? string fold close sign
---@field foldsep? string fold separator sign
---@field fold_cells? table<boolean, mao.stc.fold_cells> cached fold cells by cursorline state
---@field lnum? integer v:lnum
---@field relnum? integer v:relnum
---@field virtnum? integer v:virtnum

---@class mao.extmark.sign
---@field [1] integer extmark_id
---@field [2] integer row, 0-indexed
---@field [3] integer col, 0-indexed
---@field [4] mao.extmark.spec details

---@class mao.extmark.spec: vim.api.keyset.set_extmark
---@field sign_name string? only set when sign is defined using legacy `sign_define()`
---@field ns_id integer

---Shared data in each window
---@type table<integer, mao.stc.shared_data>
local shared = {}

ffi.cdef([[  typedef struct {} Error;
  typedef struct {} win_T;
  typedef struct {
    int start;  // line number where deepest fold starts
    int level;  // fold level, when zero other fields are N/A
    int llevel; // lowest level that starts in v:lnum
    int lines;  // number of lines from v:lnum to end of closed fold
  } foldinfo_T;
  foldinfo_T fold_info(win_T* wp, int lnum);
  win_T *find_window_by_handle(int Window, Error *err);

  // Display tick, incremented for each call to update_screen()
  uint64_t display_tick;
]])

---Highlight group openers are cached because the statuscolumn is evaluated for
---every screen line and small strings are built very often.
---@type table<string, string>
local hl_open = setmetatable({}, {
  __index = function(cache, hl)
    local prefix = "%#" .. hl .. "#"
    cache[hl] = prefix
    return prefix
  end,
})

---Build a highlighted statuscolumn cell.
---@param str string cell content
---@param hl string name of the highlight group
---@return string
local function make_cell(str, hl)
  return hl_open[hl] .. str .. "%*"
end

---Blank cells used for lines without a sign, cached by cursorline state.
---@type table<boolean, string>
local blank_sign_cell = {
  [false] = make_cell(" ", "SignColumn"),
  [true] = make_cell(" ", "CursorLineSign"),
}

---Build the two cached cells of a sign.
---@param spec mao.extmark.spec
---@return mao.stc.candidate
local function make_candidate(spec)
  local text = vim.trim(spec.sign_text or "")
  local hl = spec.sign_hl_group
  local cul_hl = spec.cursorline_hl_group or hl
  return {
    priority = spec.priority or 0,
    cell = hl and make_cell(text, hl) or text,
    cul_cell = cul_hl and make_cell(text, cul_hl) or text,
  }
end

---Replace the cached best sign only when the new priority is strictly higher,
---keeping the first sign when priorities are equal.
---@param row mao.stc.sign_row
---@param key "non_git"|"git"|"git_v"
---@param candidate mao.stc.candidate
local function add_best(row, key, candidate)
  local best = row[key]
  if not best or candidate.priority > best.priority then
    row[key] = candidate
  end
end

---Build a sparse per-line sign index from the viewport sign extmarks, so each
---line lookup is O(1) instead of scanning the whole list on every row.
---@param signs mao.extmark.sign[]
---@return table<integer, mao.stc.sign_row>?
local function index_signs(signs)
  local rows
  for _, sign in ipairs(signs) do
    local spec = sign[4]
    if spec.sign_text then
      local name = spec.sign_name or spec.sign_hl_group or ""
      local lnum = sign[2] + 1
      local row = rows and rows[lnum]
      if not row then
        row = {}
        if not rows then
          rows = {}
        end
        rows[lnum] = row
      end

      local candidate = make_candidate(spec)
      if name:find("^Git") then
        add_best(row, "git", candidate)
        if not name:find("[Dd]elete$") then
          add_best(row, "git_v", candidate)
        end
      else
        add_best(row, "non_git", candidate)
      end
    end
  end
  return rows
end

---Refresh all window data that is shared by every line of one display tick.
---@param data mao.stc.shared_data
local function refresh(data)
  local win = data.win
  local wo = vim.wo[win]
  local fcs = vim.opt_local.fillchars:get()
  local buf = vim.api.nvim_win_get_buf(win)
  local wininfo = vim.fn.getwininfo(win)[1]
  data.cur = vim.api.nvim_win_get_cursor(win)
  data.cul_hl_active = wo.cul and wo.culopt:find("[ou]") ~= nil
  data.nu = wo.nu
  data.rnu = wo.rnu
  data.nuw = wo.nuw
  data.scl = wo.scl
  data.fdc = wo.fdc
  data.show_nu = data.nu or data.rnu
  data.show_scl = data.scl ~= "no"
  data.show_fdc = data.fdc ~= "0"
  data.foldopen = fcs.foldopen or "-"
  data.foldclose = fcs.foldclose or "+"
  data.foldsep = fcs.foldsep or "|"

  -- Signs are only queried when the sign column is actually visible.
  data.signs = nil
  if data.show_scl then
    local signs = vim.api.nvim_buf_get_extmarks(buf, -1, { wininfo.topline - 1, 0 }, { wininfo.botline - 1, -1 }, {
      type = "sign",
      details = true,
    })
    data.signs = index_signs(signs)
  end

  -- Line number width must fit the largest value that can be displayed:
  -- absolute numbers need the buffer length, relative numbers need the
  -- window size (which is what the default number column uses).
  if data.show_nu then
    local largest
    if data.nu then
      largest = vim.api.nvim_buf_line_count(buf)
    else
      largest = wininfo.height
    end
    local width = math.max(data.nuw - 1, #tostring(largest))
    data.num_fmt_abs = "%%=%-" .. width .. "d "
    data.num_fmt_pad = "%%=%" .. width .. "s "
  end

  data.fold_cells = nil
  if data.show_fdc then
    data.fold_cells = {
      [false] = {
        [data.foldopen] = make_cell(data.foldopen, "FoldColumn"),
        [data.foldclose] = make_cell(data.foldclose, "FoldColumn"),
        [data.foldsep] = make_cell(data.foldsep, "FoldColumn"),
      },
      [true] = {
        [data.foldopen] = make_cell(data.foldopen, "CursorLineFold"),
        [data.foldclose] = make_cell(data.foldclose, "CursorLineFold"),
        [data.foldsep] = make_cell(data.foldsep, "CursorLineFold"),
      },
    }
  end
end

---Build the line number piece.
---@param data mao.stc.shared_data
---@return string
local function render_lnum(data)
  if not data.show_nu then
    return ""
  end

  if data.virtnum ~= 0 then
    return string.format(data.num_fmt_pad, "")
  end

  if not data.nu then
    return string.format(data.num_fmt_pad, data.relnum)
  end

  if not data.rnu then
    return string.format(data.num_fmt_pad, data.lnum)
  end

  if data.relnum == 0 then
    return string.format(data.num_fmt_abs, data.lnum)
  end

  return string.format(data.num_fmt_pad, data.relnum)
end

---Build the fold column piece.
---@param data mao.stc.shared_data
---@param culhl boolean
---@return string
local function render_fold(data, culhl)
  if not data.show_fdc then
    return ""
  end

  local lnum = data.lnum --[[@as integer]]
  local foldinfo = ffi.C.fold_info(data.wp, lnum)
  local foldchar = (data.virtnum ~= 0 or foldinfo.start ~= lnum) and data.foldsep
    or foldinfo.lines == 0 and data.foldopen
    or data.foldclose
  return data.fold_cells[culhl][foldchar]
end

---Pick the sign cell of a row, falling back to the cached blank cell.
---@param candidate? mao.stc.candidate
---@param culhl boolean
---@return string
local function render_sign(candidate, culhl)
  if candidate then
    return culhl and candidate.cul_cell or candidate.cell
  end
  return blank_sign_cell[culhl]
end

---Build one statuscolumn row.
---@param data mao.stc.shared_data
---@return string
local function render_line(data)
  local culhl = data.cul_hl_active and data.lnum == data.cur[1]
  local row = data.signs and data.signs[data.lnum]
  local pieces = {}

  if data.show_scl then
    local candidate = data.virtnum == 0 and row and row.non_git
    pieces[#pieces + 1] = render_sign(candidate, culhl)
    pieces[#pieces + 1] = " "
  end

  pieces[#pieces + 1] = render_lnum(data)

  if data.show_scl then
    local candidate = row and (data.virtnum ~= 0 and row.git_v or row.git)
    pieces[#pieces + 1] = render_sign(candidate, culhl)
  end

  pieces[#pieces + 1] = render_fold(data, culhl)
  if data.show_fdc then
    pieces[#pieces + 1] = " "
  end

  return table.concat(pieces)
end

---@return string
function _G.statuscolumn()
  local win = vim.g.statusline_winid
  local display_tick = ffi.C.display_tick --[[@as uinteger]]
  local data = shared[win]
  if not data then -- Initialize shared data
    data = {
      win = win,
      wp = ffi.C.find_window_by_handle(win, ffi.new("Error")),
    }
    shared[win] = data
  end

  if not data.display_tick or data.display_tick < display_tick then -- Update shared data
    refresh(data)
    data.display_tick = display_tick
  end

  data.lnum = vim.v.lnum
  data.relnum = vim.v.relnum
  data.virtnum = vim.v.virtnum

  return render_line(data)
end

local augroup = vim.api.nvim_create_augroup("mao.statuscolumn", {})

vim.api.nvim_create_autocmd("WinClosed", {
  group = augroup,
  desc = "Clear per window shared data cache.",
  callback = function(args)
    shared[tonumber(args.match)] = nil
  end,
})

vim.o.statuscolumn = [[%!v:lua.statuscolumn()]]
