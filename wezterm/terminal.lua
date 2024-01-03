local Wezterm = require("wezterm")
local Icon = require("icon")

local M = {}

-- Appearance
-- config.front_end = "OpenGL"

-- Color pallete
M.colors = {
  crust = "rgba(30,30,46,1)",
  transparent = "rgba(0,0,0,0)",
  tab_active = "#FAB387",
  tab_inactive = "#7aa2f7",
  tab_fg = "#1E1E2E",
}

function M.setup(config)
  config.status_update_interval = 1000

  -- Colorscheme
  config.color_scheme = "Catppuccin Mocha"
  -- Font
  config.font = Wezterm.font_with_fallback({
    "Maple Mono",
    "Maple Mono SC NF",
    "Noto Color Emoji",
  })
  config.font_size = 14

  config.animation_fps = 240
  config.max_fps = 240

  config.initial_cols = 130
  config.initial_rows = 32
  config.window_decorations = "RESIZE"
  config.text_background_opacity = 1.0
  config.window_background_opacity = 1.0
  config.window_frame = {
    border_left_width = "0px",
    border_right_width = "0px",
    border_bottom_height = "0px",
    border_top_height = "0px",
    font_size = 14,
  }
  config.enable_scroll_bar = false
  config.default_cursor_style = "SteadyBar"
  config.cursor_blink_rate = 333
  config.inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 }
  config.window_padding = { left = "5px", right = "5px", top = "0.1cell", bottom = "0.1cell" }
  config.colors = {
    tab_bar = {
      background = M.colors.transparent,
      active_tab = {
        bg_color = M.colors.tab_active,
        fg_color = M.colors.tab_fg,
      },
      inactive_tab = {
        bg_color = M.colors.tab_inactive,
        fg_color = M.colors.tab_fg,
      },
      inactive_tab_hover = {
        bg_color = M.colors.tab_active,
        fg_color = M.colors.tab_fg,
      },
      new_tab = {
        bg_color = M.colors.tab_inactive,
        fg_color = M.colors.tab_fg,
      },
      new_tab_hover = {
        bg_color = M.colors.tab_active,
        fg_color = M.colors.tab_fg,
      },
    },
  }
  config.tab_bar_style = {
    new_tab = Wezterm.format({
      { Text = Icon.SOLID_LEFT_TRIANGLE },
      { Text = " + " },
      { Text = Icon.SOLID_RIGHT_TRIANGLE },
    }),
    new_tab_hover = Wezterm.format({
      { Text = Icon.SOLID_LEFT_TRIANGLE },
      { Text = " + " },
      { Text = Icon.SOLID_RIGHT_TRIANGLE },
    }),
  }

  config.adjust_window_size_when_changing_font_size = true
  config.audible_bell = "Disabled"
  config.exit_behavior = "Close"
  config.window_close_confirmation = "NeverPrompt"
  config.scrollback_lines = 50000
  config.tab_max_width = 9999
  config.hide_tab_bar_if_only_one_tab = false
  config.tab_bar_at_bottom = true
  config.use_fancy_tab_bar = false
  config.show_new_tab_button_in_tab_bar = true
  config.allow_win32_input_mode = true
  config.disable_default_key_bindings = false
end

return M
