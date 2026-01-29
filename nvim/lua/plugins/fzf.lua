return {
  {
    "ibhagwan/fzf-lua",
    cond = not vim.g.vscode,
    lazy = false,
    opts = {
      ui_select = true,
      fzf_opts = {
        ["--style"] = "default",
        ["--info"] = "default",
      },
      fzf_colors = {
        true,
        ["info"] = { "fg", "Statement" },
      },
      keymap = {
        builtin = {
          true,
          ["<C-f>"] = "preview-page-down",
          ["<C-b>"] = "preview-page-up",
        },
        fzf = {
          true,
          ["alt-d"] = "half-page-down",
          ["alt-u"] = "half-page-up",
          ["ctrl-f"] = "preview-page-down",
          ["ctrl-b"] = "preview-page-up",
        },
      },
    },
    keys = {
      -- Top Pickers
      { "<leader><space>", "<cmd>FzfLua builtin<cr>", desc = "Fzf builtin" },
      { "<leader>f", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>,", "<cmd>FzfLua buffers sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command history" },
      -- Grep
      { "<leader>sb", "<cmd>FzfLua blines<cr>", desc = "Buffer lines" },
      { "<leader>sB", "<cmd>FzfLua lines<cr>", desc = "Grep open buffers" },
      { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
      { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Current word" },
      { "<leader>sw", "<cmd>FzfLua grep_visual<cr>", desc = "Visual selection", mode = "x" },
      -- Search
      { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
      { "<leader>s/", "<cmd>FzfLua search_history<cr>", desc = "Search history" },
      { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Autocmds" },
      { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command history" },
      { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "Help pages" },
      { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Highlights" },
      { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumps" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
      { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location list" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
      { "<leader>sM", "<cmd>FzfLua manpages<cr>", desc = "Man pages" },
      { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix list" },
      { "<leader>sr", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      { "<leader>sR", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      { "<leader>su", "<cmd>FzfLua undotree<cr>", desc = "Undo history" },
      { "<leader>uC", "<cmd>FzfLua colorschemes<cr>", desc = "Colorschemes" },
      -- LSP
      { "gd", "<cmd>FzfLua lsp_definitions jump1=true<cr>", desc = "Goto definition" },
      { "gD", "<cmd>FzfLua lsp_declarations jump1=true<cr>", desc = "Goto declaration" },
      { "gr", "<cmd>FzfLua lsp_references jump1=true<cr>", nowait = true, desc = "Goto references" },
      { "gI", "<cmd>FzfLua lsp_implementations jump1=true<cr>", desc = "Goto implementation" },
      { "gy", "<cmd>FzfLua lsp_typedefs jump1=true<cr>", desc = "Goto type definition" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Buffer diagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Diagnostics" },
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "LSP symbols" },
      { "<leader>sS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "LSP workspace symbols" },
    },
  },
}
