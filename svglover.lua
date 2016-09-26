--[[

svglover
 Library to import and display simple SVGs in LÖVE.
 https://github.com/globalcitizen/svglover

--]]

svglover_onscreen_svgs = {}

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
	--print("detected width:  " .. svg.width)
	--print("detected height: " .. svg.height)
	--  - finally, loop over lines, appending to svg.drawcommands
	--print(file_contents)
	--os.exit()

	-- return
	return svg
end

-- place a loaded svg in a given screen region
function svglover_display(svg,x,y,region_width,region_height,leave_no_edges)
	-- handle arguments
	region_width = region_width or math.min(love.graphics.getWidth-x,svg.width)
	region_height = region_height or math.min(love.graphics.getHeight-y,svg.height)
	leave_no_edges = leave_no_edges or true
	-- validate arguments
	if svg.width == nil or svg.height == nil or svg.drawcommands == nil then
		print("FATAL: passed invalid svg object")
		os.exit()
	elseif region_width < 1 or region_width > 10000 then
		print("FATAL: passed invalid region_width")
		os.exit()
	elseif region_height < 1 or region_height > 10000 then
		print("FATAL: passed invalid region_height")
		os.exit()
	elseif leave_no_edges ~= false and leave_no_edges ~= true then
		print("FATAL: passed invalid leave_no_edges")
		os.exit()
	end

	-- calculate drawing parameters
        --  - determine per-axis scaling
        local scale_factor_x = region_width  / svg.width
        local scale_factor_y = region_height / svg.height

        --  - select final scale factor
        --  if we use the minimum of the two axes, we get a blank edge
        --  if we use the maximum of the two axes, we lose a bit of the image
        local scale_factor = math.max(scale_factor_x,scale_factor_y)

--[[
        print("scale_factor = " .. scale_factor)
        print("desired_x    = " .. region_width)
        print("desired_y    = " .. region_height)
        print("image_size_x * scale_factor = " .. (svg.width*scale_factor))
        print("image_size_y * scale_factor = " .. (svg.height*scale_factor))
--]]

	--  - centering offsets
	local centering_offset_x = 0
	local centering_offset_y = 0
        if scale_factor * svg.width > region_width then
                centering_offset_x = -math.floor(((scale_factor*svg.width)-region_width)*0.5)
        elseif scale_factor * svg.height > region_height then
                centering_offset_y = -math.floor(((scale_factor*svg.height)-region_height)*0.5)
        end

	-- remember the determined properties
	svg['region_origin_x'] = x
	svg['region_origin_y'] = y
	svg['cx'] = centering_offset_x
	svg['cy'] = centering_offset_y
	svg['sfx'] = scale_factor
	svg['sfy'] = scale_factor
	svg['region_width'] = region_width
	svg['region_height'] = region_height

	-- debug
	svg.drawcommands = 'love.graphics.setColor(255, 255, 255)' .. "\n" .. 'love.graphics.rectangle("fill", 0, 0, ' .. svg.width .. ', ' .. svg.height .. ')'

	-- draw
	--print(table.show(svg))
	return table.insert(svglover_onscreen_svgs,dc(svg))
end

-- actually draw any svgs that are scheduled to be on screen
function svglover_draw()
	-- loop through on-screen SVGs
	for i,svg in ipairs(svglover_onscreen_svgs) do
		-- push graphics settings
		love.graphics.push()
		-- clip to the target area
	        love.graphics.setScissor(svg.region_origin_x, svg.region_origin_y, svg.region_width, svg.region_height)
	        -- draw in the target area
	        love.graphics.translate(svg.region_origin_x+svg.cx,svg.region_origin_y+svg.cy)
	        -- scale to the target area
	        love.graphics.scale(svg.sfx,svg.sfy)
		-- draw
		assert (loadstring (svg.drawcommands)) ()
	        -- disable clipping
	        love.graphics.setScissor()
		-- reset graphics
		love.graphics.pop()
		-- bounding box
		love.graphics.setColor(255,0,0,255)
		love.graphics.rectangle('line',svg.region_origin_x-1, svg.region_origin_y-1, svg.region_width+2, svg.region_height+2)
	end
end

-- deep copy
function dc(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[dc(orig_key)] = dc(orig_value)
        end
        setmetatable(copy, dc(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end
