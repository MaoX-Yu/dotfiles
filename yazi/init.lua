local git_ok, git = pcall(require, "git")
if git_ok then
	git:setup()
end

local yamb_ok, yamb = pcall(require, "yamb")
if yamb_ok then
	yamb:setup({})
end

local mime_ext_ok, mime_ext = pcall(require, "mime-ext")
if mime_ext_ok then
	mime_ext:setup({
		-- Expand the existing filename database (lowercase)
		with_files = {},
		-- Expand the existing extension database (lowercase)
		with_exts = {},
		fallback_file1 = true,
	})
end

-- Show symlink in status bar
function Status:name()
	local h = self._tab.current.hovered
	if not h then
		return ui.Line({})
	end

	local linked = ""
	if h.link_to ~= nil then
		linked = " -> " .. tostring(h.link_to)
	end
	return ui.Line(" " .. h.name .. linked)
end

-- Show user/group of files in status bar
Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line({})
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):style(ui.Style():fg("magenta")),
		ui.Span(":"),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):style(ui.Style():fg("magenta")),
		ui.Span(" "),
	})
end, 500, Status.RIGHT)

-- Tabs style
function Tabs.height()
	return 0
end

Header:children_add(function()
	if #cx.tabs == 1 then
		return ""
	end
	local spans = {}
	for i, tab in ipairs(cx.tabs) do
		spans[#spans + 1] = ui.Span(" " .. i .. " " .. tab.name .. " "):style(th.tabs.inactive)
	end
	spans[cx.tabs.idx]:style(th.tabs.active)
	return ui.Line(spans)
end, 9000, Header.RIGHT)
