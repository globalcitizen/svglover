--[[

svglover
 Library to import and display simple SVGs in LÖVE.
 https://github.com/globalcitizen/svglover

--]]

-- load an svg and return it as a slightly marked up table
--  markup includes resolution detection
function svglover_load(svgfile)
	-- validate input
	--  file exists?
	local fh = io.open(svgfile, "r")
	if not fh then
		print("FATAL: file does not exist: '" .. svgfile .. "'")
		os.exit()
	end
	--  file is a roughly sane size?
	local size = fh:seek("end")
      	fh:seek("set", current)
	if size == nil or size < 10 or size > 500000 then
		print("FATAL: file is not an expected size (0-500000 bytes): '" .. svgfile .. "'")
		os.exit()
	end

	-- initialize return structure
	local svg = {height=0,height=0,drawcommands=''}

	-- process input
	--  - first we read the whole file in to a string
	local file_contents=''
	for line in love.filesystem.lines(svgfile) do
        	if not (line==nil) then
			file_contents = file_contents .. line
		end
  	end
	--  - insert newline after all tags
	file_contents = string.gsub(file_contents,">",">\n")
	--  - flush blank lines
	file_contents = string.gsub(file_contents,"\n+","\n")		-- remove multiple newlines
	file_contents = string.gsub(file_contents,"\n$","")		-- remove trailing newline
	--  - extract height and width
	svg.width = string.match(file_contents,"<svg [^>]+width=\"(%d+)\"")
	svg.height = string.match(file_contents,"<svg [^>]+height=\"(%d+)\"")
	print("detected width:  " .. svg.width)
	print("detected height: " .. svg.height)
	--  - finally, loop over lines, appending to svg.drawcommands
	--print(file_contents)
	os.exit()

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
