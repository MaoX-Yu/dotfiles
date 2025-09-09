local api = vim.api
local lsp = vim.lsp
local au = api.nvim_create_autocmd
local g = api.nvim_create_augroup("mao.completion", { clear = true })

---Format snippets documentation
---@param item lsp.CompletionItem
---@return string?
local function snippets_doc(item)
  if item.detail and item.detail == "" then
    return nil
  end

  local menu = item.detail or item.insertText or ""
  local doc = type(item.documentation) == "table" and item.documentation.value or item.documentation

  while true do
    local new_menu, count = menu:gsub("%${%d+:(%${%d+:[^}]+})}", function(nested)
      return nested:gsub("%${%d+:([^}]+)}", "%1")
    end)

    if count == 0 then
      break
    end
    menu = new_menu
  end
  menu = menu:gsub("%${%d+:([^}]+)}", "%1")
  menu = menu:gsub("%${%d+}", "")
  menu = menu:gsub("%$%d+", "")
  local ret = "```" .. vim.bo.filetype .. "\n" .. menu .. "\n```" .. (doc and "\n---\n" .. doc or "")
  return ret
end

au("LspAttach", {
  group = g,
  callback = function(args)
    local completion = lsp.completion
    local ms = lsp.protocol.Methods

    local bufnr = args.buf
    local client = lsp.get_client_by_id(args.data.client_id)
    if not client or not client:supports_method(ms.textDocument_completion) then
      return
    end

    local chars = client.server_capabilities.completionProvider.triggerCharacters
    if chars then
      for i = string.byte("a"), string.byte("z") do
        if not vim.list_contains(chars, string.char(i)) then
          table.insert(chars, string.char(i))
        end
      end

      for i = string.byte("A"), string.byte("Z") do
        if not vim.list_contains(chars, string.char(i)) then
          table.insert(chars, string.char(i))
        end
      end
    end

    completion.enable(true, client.id, bufnr, {
      autotrigger = true,
      convert = function(item)
        local kind = lsp.protocol.CompletionItemKind[item.kind] or "unknown"
        local kind_icon, kind_hlgroup = require("mini.icons").get("lsp", kind)
        local abbr = item.label:gsub("%b()", "")
        abbr = vim.fn.strdisplaywidth(abbr) > 40 and vim.fn.strcharpart(abbr, 0, 39) .. "…" or abbr
        local menu = item.detail
        local info = type(item.documentation) == "table" and item.documentation.value or item.documentation

        -- Better snippets documentation
        if item.kind == 15 then
          info = snippets_doc(item) or info
          menu = ""
        end

        return {
          kind = kind_icon,
          kind_hlgroup = kind_hlgroup,
          abbr = abbr,
          menu = menu,
          info = info,
        }
      end,
    })

    if
      #api.nvim_get_autocmds({
        buffer = bufnr,
        event = { "CompleteChanged" },
        group = g,
      }) == 0
    then
      au("CompleteChanged", {
        buffer = bufnr,
        group = g,
        callback = function()
          local info = vim.fn.complete_info({ "selected" })
          if info.preview_bufnr and vim.bo[info.preview_bufnr].filetype == "" then
            vim.bo[info.preview_bufnr].filetype = "markdown"
            vim.wo[info.preview_winid].conceallevel = 2
            vim.wo[info.preview_winid].concealcursor = "niv"
          end
        end,
      })

      au("CompleteDone", {
        buffer = bufnr,
        group = g,
        callback = function()
          local item = vim.tbl_get(vim.v.completed_item, "user_data", "nvim", "lsp", "completion_item")
          if not item then
            return
          end

          if
            item.kind == 3
            and item.insertTextFormat == lsp.protocol.InsertTextFormat.Snippet
            and (item.textEdit ~= nil or item.insertText ~= nil)
          then
            vim.defer_fn(function()
              if api.nvim_get_mode().mode == "s" then
                lsp.buf.signature_help()
              end
            end, 500)
          end
        end,
        desc = "Auto show signature help when compeltion done",
      })
    end
  end,
})
