-- Adapted from folke/snacks.nvim v2.31.0 (882c996c); modified locally.
-- Apache-2.0. See ATTRIBUTION.md.
local uv = vim.uv or vim.loop

---@param self mao.snacks.win
local function run_scratch(self)
  local mode = vim.fn.mode()
  local from, to = 1, vim.api.nvim_buf_line_count(self.buf)
  if mode:find("[vV]") then
    local start_mark = vim.api.nvim_buf_get_mark(self.buf, "<")
    local end_mark = vim.api.nvim_buf_get_mark(self.buf, ">")
    from = math.min(start_mark[1], end_mark[1])
    to = math.max(start_mark[1], end_mark[1])
  end
  local lines = vim.api.nvim_buf_get_lines(self.buf, from - 1, to, false)
  local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":t")
  local chunk, load_err = load(table.concat(lines, "\n"), "@" .. name)
  if not chunk then
    return S.notify.error(load_err, { title = "Scratch" })
  end
  local ok, run_err = xpcall(chunk, debug.traceback)
  if not ok then
    return S.notify.error(run_err, { title = "Scratch" })
  end
  S.notify.info("Executed " .. name, { title = "Scratch" })
end

---@class mao.snacks.scratch
---@overload fun(opts?: mao.snacks.scratch.Config): mao.snacks.win
local S = require("utils.snacks")
local M = setmetatable({}, {
  __call = function(M, ...)
    return M.open(...)
  end,
})

M.meta = {
  desc = "Scratch buffers with a persistent file",
}

M.version = 1
M.version_checked = false

---@class mao.snacks.scratch.File
---@field file string full path to the scratch buffer
---@field name string name of the scratch buffer
---@field ft string file type
---@field icon? string icon for the file type
---@field icon_hl? string highlight group for the icon
---@field cwd? string current working directory
---@field branch? string Git branch
---@field count? number vim.v.count1 used to open the buffer
---@field id? string unique id used instead of name for the filename hash

---@class mao.snacks.scratch.Config
---@field win? mao.snacks.win.Config scratch window
---@field template? string template for new buffers
---@field file? string scratch file path. You probably don't need to set this.
---@field ft? string|fun():string the filetype of the scratch buffer
local defaults = {
  name = "Scratch",
  ft = function()
    if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
      return vim.bo.filetype
    end
    return "markdown"
  end,
  ---@type string|string[]?
  icon = nil, -- `icon|{icon, icon_hl}`. defaults to the filetype icon
  root = vim.fn.stdpath("data") .. "/scratch",
  autowrite = true, -- automatically write when the buffer is hidden
  -- unique key for the scratch file is based on:
  -- * name
  -- * ft
  -- * vim.v.count1 (useful for keymaps)
  -- * cwd (optional)
  -- * branch (optional)
  filekey = {
    id = nil, ---@type string? unique id used instead of name for the filename hash
    cwd = true, -- use current working directory
    branch = true, -- use current branch name
    count = true, -- use vim.v.count1
  },
  win = { style = "scratch" },
  ---@type table<string, mao.snacks.win.Config>
  win_by_ft = {
    lua = {
      keys = {
        ["source"] = {
          "<cr>",
          function(self)
            run_scratch(self)
          end,
          desc = "Source buffer",
          mode = { "n", "x" },
        },
      },
    },
  },
}

S.util.set_hl({
  Title = "FloatTitle",
}, { prefix = "MaoScratch", default = true })

S.config.style("scratch", {
  width = 100,
  height = 30,
  bo = { buftype = "", buflisted = false, bufhidden = "hide", swapfile = false },
  minimal = false,
  noautocmd = false,
  -- position = "right",
  zindex = 20,
  wo = { winhighlight = "NormalFloat:Normal" },
  footer_keys = true,
  border = true,
})

