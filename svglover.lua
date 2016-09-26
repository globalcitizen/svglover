--[[

svglover
 Library to import and display simple SVGs in LÖVE.
 https://github.com/globalcitizen/svglover

--]]

-- load an svg and return it as a slightly marked up table
--  markup includes resolution detection
local function svglover_load(svgfile)
	-- validate input
	--  file exists?
	--  file is a roughly sane size?

	-- initialize return structure
	local svg = {height=0,height=0,drawcommands=''}

	-- process input
	--  - first we read the whole file in to a string
	--  - insert newline after all tags
	--  - extract height and width
	--  - finally, loop over lines, appending to svg.drawcommands

	-- return
	return svg
end

-- place a loaded svg in a given screen region
local function svglover_display(svg,x,y,width,height,leave_no_edges)
	-- handle arguments
	width = width or math.min(love.graphics.getWidth-x,svg.width)
	height = height or math.min(love.graphics.getHeight-y,svg.height)
	leave_no_edges = leave_no_edges or true
	-- validate arguments
	if width < 1 or width > 10000 then
		print("FATAL: passed invalid width")
		os.exit()
	elseif height < 1 or height > 10000 then
		print("FATAL: passed invalid height")
		os.exit()
	elseif leave_no_edges ~= false and leave_no_edges ~= true then
		print("FATAL: passed invalid leave_no_edges")
		os.exit()
	end
	-- calculate drawing parameters
	-- draw
	return true
end
