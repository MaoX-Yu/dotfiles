P:add({
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  {
    src = "https://github.com/nvim-telescope/telescope.nvim",
    data = {
      config = function()
        require("telescope").setup({
          defaults = {
            layout_strategy = "bottom_pane",
            borderchars = {
              prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
              results = { " " },
              preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            },
            sorting_strategy = "ascending",
          },
        })
        require("telescope").load_extension("fzf")

        local action_state = require("telescope.actions.state")
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")
        local themes = require("telescope.themes")

        local function select_one(prompt, choices, opts, on_choice)
          local picker_height = #choices + 4

          opts = vim.tbl_deep_extend("force", themes.get_dropdown({}), opts or {})
          opts.layout_config = vim.tbl_deep_extend("force", opts.layout_config or {}, {
            height = function(_, _, max_lines)
              return math.min(picker_height, max_lines)
            end,
          })
          require("telescope.pickers")
            .new(opts, {
              prompt_title = prompt,
              finder = require("telescope.finders").new_table({
                results = choices,
                entry_maker = function(choice)
                  return {
                    display = choice.label,
                    ordinal = choice.label,
                    value = choice,
                  }
                end,
              }),
              sorter = require("telescope.config").values.generic_sorter(opts),
              attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                  local selection = action_state.get_selected_entry()
                  actions.close(prompt_bufnr)
                  on_choice(selection and selection.value, selection and selection.value.index)
                end)
                map("i", "<C-c>", function()
                  actions.close(prompt_bufnr)
                  on_choice(nil, nil)
                end)
                return true
              end,
            })
            :find()
        end

        vim.ui.select = function(items, opts, on_choice)
          opts = opts or {}
          local choices = {}
          for i, item in ipairs(items) do
            local label = opts.format_item and opts.format_item(item) or tostring(item)
            choices[i] = { index = i, item = item, label = label }
          end

          select_one(opts.prompt or "Select", choices, { kind = opts.kind }, function(value)
            if value then
              on_choice(value.item, value.index)
            else
              on_choice(nil, nil)
            end
          end)
        end

        local function smart()
          if vim.fs.find(".git", { upward = true })[1] then
            builtin.git_files()
          else
            builtin.find_files()
          end
        end

        local function grep_string()
          local mode = vim.fn.mode(true)
          local search
          if mode == "V" then
            local s = vim.fn.getpos("'<")
            local e = vim.fn.getpos("'>")
            search = table.concat(vim.fn.getline(s[2], e[2]), "\n")
          elseif mode:find("[v\22]") then
            local s = vim.fn.getpos("'<")
            local e = vim.fn.getpos("'>")
            local lines = vim.fn.getline(s[2], e[2])
            if #lines > 0 then
              lines[1] = string.sub(lines[1], s[3])
              if #lines == 1 then
                lines[1] = string.sub(lines[1], 1, e[3] - s[3] + 1)
              else
                lines[#lines] = string.sub(lines[#lines], 1, e[3])
              end
              search = table.concat(lines, "\n")
            end
          else
            search = vim.fn.expand("<cword>")
          end
          builtin.grep_string({ search = search })
        end

        -- stylua: ignore
        P.map({
          -- Top Pickers
          { "<Leader><Space>", smart, desc = "Smart find files" },
          { "<Leader>,", function() builtin.buffers() end, desc = "Buffers" },
          { "<Leader>/", function() builtin.live_grep() end, desc = "Grep" },
          { "<Leader>:", function() builtin.command_history() end, desc = "Command history" },
          -- find
          { "<Leader>f", function() builtin.find_files() end, desc = "Find files" },
          -- git
          { "<Leader>gC", function() builtin.git_branches() end, desc = "Git branches" },
          -- Grep
          { "<Leader>sb", function() builtin.current_buffer_fuzzy_find() end, desc = "Buffer lines" },
          {
            "<Leader>sB",
            function() builtin.live_grep({ grep_open_files = true }) end,
            desc = "Grep open buffers",
          },
          { "<Leader>sg", function() builtin.live_grep() end, desc = "Grep" },
          { "<Leader>sw", grep_string, desc = "Word or selection", mode = { "n", "x" } },
          -- search
          { '<Leader>s"', function() builtin.registers() end, desc = "Registers" },
          { '<Leader>s/', function() builtin.search_history() end, desc = "Search history" },
          { "<Leader>sc", function() builtin.command_history() end, desc = "Command history" },
          { "<Leader>sC", function() builtin.commands() end, desc = "Commands" },
          {
            "<Leader>sd",
            function() builtin.diagnostics({ bufnr = 0 }) end,
            desc = "Buffer diagnostics",
          },
          { "<Leader>sD", function() builtin.diagnostics() end, desc = "Diagnostics" },
          { "<Leader>sh", function() builtin.help_tags() end, desc = "Help pages" },
          { "<Leader>sH", function() builtin.highlights() end, desc = "Highlights" },
          { "<Leader>sj", function() builtin.jumplist() end, desc = "Jumps" },
          { "<Leader>sk", function() builtin.keymaps() end, desc = "Keymaps" },
          { "<Leader>sl", function() builtin.loclist() end, desc = "Location list" },
          { "<Leader>sm", function() builtin.marks() end, desc = "Marks" },
          { "<Leader>sM", function() builtin.man_pages() end, desc = "Man pages" },
          { "<Leader>sq", function() builtin.quickfix() end, desc = "Quickfix list" },
          { "<Leader>sr", function() builtin.oldfiles() end, desc = "Recent" },
          { "<Leader>sR", function() builtin.resume() end, desc = "Resume" },
          { "<Leader>uC", function() builtin.colorscheme() end, desc = "Colorschemes" },
          -- LSP
          { "gd", function() builtin.lsp_definitions() end, desc = "Goto definition" },
          { "gD", function() builtin.lsp_declarations() end, desc = "Goto declaration" },
          { "gr", function() builtin.lsp_references() end, nowait = true, desc = "Goto references" },
          { "gI", function() builtin.lsp_implementations() end, desc = "Goto implementation" },
          { "gy", function() builtin.lsp_type_definitions() end, desc = "Goto type definition" },
          { "<Leader>ss", function() builtin.lsp_document_symbols() end, desc = "LSP symbols" },
          { "<Leader>sS", function() builtin.lsp_workspace_symbols() end, desc = "LSP workspace symbols" },
        })
      end,
    },
  },
})
