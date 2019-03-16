--[[

svglover
 Library to import and display simple SVGs in LÖVE.
 https://github.com/globalcitizen/svglover

--]]

local svglover = {}

svglover.onscreen_svgs = {}
svglover._colornames = {
    aliceblue = {240,248,255,255};
    antiquewhite = {250,235,215,255};
    aqua = {0,255,255,255};
    aquamarine = {127,255,212,255};
    azure = {240,255,255,255};
    beige = {245,245,220,255};
    bisque = {255,228,196,255};
    black = {0,0,0,255};
    blanchedalmond = {255,235,205,255};
    blue = {0,0,255,255};
    blueviolet = {138,43,226,255};
    brown = {165,42,42,255};
    burlywood = {222,184,135,255};
    cadetblue = {95,158,160,255};
    chartreuse = {127,255,0,255};
    chocolate = {210,105,30,255};
    coral = {255,127,80,255};
    cornflowerblue = {100,149,237,255};
    cornsilk = {255,248,220,255};
    crimson = {220,20,60,255};
    cyan = {0,255,255,255};
    darkblue = {0,0,139,255};
    darkcyan = {0,139,139,255};
    darkgoldenrod = {184,134,11,255};
    darkgray = {169,169,169,255};
    darkgreen = {0,100,0,255};
    darkgrey = {169,169,169,255};
    darkkhaki = {189,183,107,255};
    darkmagenta = {139,0,139,255};
    darkolivegreen = {85,107,47,255};
    darkorange = {255,140,0,255};
    darkorchid = {153,50,204,255};
    darkred = {139,0,0,255};
    darksalmon = {233,150,122,255};
    darkseagreen = {143,188,143,255};
    darkslateblue = {72,61,139,255};
    darkslategray = {47,79,79,255};
    darkslategrey = {47,79,79,255};
    darkturquoise = {0,206,209,255};
    darkviolet = {148,0,211,255};
    deeppink = {255,20,147,255};
    deepskyblue = {0,191,255,255};
    dimgray = {105,105,105,255};
    dimgrey = {105,105,105,255};
    dodgerblue = {30,144,255,255};
    firebrick = {178,34,34,255};
    floralwhite = {255,250,240,255};
    forestgreen = {34,139,34,255};
    fuchsia = {255,0,255,255};
    gainsboro = {220,220,220,255};
    ghostwhite = {248,248,255,255};
    gold = {255,215,0,255};
    goldenrod = {218,165,32,255};
    gray = {128,128,128,255};
    green = {0,128,0,255};
    greenyellow = {173,255,47,255};
    grey = {128,128,128,255};
    honeydew = {240,255,240,255};
    hotpink = {255,105,180,255};
    indianred = {205,92,92,255};
    indigo = {75,0,130,255};
    ivory = {255,255,240,255};
    khaki = {240,230,140,255};
    lavender = {230,230,250,255};
    lavenderblush = {255,240,245,255};
    lawngreen = {124,252,0,255};
    lemonchiffon = {255,250,205,255};
    lightblue = {173,216,230,255};
    lightcoral = {240,128,128,255};
    lightcyan = {224,255,255,255};
    lightgoldenrodyellow = {250,250,210,255};
    lightgray = {211,211,211,255};
    lightgreen = {144,238,144,255};
    lightgrey = {211,211,211,255};
    lightpink = {255,182,193,255};
    lightsalmon = {255,160,122,255};
    lightseagreen = {32,178,170,255};
    lightskyblue = {135,206,250,255};
    lightslategray = {119,136,153,255};
    lightslategrey = {119,136,153,255};
    lightsteelblue = {176,196,222,255};
    lightyellow = {255,255,224,255};
    lime = {0,255,0,255};
    limegreen = {50,205,50,255};
    linen = {250,240,230,255};
    magenta = {255,0,255,255};
    maroon = {128,0,0,255};
    mediumaquamarine = {102,205,170,255};
    mediumblue = {0,0,205,255};
    mediumorchid = {186,85,211,255};
    mediumpurple = {147,112,219,255};
    mediumseagreen = {60,179,113,255};
    mediumslateblue = {123,104,238,255};
    mediumspringgreen = {0,250,154,255};
    mediumturquoise = {72,209,204,255};
    mediumvioletred = {199,21,133,255};
    midnightblue = {25,25,112,255};
    mintcream = {245,255,250,255};
    mistyrose = {255,228,225,255};
    moccasin = {255,228,181,255};
    navajowhite = {255,222,173,255};
    navy = {0,0,128,255};
    oldlace = {253,245,230,255};
    olive = {128,128,0,255};
    olivedrab = {107,142,35,255};
    orange = {255,165,0,255};
    orangered = {255,69,0,255};
    orchid = {218,112,214,255};
    palegoldenrod = {238,232,170,255};
    palegreen = {152,251,152,255};
    paleturquoise = {175,238,238,255};
    palevioletred = {219,112,147,255};
    papayawhip = {255,239,213,255};
    peachpuff = {255,218,185,255};
    peru = {205,133,63,255};
    pink = {255,192,203,255};
    plum = {221,160,221,255};
    powderblue = {176,224,230,255};
    purple = {128,0,128,255};
    red = {255,0,0,255};
    rosybrown = {188,143,143,255};
    royalblue = {65,105,225,255};
    saddlebrown = {139,69,19,255};
    salmon = {250,128,114,255};
    sandybrown = {244,164,96,255};
    seagreen = {46,139,87,255};
    seashell = {255,245,238,255};
    sienna = {160,82,45,255};
    silver = {192,192,192,255};
    skyblue = {135,206,235,255};
    slateblue = {106,90,205,255};
    slategray = {112,128,144,255};
    slategrey = {112,128,144,255};
    snow = {255,250,250,255};
    springgreen = {0,255,127,255};
    steelblue = {70,130,180,255};
    tan = {210,180,140,255};
    teal = {0,128,128,255};
    thistle = {216,191,216,255};
    tomato = {255,99,71,255};
    turquoise = {64,224,208,255};
    violet = {238,130,238,255};
    wheat = {245,222,179,255};
    white = {255,255,255,255};
    whitesmoke = {245,245,245,255};
    yellow = {255,255,0,255};
    yellowgreen = {154,205,50 ,255};
}