--- Return a list of scratch buffers sorted by mtime.
---@return mao.snacks.scratch.File[]
function M.list()
  M.migrate()
  local root = S.config.get("scratch", defaults).root
  ---@type (mao.snacks.scratch.File|{stat:uv.fs_stat.result})[]
  local ret = {}
  for file, t in vim.fs.dir(root) do
    if t == "file" and file:sub(-5) == ".meta" then
      local path = vim.fs.normalize(root .. "/" .. file:sub(1, -6))
      local stat = uv.fs_stat(path)
      if stat then
        ret[#ret + 1] = M.get({ file = path })
        ret[#ret].stat = stat
      end
    end
  end
  table.sort(ret, function(a, b)
    return a.stat.mtime.sec > b.stat.mtime.sec
  end)
  return ret
end

--- Migrate old scratch files to the new format.
---@private
function M.migrate()
  if M.version_checked then
    return
  end
  M.version_checked = true
  local root = S.config.get("scratch", defaults).root
  local ok, version = pcall(vim.fn.readfile, root .. "/.version")
  if ok and tonumber(version[1]) == M.version then
    return
  end
  vim.fn.mkdir(root .. "/bak", "p")

  for file, t in vim.fs.dir(root) do
    if t == "file" then
      -- old format. Keep for backward compatibility
      local decoded = S.util.file_decode(file)
      local count, icon, name, cwd, branch, ft = decoded:match("^(%d*)|([^|]*)|([^|]*)|([^|]*)|([^|]*)%.([^|]*)$")
      if count and icon and name and cwd and branch and ft then
        local path = vim.fs.normalize(root .. "/" .. file)
        ---@type mao.snacks.scratch.File
        local scratch = {
          file = path,
          count = count ~= "" and tonumber(count) or nil,
          icon = icon ~= "" and icon or nil,
          name = name,
          cwd = cwd ~= "" and cwd or nil,
          branch = branch ~= "" and branch or nil,
          ft = ft,
        }
        -- backup file
        vim.fn.filecopy(path, root .. "/bak/" .. file)
        vim.fn.rename(path, M._write_meta(root, scratch))
      end
    end
  end
  vim.fn.writefile({ tostring(M.version) }, root .. "/.version")
end

--- Select a scratch buffer from a list of scratch buffers.
function M.select()
  local items = M.list()
  if #items == 0 then
    return S.notify.info("No scratch buffers", { title = "Scratch" })
  end
  vim.ui.select(items, {
    prompt = "Scratch buffers",
    format_item = function(item)
      return ("%s %s [%s]"):format(item.icon or "", item.name or "Scratch", item.ft or "")
    end,
  }, function(item)
    if item then
      M.open({ file = item.file })
    end
  end)
end

--- Open a scratch buffer with the given options.
--- If a window is already open with the same buffer,
--- it will be closed instead.
---@param opts? mao.snacks.scratch.Config
function M.open(opts)
  M.migrate()
  opts = S.config.get("scratch", defaults, opts)
  local scratch = M.get(opts)

  opts.win = S.win.resolve("scratch", opts.win_by_ft[scratch.ft], opts.win, {
    show = false,
    bo = { filetype = scratch.ft },
  })

  opts.win.title = {
    { " ", "MaoScratchTitle" },
    { scratch.icon .. string.rep(" ", 2 - vim.api.nvim_strwidth(scratch.icon)), scratch.icon_hl },
    { " ", "MaoScratchTitle" },
    { opts.name .. (vim.v.count1 > 1 and " " .. vim.v.count1 or ""), "MaoScratchTitle" },
    { " ", "MaoScratchTitle" },
  }

  local is_new = not uv.fs_stat(scratch.file)
  local buf = vim.fn.bufadd(scratch.file)

  local win = vim.fn.bufwinid(buf)
  if win ~= -1 then
    vim.schedule(function()
      vim.api.nvim_win_call(win, function()
        vim.cmd([[close]])
      end)
    end)
    return
  end

  opts.win.zindex = S.win.zindex(opts.win.zindex or 20)
  is_new = is_new
    and vim.api.nvim_buf_line_count(buf) == 0
    and #(vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or "") == 0

  if not vim.api.nvim_buf_is_loaded(buf) then
    vim.fn.bufload(buf)
  end

  if opts.template then
    local function reset()
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(opts.template, "\n"))
    end
    opts.win.keys = opts.win.keys or {}
    opts.win.keys.reset = { "R", reset, desc = "Reset buffer" }
    if is_new then
      reset()
    end
  end

  opts.win.buf = buf
  if opts.autowrite then
    vim.api.nvim_create_autocmd("BufHidden", {
      group = vim.api.nvim_create_augroup("mao_scratch_autowrite_" .. buf, { clear = true }),
      buffer = buf,
      callback = function(ev)
        vim.api.nvim_buf_call(ev.buf, function()
          vim.cmd("silent! write")
          vim.bo[ev.buf].buflisted = false
        end)
      end,
    })
  end
  return S.win(opts.win):show()
end

---@param opts? mao.snacks.scratch.Config
---@private
function M.get(opts)
  opts = S.config.get("scratch", defaults, opts)

  -- File type
  local ft = "markdown" ---@type string
  if opts.file then
    ft = vim.filetype.match({ filename = opts.file }) or ft
  elseif type(opts.ft) == "function" then
    ft = opts.ft()
  elseif type(opts.ft) == "string" then
    ft = opts.ft --[[@as string]]
  end

  -- Icon
  local icon = opts.icon or {}
  icon = type(icon) == "string" and { icon } or icon
  ---@cast icon string[]
  if not icon[1] and opts.file then
    icon[1], icon[2] = S.util.icon(opts.file or "", "file")
  elseif not icon[1] and ft then
    icon[1], icon[2] = S.util.icon(ft, "filetype")
  end

  ---@type mao.snacks.scratch.File
  local ret = {
    file = "",
    name = opts.name,
    ft = ft,
    icon = icon[1],
    icon_hl = icon[2],
  }

  -- File
  if opts.file then
    ret.file = vim.fs.normalize(opts.file)
    local meta = ret.file .. ".meta"
    if uv.fs_stat(meta) then
      local ok, decoded = pcall(vim.json.decode, table.concat(vim.fn.readfile(meta), "\n"))
      if ok and type(decoded) == "table" then
        ret = S.config.merge(ret, decoded, { file = ret.file })
      end
    end
  else
    ret.count = opts.filekey.count and vim.v.count1 or nil
    ret.cwd = opts.filekey.cwd and vim.fs.normalize(assert(uv.cwd())) or nil
    if opts.filekey.branch and uv.fs_stat(".git") then
      local out = vim.trim(vim.fn.systemlist("git branch --show-current")[1] or "")
      ret.branch = vim.v.shell_error == 0 and out ~= "" and out or nil
    end
    ret.file = M._write_meta(opts.root, ret)
  end
  return ret
end

---@param root string
---@param scratch mao.snacks.scratch.File
---@private
function M._write_meta(root, scratch)
  local key = { scratch.id or scratch.name }
  key[#key + 1] = scratch.count and tostring(scratch.count) or nil
  key[#key + 1] = scratch.cwd and scratch.cwd or nil
  key[#key + 1] = scratch.branch and scratch.branch or nil
  vim.fn.mkdir(root, "p")
  local hash = vim.fn.sha256(table.concat(key, "|")):sub(1, 8)
  local file = vim.fs.normalize(("%s/%s.%s"):format(root, hash, scratch.ft))
  vim.fn.writefile(vim.split(vim.json.encode(scratch), "\n"), file .. ".meta")
  return file
end

return M
