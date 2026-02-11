local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {} ---@as string | string[]
  local args_str = type(args) == "table" and table.concat(args, " ") or args ---@as string

  config = vim.deepcopy(config)
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) ---@as string
    if config.type and config.type == "java" then
      ---@diagnostic disable-next-line: return-type-mismatch
      return new_args
    end
    return require("dap.utils").splitstr(new_args)
  end
  return config
end

P:add({
  "https://github.com/theHamsta/nvim-dap-virtual-text",
  "https://github.com/nvim-neotest/nvim-nio",
  {
    src = "https://github.com/mfussenegger/nvim-dap",
    data = {
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-dap-virtual-text").setup({} --[[@as nvim_dap_virtual_text_options]])

        vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

        local dap = {
          Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
          Breakpoint = " ",
          BreakpointCondition = " ",
          BreakpointRejected = { " ", "DiagnosticError" },
          LogPoint = ".>",
        }
        for name, sign in pairs(dap) do
          local signs = type(sign) == "table" and sign or { sign }
          vim.fn.sign_define(
            "Dap" .. name,
            { text = signs[1], texthl = signs[2] or "DiagnosticInfo", linehl = signs[3], numhl = signs[3] } ---@as vim.fn.sign_define.dict
          )
        end

        -- setup dap config by VsCode launch.json file
        local vscode = require("dap.ext.vscode")
        local json = require("plenary.json")
        vscode.json_decode = function(str)
          return vim.json.decode(json.json_strip_comments(str))
        end

        -- stylua: ignore
        P.map({
          { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint condition" },
          { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
          { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
          { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with args" },
          { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
          { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
          { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
          { "<leader>dj", function() require("dap").down() end, desc = "Down" },
          { "<leader>dk", function() require("dap").up() end, desc = "Up" },
          { "<leader>dl", function() require("dap").run_last() end, desc = "Run last" },
          { "<leader>do", function() require("dap").step_out() end, desc = "Step out" },
          { "<leader>dO", function() require("dap").step_over() end, desc = "Step over" },
          { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
          { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
          { "<leader>ds", function() require("dap").session() end, desc = "Session" },
          { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
          { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
        })
      end,
    },
  },
  {
    src = "https://github.com/rcarriga/nvim-dap-ui",
    data = {
      config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        ---@diagnostic disable-next-line: missing-fields
        dapui.setup({} --[[@as dapui.Config]])
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end

        -- stylua: ignore
        P.map({
          { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "x" } },
        })
      end,
    },
  },
})
