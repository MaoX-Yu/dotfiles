local au = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("mao." .. name, { clear = true })
end

-- Close some filetypes with <q>
au("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "OverseerList",
    "checkhealth",
    "gitsigns-blame",
    "nvim-pack",
    "qf",
  },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, ev.buf, { force = true })
      end, {
        buffer = ev.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- Highlight on yank
au("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- Resize splits if window got resized
au("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Go to last loc when opening a buffer
au("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(ev)
    local exclude = { "gitcommit" }
    local buf = ev.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].myau_last_loc then
      return
    end
    vim.b[buf].myau_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
au("BufWritePre", {
  group = augroup("auto_create_dir"),
  callback = function(ev)
    if ev.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(ev.match) or ev.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Auto-build plugins after install/update
au("PackChanged", {
  group = augroup("pack_build"),
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    local path = ev.data.path

    if kind ~= "install" and kind ~= "update" then
      return
    end

    local build_commands = {
      ["telescope-fzf-native.nvim"] = { "make" },
    }

    local cmd = build_commands[name]
    if not cmd then
      return
    end

    vim.system(cmd, { cwd = path }, function(result)
      vim.schedule(function()
        if result.code == 0 then
          vim.notify(string.format("[%s] Build succeeded", name), vim.log.levels.INFO)
        else
          vim.notify(
            string.format("[%s] Build failed\n%s", name, result.stderr or "Unknown error"),
            vim.log.levels.ERROR
          )
        end
      end)
    end)
  end,
})
