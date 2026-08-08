local M = {}

function M.setup(config)
  -- Metal is the native renderer on macOS
  config.front_end = "Metal"
end

return M
