-- Custom linemode: size + modification time
function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = "          "
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%b %d %H:%M", time)
	else
		time = os.date("%b %d  %Y", time)
	end

	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "  -  ", time)
end

-- Status bar: file type indicator (left side, after name)
Status:children_add(function(self)
	local h = cx.active.current.hovered
	if not h then return "" end

	if h.cha.is_dir then
		return ui.Span("  dir "):fg("#89b4fa")
	elseif h.cha.is_link then
		return ui.Span("  link "):fg("#f5c2e7")
	else
		local name = h.name or ""
		local ext = name:match("%.([^%.]+)$")
		if ext then
			return ui.Span("  ." .. ext .. " "):fg("#94e2d5")
		end
		return ui.Span("  file "):fg("#94e2d5")
	end
end, 3500, Status.LEFT)

-- Status bar: file size (right side)
Status:children_add(function(self)
	local h = cx.active.current.hovered
	if not h then return "" end

	local size = h:size()
	if not size then return "" end

	return ui.Span(" " .. ya.readable_size(size) .. " "):fg("#a6e3a1")
end, 500, Status.RIGHT)

-- Status bar: modified time (right side)
Status:children_add(function(self)
	local h = cx.active.current.hovered
	if not h then return "" end

	local time = math.floor(h.cha.mtime or 0)
	if time == 0 then return "" end

	local str
	if os.date("%Y", time) == os.date("%Y") then
		str = os.date("%b %d %H:%M", time)
	else
		str = os.date("%b %d  %Y", time)
	end

	return ui.Span(" " .. str .. " "):fg("#89b4fa")
end, 600, Status.RIGHT)

-- Status bar: owner:group (right side)
Status:children_add(function(self)
	local h = cx.active.current.hovered
	if not h then return "" end

	local uid = h.cha.uid
	local gid = h.cha.gid
	if not uid then return "" end

	local user = ya.user_name(uid) or tostring(uid)
	local group = ya.group_name(gid) or tostring(gid)

	return ui.Span(" " .. user .. ":" .. group .. " "):fg("#f9e2af")
end, 700, Status.RIGHT)
