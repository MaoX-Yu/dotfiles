local Wezterm = require("wezterm")

local M = {}

-- Color pallete
M.colors = {
  crust = "rgba(24, 25, 38, 1)",
  transparent = "rgba(0, 0, 0, 0)",
  tab_active = "#FAB387",
  tab_inactive = "#89B4FA",
  tab_hover = "#A6E3A1",
  tab_fg = "#1E1E2E",
  float_bg = "#1E2030",
  float_fg = "rgba(198, 208, 245, 1)",
}

function M.setup(config)
  config.status_update_interval = 1000

  -- Appearance
  config.front_end = "OpenGL"

  -- Colorscheme
  config.color_scheme = "Catppuccin Macchiato"

  -- Font
  config.font = Wezterm.font_with_fallback({
    {
      family = "Maple Mono SC NF",
      harfbuzz_features = { "ss01=1", "ss02=1", "ss03=1", "ss04=1", "ss05=1" },
    },
    "Segoe UI Symbol",
  })
  config.font_size = 14

  -- FPS
  config.animation_fps = 240
  config.max_fps = 240

  -- Initial size
  config.initial_cols = 128
  config.initial_rows = 34

  -- Cursor
  config.default_cursor_style = "BlinkingBlock"
  config.cursor_blink_rate = 0

  -- Window
  config.window_decorations = "RESIZE"
  config.text_background_opacity = 1.0
  config.window_background_opacity = 1.0
  config.window_frame = {
    active_titlebar_bg = M.colors.crust,
    inactive_titlebar_bg = M.colors.crust,
    border_left_width = "0px",
    border_right_width = "0px",
    border_bottom_height = "0px",
    border_top_height = "0px",
    font_size = 14,
  }
  config.enable_scroll_bar = false
  config.inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 }
  config.window_padding = { left = "5px", right = "5px", top = "10px", bottom = "0px" }

  -- Tab bar
  config.colors = {
    tab_bar = {
      background = M.colors.transparent,
      new_tab = {
        bg_color = M.colors.tab_inactive,
        fg_color = M.colors.tab_fg,
      },
      new_tab_hover = {
        bg_color = M.colors.tab_hover,
        fg_color = M.colors.tab_fg,
      },
    },
  }

  config.tab_max_width = 25
  config.hide_tab_bar_if_only_one_tab = false
  config.tab_bar_at_bottom = false
  config.show_new_tab_button_in_tab_bar = true
  config.show_tab_index_in_tab_bar = true
  config.use_fancy_tab_bar = true

  config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
  config.integrated_title_button_style = "Windows"
  config.integrated_title_button_color = "auto"
  config.integrated_title_button_alignment = "Right"

  -- Command palette
  config.command_palette_bg_color = M.colors.float_bg
  config.command_palette_fg_color = M.colors.float_fg
  -- config.command_palette_rows = 25 -- only nightly

  -- Char select
  config.char_select_bg_color = M.colors.float_bg
  config.char_select_fg_color = M.colors.float_fg

  -- Other
  config.adjust_window_size_when_changing_font_size = true
  config.allow_win32_input_mode = true
  config.audible_bell = "Disabled"
  config.disable_default_key_bindings = false
  config.exit_behavior = "CloseOnCleanExit"
  config.scrollback_lines = 50000
end

return M
