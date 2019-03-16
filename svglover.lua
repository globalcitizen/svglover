--[[

svglover
 Library to import and display simple SVGs in LÖVE.
 https://github.com/globalcitizen/svglover

--]]

local svglover = {}

svglover.onscreen_svgs = {}

-- load an svg and return it as a slightly marked up table
--  markup includes resolution detection
function svglover.load(svgfile)
    -- validate input
    --  file exists?
    if not love.filesystem.getInfo(svgfile) then
        print("FATAL: file does not exist: '" .. svgfile .. "'")
        os.exit()
    end
    --  file is a roughly sane size?
    local size = love.filesystem.getInfo(svgfile).size
    if size == nil or size < 10 or size > 500000 then
        print("FATAL: file is not an expected size (0-500000 bytes): '" .. svgfile .. "'")
        os.exit()
    end

    -- initialize return structure
    local svg = {
        width = 0;
        height = 0;
        viewport = nil;
        drawcommands ='';
    }

    -- process input
    --  - first we read the whole file in to a string
    local file_contents, _ = love.filesystem.read(svgfile)
    --  - decompress if appropriate
    local magic = love.filesystem.read(svgfile,2)
    if svglover._hexdump(magic) == '1f 8b' then
        file_contents = love.math.decompress(file_contents,'zlib')
    end
    --  - remove all newlines
    file_contents = string.gsub(file_contents,"\r?\n","")
    --  - insert newline after all tags
    file_contents = string.gsub(file_contents,">",">\n")
    --  - flush blank lines
    file_contents = string.gsub(file_contents,"\n+","\n")      -- remove multiple newlines
    file_contents = string.gsub(file_contents,"\n$","")        -- remove trailing newline
    --  - extract height and width
    svg.width = string.match(file_contents,"<svg[^>]+width=\"([0-9.]+)") or 1
    svg.height = string.match(file_contents,"<svg[^>]+height=\"([0-9.]+)") or 1
    --  - get viewport
    if string.find(file_contents, "<svg[^>]+viewBox=\"") then
        local def = string.match(file_contents, "<svg[^>]+viewBox=\"([^\"]+)")
        local next_num = string.gmatch(def, "%-?[^%s,%-]+")

        svg.viewport = {
            minx = tonumber(next_num());
            miny = tonumber(next_num());
            width = tonumber(next_num());
            height = tonumber(next_num());
        }
    end

    --  - finally, loop over lines, appending to svg.drawcommands
    for line in string.gmatch(file_contents, "[^\n]+") do
        -- parse it
        svg.drawcommands = svg.drawcommands .. "\n" .. svglover._lineparse(line)
    end

    -- remove duplicate newlines
    svg.drawcommands = string.gsub(svg.drawcommands,"\n+","\n")
    svg.drawcommands = string.gsub(svg.drawcommands,"^\n","")
    svg.drawcommands = string.gsub(svg.drawcommands,"\n$","")

    -- return
    return svg
end

