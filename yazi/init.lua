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
		-- Expand the existing filename database (lowercase), for example:
		with_files = {},
		-- Expand the existing extension database (lowercase), for example:
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
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		ui.Span(":"),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		ui.Span(" "),
	})
end, 500, Status.RIGHT)
