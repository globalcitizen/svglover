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
function svglover.load(svgfile, options)
    options = options or {}

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
        extdata = {};
        drawcommands = 'local extdata = ...\n';
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
        local def = string.match(file_contents, "<svg[^>]+viewBox=\"(.-)\"")
        local next_num = string.gmatch(def, "%-?[^%s,%-]+")

        svg.viewport = {
            minx = tonumber(next_num());
            miny = tonumber(next_num());
            width = tonumber(next_num());
            height = tonumber(next_num());
        }
    end

    --  - finally, loop over lines, appending to svg.drawcommands
    local state = {
        parent_attr_stack = {};
    }

    for line in string.gmatch(file_contents, "[^\n]+") do
        -- parse it
        svg.drawcommands = svg.drawcommands .. "\n" .. svglover._lineparse(state, line, svg.extdata, options)
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
                love.graphics.scale(svg.width / svg.viewport.width, svg.height / svg.viewport.height)
            end

            -- draw
            assert(loadstring (svg.drawcommands)) (svg.extdata)
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
    options, extdata, bufferid,
    f_red, f_green, f_blue, f_alpha, f_opacity,
    s_red, s_green, s_blue, s_alpha, s_opacity,
    opacity, linewidth, closed)
    local vertices = extdata[bufferid]
    local vertexcount = #vertices

    if
        (f_red == nil and s_red == nil) or
        (vertexcount < 4)
    then
        return ""
    end

    local result = ""

    -- fill
    if f_red ~= nil and vertexcount >= 6 then
        if options.use_love_fill == true then
            result = result ..
                "love.graphics.setColor(" .. f_red .. "," .. f_green .. "," .. f_blue .. "," .. (f_alpha * f_opacity * opacity) .. ")\n" ..
                "love.graphics.polygon(\"fill\", extdata[" .. bufferid .. "])"
        else
            local minx, miny, maxx, maxy = vertices[1], vertices[2], vertices[1], vertices[2]

            for i = 3, vertexcount, 2 do
                minx = math.min(minx, vertices[i])
                miny = math.min(miny, vertices[i+1])
                maxx = math.max(maxx, vertices[i])
                maxy = math.max(maxy, vertices[i+1])
            end

            local stencil_fn =
                "local extdata = ...\n" ..
                "return function() love.graphics.polygon(\"fill\", extdata[" .. bufferid .. "]) end\n"

            -- insert the stencil rendering function
            table.insert(extdata, assert(loadstring(stencil_fn))(extdata))

            result = result ..
                "love.graphics.stencil(extdata[" .. (#extdata) .. "], \"invert\")\n" ..
                "love.graphics.setStencilTest(\"notequal\", 0)\n" ..
                "love.graphics.setColor(" .. f_red .. "," .. f_green .. "," .. f_blue .. "," .. (f_alpha * f_opacity * opacity) .. ")\n" ..
                "love.graphics.rectangle(\"fill\"," .. minx .. "," .. miny .. "," .. (maxx-minx) .. "," .. (maxy-miny) .. ")" ..
                "love.graphics.setStencilTest()\n"
        end
    end

    -- stroke
    if s_red ~= nil and vertexcount >= 4 then
        result = result .. "love.graphics.setColor(" .. s_red .. "," .. s_green .. "," .. s_blue .. "," .. (s_alpha * s_opacity * opacity) .. ")\n"
        result = result .. "love.graphics.setLineWidth(" .. linewidth .. ")\n"

        if closed == true then
            result = result .. "love.graphics.polygon(\"line\", extdata[" .. bufferid .. "])\n"
        else
            result = result .. "love.graphics.line(extdata[" .. bufferid .. "])\n"
        end
    end

    return result
end

function svglover._getattributes(line, defaults)
    local attributes = {}

    if defaults ~= nil then
        for name, value in pairs(defaults) do
            attributes[name] = value
        end
    end

    for name, value in string.gmatch(line, "%s([:A-Z_a-z][:A-Z_a-z0-9%-%.]*)%s*=%s*[\"'](.-)[\"']") do
        attributes[name] = value
    end

    return attributes
end

function svglover._parsetransform(transform, extdata)
    local result = ""

    -- parse every command
    for cmd, strargs in string.gmatch(transform, "%s*(.-)%s*%((.-)%)") do
        local args = {}

        -- parse command arguments
        if strargs ~= nil and #strargs > 0 then
            for arg in string.gmatch(strargs, "%-?[^%s,%-]+") do
               table.insert(args, 1, tonumber(arg,10))
            end
        end

        -- translate
        if cmd == "translate" then
            local x = table.remove(args)
            local y = table.remove(args) or 0

            result = result .. "love.graphics.translate(" .. x .. ", " .. y .. ")\n"

        -- rotate
        elseif cmd == "rotate" then
            local a = table.remove(args)
            local x = table.remove(args) or 0
            local y = table.remove(args) or 0

            if x ~= 0 and y ~= 0 then
                result = result .. "love.graphics.translate(" .. x .. ", " .. y .. ")\n"
            end

            result = result .. "love.graphics.rotate(" .. math.rad(a) .. ")\n"

            if x ~= 0 and y ~= 0 then
                result = result .. "love.graphics.translate(" .. (-x) .. ", " .. (-y) .. ")\n"
            end

        -- scale
        elseif cmd == "scale" then
            local x = table.remove(args)
            local y = table.remove(args)

            if y == nil then
                y = x
            end

            result = result .. "love.graphics.scale(" .. x .. ", " .. y .. ")\n"

        -- matrix
        elseif cmd == "matrix" then
            local a = table.remove(args)
            local b = table.remove(args)
            local c = table.remove(args)
            local d = table.remove(args)
            local e = table.remove(args)
            local f = table.remove(args)

            local matrix = love.math.newTransform()
            matrix:setMatrix(
                a, c, e, 0,
                b, d, f, 0,
                0, 0, 1, 0,
                0, 0, 0, 1
            )
            table.insert(extdata, matrix)

            result = result .. "love.graphics.applyTransform(extdata[" .. (#extdata) .. "])\n"

        elseif cmd == "skewX" then
            local a = table.remove(args)

            result = result .. "love.graphics.shear(" .. math.rad(a) .. ", 0)\n"

        elseif cmd == "skewY" then
            local a = table.remove(args)

            result = result .. "love.graphics.shear(0, " .. math.rad(a) .. ")\n"

        else
            -- let em know what's missing!!!
            print("Unimplemented transform command: " .. cmd .. "!")
            os.exit()
        end
    end

    return result
end

-- parse an input line from an SVG, returning the equivalent LOVE code
function svglover._lineparse(state, line, extdata, options)
    local parent_attr = state.parent_attr_stack[#(state.parent_attr_stack)]
    local bezier_depth = options["bezier_depth"]

    if bezier_depth == nil then
        bezier_depth = 5
    end

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
        local attr = svglover._getattributes(line, parent_attr)

        --  colors (red/green/blue)
        local f_red, f_green, f_blue, f_alpha = svglover._colorparse(attr["fill"], 0, 0, 0, 1)
        local s_red, s_green, s_blue, s_alpha = svglover._colorparse(attr["stroke"])

        --  opacity
        local opacity = attr["opacity"]
        if opacity == nil then
            opacity = 1
        else
            opacity = tonumber(opacity,10)
        end

        --  fill-opacity
        local f_opacity = attr["fill-opacity"]
        if f_opacity == nil then
            f_opacity = 1
        else
            f_opacity = tonumber(f_opacity,10)
        end

        --  stroke-opacity
        local s_opacity = attr["stroke-opacity"]
        if s_opacity == nil then
            s_opacity = 1
        else
            s_opacity = tonumber(s_opacity,10)
        end

        -- stroke
        local linewidth = attr["stroke-width"]
        if linewidth == nil then
            linewidth = 1
        else
            linewidth = tonumber(linewidth,10)
        end

        -- d (definition)
        local pathdef = attr["d"]

        -- output
        local result = ""

        local ipx = 0
        local ipy = 0
        local cpx = 0
        local cpy = 0
        local prev_ctrlx = 0
        local prev_ctrly = 0
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
                    table.insert(extdata, vertices)
                    result = result .. svglover._gensubpath(
                        options, extdata, #extdata,
                        f_red, f_green, f_blue, f_alpha, f_opacity,
                        s_red, s_green, s_blue, s_alpha, s_opacity,
                        opacity, linewidth
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
                    table.insert(extdata, vertices)
                    result = result .. svglover._gensubpath(
                        options, extdata, #extdata,
                        f_red, f_green, f_blue, f_alpha, f_opacity,
                        s_red, s_green, s_blue, s_alpha, s_opacity,
                        opacity, linewidth
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
                    prev_ctrlx = x2
                    prev_ctrly = y2
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
                    prev_ctrlx = x2
                    prev_ctrly = y2
                end

            -- smooth cubic Bézier curve
            elseif op == "S" then
                while #args >= 4 do
                    local x2 = table.remove(args)
                    local y2 = table.remove(args)
                    local x = table.remove(args)
                    local y = table.remove(args)

                    -- calculate the start control point
                    local x1 = cpx + cpx - prev_ctrlx
                    local y1 = cpy + cpy - prev_ctrly

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
                    prev_ctrlx = x2
                    prev_ctrly = y2
                end

            -- smooth cubic Bézier curve (relative)
            elseif op == "s" then
                while #args >= 4 do
                    local x2 = cpx + table.remove(args)
                    local y2 = cpy + table.remove(args)
                    local x = cpx + table.remove(args)
                    local y = cpy + table.remove(args)

                    -- calculate the start control point
                    local x1 = cpx + cpx - prev_ctrlx
                    local y1 = cpy + cpy - prev_ctrly

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
                    prev_ctrlx = x2
                    prev_ctrly = y2
                end

            -- quadratic Bézier curve
            elseif op == "Q" then
                while #args >= 4 do
                    local x1 = table.remove(args)
                    local y1 = table.remove(args)
                    local x = table.remove(args)
                    local y = table.remove(args)

                    -- generate vertices
                    local curve = love.math.newBezierCurve(cpx, cpy, x, y)
                    curve:insertControlPoint(x1, y1)

                    for _, v in ipairs(curve:render(bezier_depth)) do
                        table.insert(vertices, v)
                    end

                    -- release object
                    curve:release()

                    -- move the current point
                    cpx = x
                    cpy = y

                    -- remember the end control point for the next command
                    prev_ctrlx = x1
                    prev_ctrly = y1
                end

            -- quadratic Bézier curve (relative)
            elseif op == "q" then
                while #args >= 4 do
                    local x1 = cpx + table.remove(args)
                    local y1 = cpy + table.remove(args)
                    local x = cpx + table.remove(args)
                    local y = cpy + table.remove(args)

                    -- generate vertices
                    local curve = love.math.newBezierCurve(cpx, cpy, x, y)
                    curve:insertControlPoint(x1, y1)

                    for _, v in ipairs(curve:render(bezier_depth)) do
                        table.insert(vertices, v)
                    end

                    -- release object
                    curve:release()

                    -- move the current point
                    cpx = x
                    cpy = y

                    -- remember the end control point for the next command
                    prev_ctrlx = x1
                    prev_ctrly = y1
                end

            -- smooth quadratic Bézier curve
            elseif op == "T" then
                while #args >= 2 do
                    local x = table.remove(args)
                    local y = table.remove(args)

                    -- calculate the control point
                    local x1 = cpx + cpx - prev_ctrlx
                    local y1 = cpy + cpy - prev_ctrly

                    -- generate vertices
                    local curve = love.math.newBezierCurve(cpx, cpy, x, y)
                    curve:insertControlPoint(x1, y1)

                    for _, v in ipairs(curve:render(bezier_depth)) do
                        table.insert(vertices, v)
                    end

                    -- release object
                    curve:release()

                    -- move the current point
                    cpx = x
                    cpy = y

                    -- remember the end control point for the next command
                    prev_ctrlx = x1
                    prev_ctrly = y1
                end

            -- smooth quadratic Bézier curve (relative)
            elseif op == "t" then
                while #args >= 2 do
                    local x = cpx + table.remove(args)
                    local y = cpy + table.remove(args)

                    -- calculate the control point
                    local x1 = cpx + cpx - prev_ctrlx
                    local y1 = cpy + cpy - prev_ctrly

                    -- generate vertices
                    local curve = love.math.newBezierCurve(cpx, cpy, x, y)
                    curve:insertControlPoint(x1, y1)

                    for _, v in ipairs(curve:render(bezier_depth)) do
                        table.insert(vertices, v)
                    end

                    -- release object
                    curve:release()

                    -- move the current point
                    cpx = x
                    cpy = y

                    -- remember the end control point for the next command
                    prev_ctrlx = x1
                    prev_ctrly = y1
                end

            -- arc to
            elseif op == "A" then
                print("ArcTo not implemented")

            -- arc to (relative)
            elseif op == "a" then
                print("Relative ArcTo not implemented")

            -- close shape (relative and absolute are the same)
            elseif op == "Z" or op == "z" then
                if #vertices > 0 then
                    table.insert(extdata, vertices)
                    result = result .. svglover._gensubpath(
                        options, extdata, #extdata,
                        f_red, f_green, f_blue, f_alpha, f_opacity,
                        s_red, s_green, s_blue, s_alpha, s_opacity,
                        opacity, linewidth, true
                    )
                end

                cpx = ipx
                cpy = ipy

                table.insert(vertices, cpx)
                table.insert(vertices, cpy)
            end

            -- if the command wasn't a curve command, set prev_ctrlx and prev_ctrly to cpx and cpy
            if not string.match(op, "[CcSsQqTt]") then
                prev_ctrlx = cpx
                prev_ctrly = cpy
            end
        end

        if #vertices > 0 then
            table.insert(extdata, vertices)
            result = result .. svglover._gensubpath(
                options, extdata, #extdata,
                f_red, f_green, f_blue, f_alpha, f_opacity,
                s_red, s_green, s_blue, s_alpha, s_opacity,
                opacity, linewidth
            )
        end

        if attr["transform"] ~= nil then
            result =
                "love.graphics.push()\n" ..
                svglover._parsetransform(attr["transform"], extdata) ..
                result ..
                "love.graphics.pop()\n"
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
        local attr = svglover._getattributes(line, parent_attr)

        --  x (x_offset)
        local x_offset = attr["x"]

        --  y (y_offset)
        local y_offset = attr["y"]

        --  width (width)
        local width = attr["width"]

        --  height (height)
        local height = attr["height"]

        --  fill (red/green/blue)
        local f_red, f_green, f_blue, f_alpha = svglover._colorparse(attr["fill"], 0, 0, 0, 1)
        local s_red, s_green, s_blue, s_alpha = svglover._colorparse(attr["stroke"])

        --  opacity
        local opacity = attr["opacity"]
        if opacity == nil then
            opacity = 1
        else
            opacity = tonumber(opacity,10)
        end

        --  fill-opacity
        local f_opacity = attr["fill-opacity"]
        if f_opacity == nil then
            f_opacity = 1
        else
            f_opacity = tonumber(f_opacity,10)
        end

        --  stroke-opacity
        local s_opacity = attr["stroke-opacity"]
        if s_opacity == nil then
            s_opacity = 1
        else
            s_opacity = tonumber(s_opacity,10)
        end

        -- output
        local result = ""

        if f_red ~= nil then
            result = result .. "love.graphics.setColor(" .. f_red .. "," .. f_green .. "," .. f_blue .. "," .. (f_alpha * f_opacity * opacity) .. ")\n"
            result = result .. "love.graphics.rectangle(\"fill\"," .. x_offset .. "," .. y_offset .. "," .. width .. "," .. height .. ")\n"
        end

        if s_red ~= nil then
            result = result .. "love.graphics.setColor(" .. s_red .. "," .. s_green .. "," .. s_blue .. "," .. (s_alpha * s_opacity * opacity) .. ")\n"
            result = result .. "love.graphics.rectangle(\"line\"," .. x_offset .. "," .. y_offset .. "," .. width .. "," .. height .. ")\n"
        end

        if attr["transform"] ~= nil then
            result =
                "love.graphics.push()\n" ..
                svglover._parsetransform(attr["transform"], extdata) ..
                result ..
                "love.graphics.pop()\n"
        end

        return result

    -- ellipse or circle
    elseif string.match(line,'<ellipse%s') or string.match(line,'<circle ') then
        -- SVG example:
        --   <ellipse fill="#ffffff" fill-opacity="0.501961" cx="81" cy="16" rx="255" ry="22" />
        --   <circle cx="114.279" cy="10.335" r="10"/>
        -- lua example:
        --   love.graphics.setColor( red, green, blue, alpha )
        --   love.graphics.ellipse( mode, x, y, radiusx, radiusy, segments )

        -- get attributes
        local attr = svglover._getattributes(line, parent_attr)

        --  cx (center_x)
        local center_x = attr["cx"]

        --  cy (center_y)
        local center_y = attr["cy"]

        --  r (radius, for a circle)
        local radius = attr["r"]

        local radius_x
        local radius_y
        if radius ~= nil then
            radius_x = radius
            radius_y = radius
        else
            --  rx (radius_x, for an ellipse)
            radius_x = attr["rx"]

            --  ry (radius_y, for an ellipse)
            radius_y = attr["ry"]
        end

        --  colors
        local f_red, f_green, f_blue, f_alpha = svglover._colorparse(attr["fill"], 0, 0, 0, 1)
        local s_red, s_green, s_blue, s_alpha = svglover._colorparse(attr["stroke"])

        --  opacity
        local opacity = attr["opacity"]
        if opacity == nil then
            opacity = 1
        else
            opacity = tonumber(opacity,10)
        end

        --  fill-opacity
        local f_opacity = attr["fill-opacity"]
        if f_opacity == nil then
            f_opacity = 1
        else
            f_opacity = tonumber(f_opacity,10)
        end

        --  stroke-opacity
        local s_opacity = attr["stroke-opacity"]
        if s_opacity == nil then
            s_opacity = 1
        else
            s_opacity = tonumber(s_opacity,10)
        end

        -- output
        local result = ""

        if f_red ~= nil then
            result = result .. "love.graphics.setColor(" .. f_red .. "," .. f_green .. "," .. f_blue .. "," .. (f_alpha * f_opacity * opacity) .. ")\n"
            result = result .. "love.graphics.ellipse(\"fill\"," .. center_x .. "," .. center_y .. "," .. radius_x .. "," .. radius_y .. ",50)\n"
        end

        if s_red ~= nil then
            result = result .. "love.graphics.setColor(" .. s_red .. "," .. s_green .. "," .. s_blue .. "," .. (s_alpha * s_opacity * opacity) .. ")\n"
            result = result .. "love.graphics.ellipse(\"line\"," .. center_x .. "," .. center_y .. "," .. radius_x .. "," .. radius_y .. ",50)\n"
        end

        if attr["transform"] ~= nil then
            result =
                "love.graphics.push()\n" ..
                svglover._parsetransform(attr["transform"], extdata) ..
                result ..
                "love.graphics.pop()\n"
        end

        return result

    -- polygon (eg. triangle)
    elseif string.match(line,'<polygon%s') then
        -- SVG example:
        --   <polygon fill="6f614e" fill-opacity="0.501961" points="191,131 119,10 35,29" />
        -- lua example:
        --   love.graphics.setColor( red, green, blue, alpha )
        --   love.graphics.polygon( mode, vertices )   -- where vertices is a list of x,y,x,y...

        -- get attributes
        local attr = svglover._getattributes(line, parent_attr)

        --  colors
        local f_red, f_green, f_blue, f_alpha = svglover._colorparse(attr["fill"], 0, 0, 0, 1)
        local s_red, s_green, s_blue, s_alpha = svglover._colorparse(attr["stroke"])

        --  opacity
        local opacity = attr["opacity"]
        if opacity == nil then
            opacity = 1
        else
            opacity = tonumber(opacity,10)
        end

        --  fill-opacity
        local f_opacity = attr["fill-opacity"]
        if f_opacity == nil then
            f_opacity = 1
        else
            f_opacity = tonumber(f_opacity,10)
        end

        --  stroke-opacity
        local s_opacity = attr["stroke-opacity"]
        if s_opacity == nil then
            s_opacity = 1
        else
            s_opacity = tonumber(s_opacity,10)
        end

        if f_red == nil and s_red == nil then
            return ""
        end

        --  stroke-width
        local linewidth = attr["stroke-width"]
        if linewidth == nil then
            linewidth = 1
        else
            linewidth = tonumber(linewidth,10)
        end

        --  points (vertices)
        local vertices = attr["points"]

        local vertices_coords = {}
        for n in string.gmatch(vertices, "%-?[^%s,%-]+") do
            table.insert(vertices_coords, tonumber(n,10))
        end
        table.insert(extdata, vertices_coords)

        -- output
        local result = ""

        result = result .. svglover._gensubpath(
            options, extdata, #extdata,
            f_red, f_green, f_blue, f_alpha, f_opacity,
            s_red, s_green, s_blue, s_alpha, s_opacity,
            opacity, linewidth, true
        )

        if attr["transform"] ~= nil then
            result =
                "love.graphics.push()\n" ..
                svglover._parsetransform(attr["transform"], extdata) ..
                result ..
                "love.graphics.pop()\n"
        end

        return result

    -- polyline (eg. triangle, but not closed)
    elseif string.match(line,'<polyline%s') then
        -- SVG example:
        --   <polyline fill="#6f614e" fill-opacity="0.501961" points="191,131 119,10 35,29" />
        -- lua example:
        --   love.graphics.setColor( red, green, blue, alpha )
        --   love.graphics.line( vertices )   -- where vertices is a list of x,y,x,y...

        -- get attributes
        local attr = svglover._getattributes(line, parent_attr)

        --  colors
        local f_red, f_green, f_blue, f_alpha = svglover._colorparse(attr["fill"], 0, 0, 0, 1)
        local s_red, s_green, s_blue, s_alpha = svglover._colorparse(attr["stroke"])

        --  opacity
        local opacity = attr["opacity"]
        if opacity == nil then
            opacity = 1
        else
            opacity = tonumber(opacity,10)
        end

        --  fill-opacity
        local f_opacity = attr["fill-opacity"]
        if f_opacity == nil then
            f_opacity = 1
        else
            f_opacity = tonumber(f_opacity,10)
        end

        --  stroke-opacity
        local s_opacity = attr["stroke-opacity"]
        if s_opacity == nil then
            s_opacity = 1
        else
            s_opacity = tonumber(s_opacity,10)
        end

        if f_red == nil and s_red == nil then
            return ""
        end

        --  stroke-width
        local linewidth = attr["stroke-width"]
        if linewidth == nil then
            linewidth = 1
        else
            linewidth = tonumber(linewidth,10)
        end

        --  points (vertices)
        local vertices = attr["points"]

        local vertices_coords = {}
        for n in string.gmatch(vertices, "%-?[^%s,%-]+") do
            table.insert(vertices_coords, tonumber(n,10))
        end
        table.insert(extdata, vertices_coords)

        -- output
        local result = ""

        result = result .. svglover._gensubpath(
            options, extdata, #extdata,
            f_red, f_green, f_blue, f_alpha, f_opacity,
            s_red, s_green, s_blue, s_alpha, s_opacity,
            opacity, linewidth, false -- < that's the only difference between <polygon> and <polyline>
        )

        if attr["transform"] ~= nil then
            result =
                "love.graphics.push()\n" ..
                svglover._parsetransform(attr["transform"], extdata) ..
                result ..
                "love.graphics.pop()\n"
        end

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
        table.remove(state.parent_attr_stack)
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

        -- get all attributes
        local attr = svglover._getattributes(line, parent_attr)

        -- get the transform
        local transform = attr["transform"]

        -- remove it from the attributes so that child nodes don't inherit it
        attr["transform"] = nil

        -- they inherit everything else
        table.insert(state.parent_attr_stack, attr)

        -- output
        local result = "love.graphics.push()\n"

        if transform ~= nil then
            result = result .. svglover._parsetransform(transform, extdata)
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