-- place a loaded svg in a given screen region
function svglover.display(svg,x,y,region_width,region_height,leave_no_edges,border_color,border_width,zoom)
    -- handle arguments
    region_width = region_width or math.min(love.graphics.getWidth() - x, svg.width)
    region_height = region_height or math.min(love.graphics.getHeight() - y, svg.height)
    if leave_no_edges == nil then
        leave_no_edges = true
    end
    border_color = border_color or nil
    border_width = border_width or 1
    zoom = zoom or 1
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
    elseif border_color ~= nil then
        for element in pairs(border_color) do
            if element < 0 or element > 255 or element == nil then
                print("FATAL: passed invalid border_color")
                os.exit()
            end
        end
    elseif border_width < 1 or border_width > 10000 then
        print("FATAL: passed invalid border_width")
        os.exit()
    elseif zoom <= 0 or zoom > 10000 then
        print("FATAL: passed invalid zoom")
        os.exit()
    end

    -- calculate drawing parameters
    --  - determine per-axis scaling
    local scale_factor_x = region_width  / svg.width
    local scale_factor_y = region_height / svg.height

    --  - select final scale factor
    --  if we use the minimum of the two axes, we get a blank edge
    --  if we use the maximum of the two axes, we lose a bit of the image
    local scale_factor = 1
    if leave_no_edges == true then
        scale_factor = math.max(scale_factor_x,scale_factor_y)
    else
        scale_factor = math.min(scale_factor_x,scale_factor_y)
    end

    -- apply zoom
    scale_factor = scale_factor * zoom

    --  - centering offsets
    local centering_offset_x = 0
    local centering_offset_y = 0
    if scale_factor * svg.width > region_width then
            centering_offset_x = -math.floor(((scale_factor*svg.width)-region_width*zoom)*0.5)
    elseif scale_factor * svg.height > region_height then
            centering_offset_y = -math.floor(((scale_factor*svg.height)-region_height*zoom)*0.5)
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
    svg['border_color'] = border_color
    svg['border_width'] = border_width

    -- draw
    return table.insert(svglover.onscreen_svgs, svglover._dc(svg))
end

-- actually draw any svgs that are scheduled to be on screen
function svglover.draw()
    -- loop through on-screen SVGs
    for i,svg in ipairs(svglover.onscreen_svgs) do
        -- bounding box
        if svg.border_color ~= nil then
            love.graphics.setColor(svg.border_color[1]/255, svg.border_color[2]/255, svg.border_color[3]/255, svg.border_color[4]/255)
            love.graphics.rectangle('fill',svg.region_origin_x-svg.border_width, svg.region_origin_y-svg.border_width, svg.region_width+svg.border_width*2, svg.region_height+svg.border_width*2)
            love.graphics.setColor(0,0,0,1)
            love.graphics.rectangle('fill',svg.region_origin_x, svg.region_origin_y, svg.region_width, svg.region_height)
        end

        -- a viewport width/height of 0 disables drawing
        if svg.viewport == nil or (svg.viewport.width ~= 0 and svg.viewport.height ~= 0) then
            -- push graphics settings
            love.graphics.push()
            -- clip to the target region
            love.graphics.setScissor(svg.region_origin_x, svg.region_origin_y, svg.region_width, svg.region_height)
            -- draw in the target region
            love.graphics.translate(svg.region_origin_x+svg.cx, svg.region_origin_y+svg.cy)
            -- scale to the target region
            love.graphics.scale(svg.sfx, svg.sfy)

            -- SVG viewBox handling
            if svg.viewport ~= nil then
                love.graphics.translate(-svg.viewport.minx, -svg.viewport.miny)
                love.graphics.scale(1 / svg.viewport.width, 1 / svg.viewport.height)
            end

            -- draw
            assert(loadstring (svg.drawcommands)) ()
            -- disable clipping
            love.graphics.setScissor()
            -- reset graphics
            love.graphics.pop()
        end
    end
end

-- parse a color definition, returning the RGB components in the 0..1 range
function svglover._colorparse(str, default_r, default_g, default_b)
    if str == nil then
        return default_r, default_g, default_b
    end

    if str == "none" then
        return nil, nil, nil
    end

    -- #FFFFFF
    if string.match(str,"#......") then
        local red, green, blue = string.match(str,"#(..)(..)(..)")
        red = tonumber(red,16)/255
        green = tonumber(green,16)/255
        blue = tonumber(blue,16)/255
        return red, green, blue

    -- #FFF
    elseif string.match(str,"#...") then
        local red, green, blue = string.match(str,"#(.)(.)(.)")
        red = tonumber(red,16)/15
        green = tonumber(green,16)/15
        blue = tonumber(blue,16)/15
        return red, green, blue

    -- rgb(255, 255, 255)
    elseif string.match(str,"rgb%(%d+,%s*%d+,%s*%d+%)") then
        local red, green, blue = string.match(str,"rgb%((%d+),%s*(%d+),%s*(%d+)%)")
        red = tonumber(red)/255
        green = tonumber(green)/255
        blue = tonumber(blue)/255
        return red, green, blue

    -- rgb(100%, 100%, 100%)
    elseif string.match(str,"rgb%(%d+,%s*%d+,%s*%d+%)") then
        local red, green, blue = string.match(str,"rgb%((%d+)%%,%s*(%d+)%%,%s*(%d+)%%%)")
        red = tonumber(red)/100
        green = tonumber(green)/100
        blue = tonumber(blue)/100
        return red, green, blue

    -- Any unsupported format
    else
        return nil
    end