-- load an svg and return it as a slightly marked up table
--  markup includes resolution detection
function svglover.load(svgfile, bezier_depth)
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
    --  - remove all comments
    file_contents = string.gsub(file_contents,"<!%-%-.-%-%->","")
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
        svg.drawcommands = svg.drawcommands .. "\n" .. svglover._lineparse(line, bezier_depth)
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

-- parse a color definition, returning the RGBA components in the 0..1 range
function svglover._colorparse(str, default_r, default_g, default_b, default_a)
    if str == nil then
        return default_r, default_g, default_b, default_a
    end

    if str == "none" then
        return nil, nil, nil, nil
    end

    -- color name
    if svglover._colornames[str] ~= nil then
        local color = svglover._colornames[str]
        return color[1] / 255, color[2] / 255, color[3] / 255, color[4] / 255

    -- #FFFFFF
    elseif string.match(str,"#......") then
        local red, green, blue = string.match(str,"#(..)(..)(..)")
        red = tonumber(red,16)/255
        green = tonumber(green,16)/255
        blue = tonumber(blue,16)/255
        return red, green, blue, 1

    -- #FFF
    elseif string.match(str,"#...") then
        local red, green, blue = string.match(str,"#(.)(.)(.)")
        red = tonumber(red,16)/15
        green = tonumber(green,16)/15
        blue = tonumber(blue,16)/15
        return red, green, blue, 1

    -- rgb(255, 255, 255)
    elseif string.match(str,"rgb%(%s*%d+%s*,%s*%d+%s*,%s*%d+%s*%)") then
        local red, green, blue = string.match(str,"rgb%((%d+),%s*(%d+),%s*(%d+)%)")
        red = tonumber(red)/255
        green = tonumber(green)/255
        blue = tonumber(blue)/255
        return red, green, blue, 1

    -- rgb(100%, 100%, 100%)
    elseif string.match(str,"rgb%(%s*%d+%%%s*,%s*%d+%%%s*,%s*%d+%%%s*%)") then
        local red, green, blue = string.match(str,"rgb%(%s*(%d+)%%%s*,%s*(%d+)%%%s*,%s*(%d+)%%%s*%)")
        red = tonumber(red)/100
        green = tonumber(green)/100
        blue = tonumber(blue)/100
        return red, green, blue, 1

    -- rgba(255, 255, 255, 1.0)
    elseif string.match(str,"rgba%(%s*%d+%s*,%s*%d+%s*,%s*%d+%s*,%s*[^%)%+s]+%s*%)") then
        local red, green, blue, alpha = string.match(str,"rgba%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*,%s*([^%)%s]+)%s*%)")
        red = tonumber(red)/255
        green = tonumber(green)/255
        blue = tonumber(blue)/255
        return red, green, blue, tonumber(alpha,10)

    -- rgba(100%, 100%, 100%, 1.0)
    elseif string.match(str,"rgba%(%s*%d+%%%s*,%s*%d+%%%s*,%s*%d+%%%s*,%s*[^%)%s]+%s*%)") then
        local red, green, blue, alpha = string.match(str,"rgba%(%s*(%d+)%%%s*,%s*(%d+)%%%s*,%s*(%d+)%%%s*,%s*([^%)%s]+)%s*%)")
        red = tonumber(red)/100
        green = tonumber(green)/100
        blue = tonumber(blue)/100
        return red, green, blue, tonumber(alpha,10)

    -- Any unsupported format
    else
        -- let em know!!!
        print("Unsupported color format: " .. str)
        return nil, nil, nil, nil
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
function svglover._gensubpath(
    vertices,
    f_red, f_green, f_blue, f_alpha, f_opacity,
    s_red, s_green, s_blue, s_alpha, s_opacity,
    opacity, linewidth, closed)
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
        result = result .. "love.graphics.setColor(" .. f_red .. "," .. f_green .. "," .. f_blue .. "," .. (f_alpha * f_opacity * opacity) .. ")\n"
        result = result .. "love.graphics.polygon(\"fill\", vertices)\n"
    end

    -- stroke
    if s_red ~= nil and #vertices >= 4 then
        result = result .. "love.graphics.setColor(" .. s_red .. "," .. s_green .. "," .. s_blue .. "," .. (s_alpha * s_opacity * opacity) .. ")\n"
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
function svglover._lineparse(line, bezier_depth)

    -- path
    if string.match(line, '<path%s') then
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
        local f_red, f_green, f_blue, f_alpha = svglover._colorparse(string.match(line,"%sfill=\"([^\"]+)\""), 0, 0, 0, 1)
        local s_red, s_green, s_blue, s_alpha = svglover._colorparse(string.match(line,"%sstroke=\"([^\"]+)\""), nil, nil, nil, 1)

        --  opacity
        local opacity = string.match(line,"%sopacity=\"([^\"]+)\"")
        if opacity == nil then
            opacity = 1
        else
            opacity = tonumber(opacity,10)
        end

        --  fill-opacity
        local f_opacity = string.match(line,"%sfill%-opacity=\"([^\"]+)\"")
        if f_opacity == nil then
            f_opacity = 1
        else
            f_opacity = tonumber(f_opacity,10)
        end

        --  stroke-opacity
        local s_opacity = string.match(line,"%sstroke%-opacity=\"([^\"]+)\"")
        if s_opacity == nil then
            s_opacity = 1
        else
            s_opacity = tonumber(s_opacity,10)
        end

        -- stroke
        local linewidth = string.match(line,"%sstroke-width=\"([^\"]+)\"")
        if linewidth == nil then
            linewidth = 1
        else
            linewidth = tonumber(linewidth,10)
        end

        -- d (definition)
        local pathdef = string.match(line, "%sd=\"([^\"]+)\"")

        -- output
        local result = ""

        local ipx = 0
        local ipy = 0
        local cpx = 0
        local cpy = 0
        local prev_x2 = 0
        local prev_y2 = 0
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
                        f_red, f_green, f_blue, f_alpha, f_opacity,
                        s_red, s_green, s_blue, s_alpha, s_opacity,
                        opacity, linewidth, closed
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
                        f_red, f_green, f_blue, f_alpha, f_opacity,
                        s_red, s_green, s_blue, s_alpha, s_opacity,
                        opacity, linewidth, closed
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
                while #args >= 6 do
                    local x1 = table.remove(args)
                    local y1 = table.remove(args)
                    local x2 = table.remove(args)
                    local y2 = table.remove(args)
                    local x = table.remove(args)
                    local y = table.remove(args)

                    -- generate vertices
                    local curve = love.math.newBezierCurve(cpx, cpy, x, y)
                    curve:insertControlPoint(x1, y1)
                    curve:insertControlPoint(x2, y2)

                    for _, v in ipairs(curve:render(bezier_depth)) do
                        table.insert(vertices, v)
                    end

                    -- release object
                    curve:release()

                    -- move the current point
                    cpx = x
                    cpy = y

                    -- remember the end control point for the next command
                    prev_x2 = x2
                    prev_y2 = y2
                end

            -- cubic bezier curve (relative)
            elseif op == "c" then
                while #args >= 6 do
                    local x1 = cpx + table.remove(args)
                    local y1 = cpy + table.remove(args)
                    local x2 = cpx + table.remove(args)
                    local y2 = cpy + table.remove(args)
                    local x = cpx + table.remove(args)
                    local y = cpy + table.remove(args)

                    -- generate vertices
                    local curve = love.math.newBezierCurve(cpx, cpy, x, y)
                    curve:insertControlPoint(x1, y1)
                    curve:insertControlPoint(x2, y2)

                    for _, v in ipairs(curve:render(bezier_depth)) do
                        table.insert(vertices, v)
                    end

                    -- release object
                    curve:release()

                    -- move the current point
                    cpx = x
                    cpy = y

                    -- remember the end control point for the next command
                    prev_x2 = x2
                    prev_y2 = y2
                end

            -- smooth cubic Bézier curve
            elseif op == "S" then
                while #args >= 4 do
                    local x2 = table.remove(args)
                    local y2 = table.remove(args)
                    local x = table.remove(args)
                    local y = table.remove(args)

                    -- calculate the start control point
                    local x1 = cpx + cpx - prev_x2
                    local y1 = cpy + cpy - prev_y2

                    -- generate vertices
                    local curve = love.math.newBezierCurve(cpx, cpy, x, y)
                    curve:insertControlPoint(x1, y1)
                    curve:insertControlPoint(x2, y2)

                    for _, v in ipairs(curve:render(bezier_depth)) do
                        table.insert(vertices, v)
                    end

                    -- release object
                    curve:release()

                    -- move the current point
                    cpx = x
                    cpy = y

                    -- remember the end control point for the next command
                    prev_x2 = x2
                    prev_y2 = y2
                end

            -- smooth cubic Bézier curve (relative)
            elseif op == "s" then
                while #args >= 4 do
                    local x2 = cpx + table.remove(args)
                    local y2 = cpy + table.remove(args)
                    local x = cpx + table.remove(args)
                    local y = cpy + table.remove(args)

                    -- calculate the start control point
                    local x1 = cpx + cpx - prev_x2
                    local y1 = cpy + cpy - prev_y2

                    -- generate vertices
                    local curve = love.math.newBezierCurve(cpx, cpy, x, y)
                    curve:insertControlPoint(x1, y1)
                    curve:insertControlPoint(x2, y2)

                    for _, v in ipairs(curve:render(bezier_depth)) do
                        table.insert(vertices, v)
                    end

                    -- release object
                    curve:release()

                    -- move the current point
                    cpx = x
                    cpy = y

                    -- remember the end control point for the next command
                    prev_x2 = x2
                    prev_y2 = y2
                end

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

            -- if the command wasn't a curve command, set prev_x2 and prev_y2 to cpx and cpy
            if not string.match(op, "[CcSsQqTt]") then
                prev_x2 = cpx
                prev_y2 = cpy
            end
        end

        if #vertices > 0 then
            result = result .. svglover._gensubpath(
                vertices,
                f_red, f_green, f_blue, f_alpha, f_opacity,
                s_red, s_green, s_blue, s_alpha, s_opacity,
                opacity, linewidth, closed
            )
        end

        return result

    -- rectangle
    elseif string.match(line,'<rect%s') then
        -- SVG example:
        --   <rect x="0" y="0" width="1024" height="680" fill="#79746f" />
        --   <rect fill="#1f1000" fill-opacity="0.501961" x="-0.5" y="-0.5" width="1" height="1" />
        -- lua example:
        --   love.graphics.setColor( red, green, blue, alpha )
        --   love.graphics.rectangle( "fill", x, y, width, height, rx, ry, segments )

        -- now, we get the parts

        --  x (x_offset)
        local x_offset = string.match(line,"%sx=\"([^\"]+)\"")

        --  y (y_offset)
        local y_offset = string.match(line,"%sy=\"([^\"]+)\"")

        --  width (width)
        local width = string.match(line,"%swidth=\"([^\"]+)\"")

        --  height (height)
        local height = string.match(line,"%sheight=\"([^\"]+)\"")

        --  fill (red/green/blue)
        local red, green, blue = svglover._colorparse(string.match(line,"%sfill=\"([^\"]+)\""), 0, 0, 0, 1)

        --  fill-opacity (alpha)
        local alpha = string.match(line,"%sopacity=\"([^\"]+)\"")
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
    elseif string.match(line,'<ellipse%s') or string.match(line,'<circle ') then
        -- SVG example:
        --   <ellipse fill="#ffffff" fill-opacity="0.501961" cx="81" cy="16" rx="255" ry="22" />
        --   <circle cx="114.279" cy="10.335" r="10"/>
        -- lua example:
        --   love.graphics.setColor( red, green, blue, alpha )
        --   love.graphics.ellipse( mode, x, y, radiusx, radiusy, segments )

        -- get parts
        --  cx (center_x)
        local center_x = string.match(line,"%scx=\"([^\"]+)\"")

        --  cy (center_y)
        local center_y = string.match(line,"%scy=\"([^\"]+)\"")

        --  r (radius, for a circle)
        local radius = string.match(line,"%sr=\"([^\"]+)\"")

        local radius_x
        local radius_y
        if radius ~= nil then
            radius_x = radius
            radius_y = radius
        else
            --  rx (radius_x, for an ellipse)
            radius_x = string.match(line,"%srx=\"([^\"]+)\"")

            --  ry (radius_y, for an ellipse)
            radius_y = string.match(line,"%sry=\"([^\"]+)\"")
        end

        --  fill (red/green/blue)
        local red, green, blue = svglover._colorparse(string.match(line,"%sfill=\"([^\"]+)\""), 0, 0, 0, 1)

        --  fill-opacity (alpha)
        local alpha = string.match(line,"%sopacity=\"(.-)\"")
        if alpha == nil then
            alpha = 1
        else
            alpha = tonumber(alpha,10)
        end

        -- output
        local result = ''
        if red ~= nil then
            result = result .. "love.graphics.setColor(" .. red .. "," .. green .. "," .. blue .. "," .. alpha .. ")\n"
        end
        result = result .. "love.graphics.ellipse(\"fill\"," .. center_x .. "," .. center_y .. "," .. radius_x .. "," .. radius_y .. ",50)\n"
        return result

    -- polygon (eg. triangle)
    elseif string.match(line,'<polygon%s') then
        -- SVG example:
        --   <polygon fill="6f614e" fill-opacity="0.501961" points="191,131 119,10 35,29" />
        -- lua example:
        --   love.graphics.setColor( red, green, blue, alpha )
        --   love.graphics.polygon( mode, vertices )   -- where vertices is a list of x,y,x,y...

        --  colors
        local f_red, f_green, f_blue, f_alpha = svglover._colorparse(string.match(line,"%sfill=\"([^\"]+)\""), 0, 0, 0, 1)
        local s_red, s_green, s_blue, s_alpha = svglover._colorparse(string.match(line,"%sstroke=\"([^\"]+)\""), nil, nil, nil, 1)

        --  opacity
        local opacity = string.match(line,"%sopacity=\"([^\"]+)\"")
        if opacity == nil then
            opacity = 1
        else
            opacity = tonumber(opacity,10)
        end

        --  fill-opacity
        local f_opacity = string.match(line,"%sfill%-opacity=\"([^\"]+)\"")
        if f_opacity == nil then
            f_opacity = 1
        else
            f_opacity = tonumber(f_opacity,10)
        end

        --  stroke-opacity
        local s_opacity = string.match(line,"%sstroke%-opacity=\"([^\"]+)\"")
        if s_opacity == nil then
            s_opacity = 1
        else
            s_opacity = tonumber(s_opacity,10)
        end

        if f_red == nil and s_red == nil then
            return ""
        end
        
        --  points (vertices)
        local vertices = string.match(line,"%spoints=\"([^\"]+)\"")
        vertices = string.gsub(vertices,'^%s+','')
        vertices = string.gsub(vertices,'%s+$','')
        vertices = string.gsub(vertices,'%s+',',')
        vertices = string.gsub(vertices,',+',',')

        -- output
        local result = "do\n"
        result = result .. "local vertices = {" .. vertices .. "}"
        if f_red ~= nil then
            result = result .. "love.graphics.setColor(" .. f_red .. "," .. f_green .. "," .. f_blue .. "," .. (f_alpha * f_opacity * opacity) .. ")\n"
            result = result .. "love.graphics.polygon(\"fill\", vertices)\n"
        end

        if s_red ~= nil then
            result = result .. "love.graphics.setColor(" .. s_red .. "," .. s_green .. "," .. s_blue .. "," .. (s_alpha * s_opacity * opacity) .. ")\n"
            result = result .. "love.graphics.polygon(\"line\", vertices)\n"
        end
        
        return result .. "end\n"

    -- polyline (eg. triangle, but not closed)
    elseif string.match(line,'<polyline%s') then
        -- SVG example:
        --   <polyline fill="#6f614e" fill-opacity="0.501961" points="191,131 119,10 35,29" />
        -- lua example:
        --   love.graphics.setColor( red, green, blue, alpha )
        --   love.graphics.line( vertices )   -- where vertices is a list of x,y,x,y...

        --  colors
        local f_red, f_green, f_blue, f_alpha = svglover._colorparse(string.match(line,"%sfill=\"([^\"]+)\""), 0, 0, 0, 1)
        local s_red, s_green, s_blue, s_alpha = svglover._colorparse(string.match(line,"%sstroke=\"([^\"]+)\""), nil, nil, nil, 1)

        --  opacity
        local opacity = string.match(line,"%sopacity=\"([^\"]+)\"")
        if opacity == nil then
            opacity = 1
        else
            opacity = tonumber(opacity,10)
        end

        --  fill-opacity
        local f_opacity = string.match(line,"%sfill%-opacity=\"([^\"]+)\"")
        if f_opacity == nil then
            f_opacity = 1
        else
            f_opacity = tonumber(f_opacity,10)
        end

        --  stroke-opacity
        local s_opacity = string.match(line,"%sstroke%-opacity=\"([^\"]+)\"")
        if s_opacity == nil then
            s_opacity = 1
        else
            s_opacity = tonumber(s_opacity,10)
        end

        if f_red == nil and s_red == nil then
            return ""
        end
        
        --  points (vertices)
        local vertices = string.match(line,"%spoints=\"([^\"]+)\"")
        vertices = string.gsub(vertices,'^%s+','')
        vertices = string.gsub(vertices,'%s+$','')
        vertices = string.gsub(vertices,'%s+',',')
        vertices = string.gsub(vertices,',+',',')

        -- output
        local result = "do\n"
        result = result .. "local vertices = {" .. vertices .. "}"

        if f_red ~= nil then
            result = result .. "love.graphics.setColor(" .. f_red .. "," .. f_green .. "," .. f_blue .. "," .. (f_alpha * f_opacity * opacity) .. ")\n"
            result = result .. "love.graphics.polygon(\"fill\", vertices)\n"
        end

        if s_red ~= nil then
            result = result .. "love.graphics.setColor(" .. s_red .. "," .. s_green .. "," .. s_blue .. "," .. (s_alpha * s_opacity * opacity) .. ")\n"
            result = result .. "love.graphics.line(vertices)\n"
        end

        return result .. "end\n"

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
    elseif string.match(line,'<g[>%s]') then
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
            result = result .. "love.graphics.scale(" .. scale_x .. "," .. scale_y .. ")\n"
        elseif scale_x ~= nil then
            result = result .. "love.graphics.scale(" .. scale_x .. "," .. scale_x .. ")\n"
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