end

-- generates a lua table list literal from the given table
function svglover._unpackstr(data)
    local result = ""

    for i = 1, #data do
        result = result .. tostring(data[i])

        -- add commas
        if i < #data then
            result = result .. ","
        end
    end

    return result
end

-- generates LOVE code for a subpath
function svglover._gensubpath(vertices, f_red, f_green, f_blue, f_opacity, s_red, s_green, s_blue, s_opacity, linewidth, closed)
    if
        (f_red == nil and s_red == nil) or
        (#vertices < 4)
    then
        return ""
    end

    local result = ""
    result = result .. "local vertices = {" .. svglover._unpackstr(vertices) .. "}\n"

    -- fill
    if f_red ~= nil and #vertices >= 6 then
        result = result .. "love.graphics.setColor(" .. f_red .. "," .. f_green .. "," .. f_blue .. "," .. f_opacity .. ")\n"
        result = result .. "love.graphics.polygon(\"fill\", vertices)\n"
    end

    -- stroke
    if s_red ~= nil and #vertices >= 4 then
        result = result .. "love.graphics.setColor(" .. s_red .. "," .. s_green .. "," .. s_blue .. "," .. s_opacity .. ")\n"
        result = result .. "love.graphics.setLineWidth(" .. linewidth .. ")\n"

        if closed then
            result = result .. "love.graphics.polygon(\"line\", " .. svglover._unpackstr(vertices) .. ")\n"
        else
            result = result .. "love.graphics.line(vertices)\n"
        end
    end

    return result
end

-- parse an input line from an SVG, returning the equivalent LOVE code
function svglover._lineparse(line)

    -- path
    if string.match(line, '<path ') then
        -- SVG example:
        --   <path d="M 10,30
        --            A 20,20 0,0,1 50,30
        --            A 20,20 0,0,1 90,30
        --            Q 90,60 50,90
        --            Q 10,60 10,30 z"/>
        -- lua example:
        --   do
        --   local vertices = {60,40,70,40}
        --   love.graphics.setColor(r,g,b,a)
        --   love.graphics.setLineWidth(width)
        --   love.graphics.line(vertices)
        --   end

        -- get the stuff

        --  colors (red/green/blue)
        local f_red, f_green, f_blue = svglover._colorparse(string.match(line,"fill=\"([^\"]+)\""), 0, 0, 0, 1)
        local s_red, s_green, s_blue = svglover._colorparse(string.match(line,"stroke=\"([^\"]+)\""))

        --  opacity
        local opacity = string.match(line,"opacity=\"([^\"]+)\"")
        if opacity == nil then
            opacity = 1
        else
            opacity = tonumber(opacity,10)
        end

        --  fill-opacity
        local f_opacity = string.match(line,"fill-opacity=\"([^\"]+)\"")
        if f_opacity == nil then
            f_opacity = opacity
        else
            f_opacity = tonumber(f_opacity,10) * opacity
        end

        --  stroke-opacity
        local s_opacity = string.match(line,"stroke-opacity=\"([^\"]+)\"")
        if s_opacity == nil then
            s_opacity = opacity
        else
            s_opacity = tonumber(s_opacity,10) * opacity
        end

        -- stroke
        local linewidth = string.match(line,"stroke-width=\"([^\"]+)\"")
        if linewidth == nil then
            linewidth = 1
        else
            linewidth = tonumber(linewidth,10)
        end

        -- d (definition)
        local pathdef = string.match(line, " d=\"([^\"]+)\"")

        -- output
        local result = ""

        local ipx = 0
        local ipy = 0
        local cpx = 0
        local cpy = 0
        local closed = false
        local vertices = {}

        --  iterate through all dem commands
        for op, strargs in string.gmatch(pathdef, "%s*([MmLlHhVvCcSsQqTtAaZz])%s*([^MmLlHhVvCcSsQqTtAaZz]*)%s*") do
            local args = {}

            -- parse command arguments
            if strargs ~= nil and #strargs > 0 then
                for arg in string.gmatch(strargs, "%-?[^%s,%-]+") do
                   table.insert(args, 1, tonumber(arg,10))
                end
            end

            -- move to
            if op == "M" then
                if #vertices > 0 then
                    result = result .. svglover._gensubpath(
                        vertices,
                        f_red, f_green, f_blue, f_opacity,
                        s_red, s_green, s_blue, s_opacity,
                        linewidth, closed
                    )
                    vertices = {}
                end

                ipx = table.remove(args)
                ipy = table.remove(args)
                cpx = ipx
                cpy = ipy

                table.insert(vertices, cpx)
                table.insert(vertices, cpy)

                while #args >= 2 do
                    cpx = table.remove(args)
                    cpy = table.remove(args)

                    table.insert(vertices, cpx)
                    table.insert(vertices, cpy)
                end

            -- move to (relative)
            elseif op == "m" then
                if #vertices > 0 then
                    result = result .. svglover._gensubpath(
                        vertices,
                        f_red, f_green, f_blue, f_opacity,
                        s_red, s_green, s_blue, s_opacity,
                        linewidth, closed
                    )
                    vertices = {}
                end

                ipx = cpx + table.remove(args)
                ipy = cpy + table.remove(args)
                cpx = ipx
                cpy = ipy

                table.insert(vertices, cpx)
                table.insert(vertices, cpy)

                while #args >= 2 do
                    cpx = cpx + table.remove(args)
                    cpy = cpy + table.remove(args)

                    table.insert(vertices, cpx)
                    table.insert(vertices, cpy)
                end

            -- line to
            elseif op == "L" then
                while #args >= 2 do
                    cpx = table.remove(args)
                    cpy = table.remove(args)

                    table.insert(vertices, cpx)
                    table.insert(vertices, cpy)
                end

            -- line to (relative)
            elseif op == "l" then
                while #args >= 2 do
                    cpx = cpx + table.remove(args)
                    cpy = cpy + table.remove(args)

                    table.insert(vertices, cpx)
                    table.insert(vertices, cpy)
                end

            -- line to (horizontal)
            elseif op == "H" then
                while #args >= 1 do
                    cpx = table.remove(args)

                    table.insert(vertices, cpx)
                    table.insert(vertices, cpy)
                end

            -- line to (horizontal, relative)
            elseif op == "h" then
                while #args >= 1 do
                    cpx = cpx + table.remove(args)

                    table.insert(vertices, cpx)
                    table.insert(vertices, cpy)
                end

            -- line to (vertical)
            elseif op == "V" then
                while #args >= 1 do
                    cpy = table.remove(args)

                    table.insert(vertices, cpx)
                    table.insert(vertices, cpy)
                end

            -- line to (vertical, relative)
            elseif op == "v" then
                while #args >= 1 do
                    cpy = cpy + table.remove(args)

                    table.insert(vertices, cpx)
                    table.insert(vertices, cpy)
                end

            -- cubic bezier curve
            elseif op == "C" then

            -- cubic bezier curve (relative)
            elseif op == "c" then

            -- smooth cubic Bézier curve
            elseif op == "S" then

            -- smooth cubic Bézier curve (relative)
            elseif op == "s" then

            -- quadratic Bézier curve
            elseif op == "Q" then

            -- quadratic Bézier curve (relative)
            elseif op == "q" then

            -- smooth quadratic Bézier curve
            elseif op == "T" then

            -- smooth quadratic Bézier curve (relative)
            elseif op == "t" then

            -- arc to
            elseif op == "A" then

            -- arc to (relative)
            elseif op == "a" then

            -- close shape
            elseif op == "Z" then

            -- close shape (relative)
            elseif op == "z" then

            end
        end

        if #vertices > 0 then
            result = result .. svglover._gensubpath(
                vertices,
                f_red, f_green, f_blue, f_opacity,
                s_red, s_green, s_blue, s_opacity,
                linewidth, closed
            )
        end

        return result

    -- rectangle
    elseif string.match(line,'<rect ') then
        -- SVG example:
        --   <rect x="0" y="0" width="1024" height="680" fill="#79746f" />
        --   <rect fill="#1f1000" fill-opacity="0.501961" x="-0.5" y="-0.5" width="1" height="1" />
        -- lua example:
        --   love.graphics.setColor( red, green, blue, alpha )
        --   love.graphics.rectangle( "fill", x, y, width, height, rx, ry, segments )

        -- now, we get the parts

        --  x (x_offset)
        local x_offset = string.match(line," x=\"([^\"]+)\"")

        --  y (y_offset)
        local y_offset = string.match(line," y=\"([^\"]+)\"")

        --  width (width)
        local width = string.match(line," width=\"([^\"]+)\"")

        --  height (height)
        local height = string.match(line," height=\"([^\"]+)\"")

        --  fill (red/green/blue)
        local red, green, blue = svglover._colorparse(string.match(line,"fill=\"([^\"]+)\""), 0, 0, 0, 1)

        --  fill-opacity (alpha)
        local alpha = string.match(line,"opacity=\"([^\"]+)\"")
        if alpha == nil then
            alpha = 255
        else
            alpha = tonumber(alpha,10)
        end

        -- output
        local result = "love.graphics.setColor(" .. red .. "," .. green .. "," .. blue .. "," .. alpha .. ")\n"
        result = result .. "love.graphics.rectangle(\"fill\"," .. x_offset .. "," .. y_offset .. "," .. width .. "," .. height .. ")\n"

        return result

    -- ellipse or circle
    elseif string.match(line,'<ellipse ') or string.match(line,'<circle ') then
        -- SVG example:
        --   <ellipse fill="#ffffff" fill-opacity="0.501961" cx="81" cy="16" rx="255" ry="22" />
        --   <circle cx="114.279" cy="10.335" r="10"/>
        -- lua example:
        --   love.graphics.setColor( red, green, blue, alpha )
        --   love.graphics.ellipse( mode, x, y, radiusx, radiusy, segments )

        -- get parts
        --  cx (center_x)
        local center_x = string.match(line," cx=\"([^\"]+)\"")

        --  cy (center_y)
        local center_y = string.match(line," cy=\"([^\"]+)\"")

        --  r (radius, for a circle)
        local radius = string.match(line," r=\"([^\"]+)\"")

        local radius_x
        local radius_y
        if radius ~= nil then
            radius_x = radius
            radius_y = radius
        else
            --  rx (radius_x, for an ellipse)
            radius_x = string.match(line," rx=\"([^\"]+)\"")

            --  ry (radius_y, for an ellipse)
            radius_y = string.match(line," ry=\"([^\"]+)\"")
        end

        --  fill (red/green/blue)
        local red, green, blue = svglover._colorparse(string.match(line,"fill=\"([^\"]+)\""), 0, 0, 0, 1)

        --  fill-opacity (alpha)
        local alpha = string.match(line,"opacity=\"(.-)\"")
        if alpha == nil then
            alpha = 1
        else
            alpha = tonumber(alpha,10)
        end

        -- output
        local result = ''
        if red ~= nil then
            result = result .. "love.graphics.setColor(" .. red .. "," .. green .. "," .. blue .. "," .. alpha .. ")\n";
        end
        result = result .. "love.graphics.ellipse(\"fill\"," .. center_x .. "," .. center_y .. "," .. radius_x .. "," .. radius_y .. ",50)\n";
        return result

    -- polygon (eg. triangle)
    elseif string.match(line,'<polygon ') then
        -- SVG example:
        --   <polygon fill="--6f614e" fill-opacity="0.501961" points="191,131 119,10 35,29" />
        -- lua example:
        --   love.graphics.setColor( red, green, blue, alpha )
        --   love.graphics.polygon( mode, vertices )   -- where vertices is a list of x,y,x,y...

        --  fill (red/green/blue)
        local red, green, blue = svglover._colorparse(string.match(line,"fill=\"([^\"]+)\""), 0, 0, 0, 1)

        --  fill-opacity (alpha)
        local alpha = string.match(line,"opacity=\"(.-)\"")
        alpha = tonumber(alpha,10)

        --  points (vertices)
        local vertices = string.match(line," points=\"([^\"]+)\"")
        vertices = string.gsub(vertices,' ',',')

        -- output
        --   love.graphics.setColor( red, green, blue, alpha )
        local result = "love.graphics.setColor(" .. red .. "," .. green .. "," .. blue .. "," .. alpha .. ")\n"
        --   love.graphics.polygon( mode, vertices )   -- where vertices is a list of x,y,x,y...
        result = result .. "love.graphics.polygon(\"fill\",{" .. vertices .. "})\n";
        return result

    -- start or end svg etc.
    elseif  string.match(line,'</?svg') or
        string.match(line,'<.xml') or
        string.match(line,'<!--') or
        string.match(line,'</?title') or
        string.match(line,'<!DOCTYPE') then
        -- ignore

    -- end group
    elseif string.match(line,'</g>') then
        return 'love.graphics.pop()'

    -- start group
    elseif string.match(line,'<g[> ]') then
        --  SVG example:
        --    <g transform="translate(226 107) rotate(307) scale(3 11)">
        --    <g transform="scale(4.000000) translate(0.5 0.5)">
        --  lua example:
        --    love.graphics.push()
        --    love.graphics.translate( dx, dy )
        --    love.graphics.rotate( angle )
        --    love.graphics.scale( sx, sy )
        local result = "love.graphics.push()\n"
        -- extract the goodies
        --  translation offset
        local offset_x, offset_y = string.match(line,"[ \"]translate.([^) ]+) ([^) ]+)")
        --  rotation angle
        local angle = string.match(line,"rotate.([^)]+)")
        if angle ~= nil then
            angle = math.rad(angle)    -- convert degrees to radians
        end
        --  scale
        --  in error producing: love.graphics.scale(73 103,73 103)  ... from "scale(3 11)"
        local scale_x = 1
        local scale_y = 1
        local scale_string = string.match(line,"scale.([^)]+)")
        if scale_string ~= nil then
            scale_x, scale_y = string.match(scale_string,"([^ ]+) ([^ ]+)")
            if scale_x == nil then
                scale_x = scale_string
                scale_y = nil
            end
        end

        -- output
        if offset_x ~= nil and offset_y ~= nil then
            result = result .. "love.graphics.translate(" .. offset_x .. "," .. offset_y .. ")\n"
        end
        if angle ~= nil then
            result = result .. "love.graphics.rotate(" .. angle .. ")\n"
        end
        if scale_y ~= nil then
            result = result .. "love.graphics.scale(" .. scale_x .. "," .. scale_y .. ")\n";
        elseif scale_x ~= nil then
            result = result .. "love.graphics.scale(" .. scale_x .. "," .. scale_x .. ")\n";
        end
        return result
    else
        -- display issues so that those motivated to hack can do so ;)
        print("LINE '" .. line .. "' is unparseable!")
        os.exit()
    end
    return ''
end

-- deep copy
function svglover._dc(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[svglover._dc(orig_key)] = svglover._dc(orig_value)
        end
        setmetatable(copy, svglover._dc(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

-- simple hex dump
function svglover._hexdump(str)
    local len = string.len( str )
    local hex = ""
    for i = 1, len do
        local ord = string.byte( str, i )
        hex = hex .. string.format( "%02x ", ord )
    end
    return string.gsub(hex,' $','')
end

return svglover
