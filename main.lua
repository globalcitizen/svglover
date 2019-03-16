local svglover = require('svglover')

modes = love.window.getFullscreenModes()
table.sort(modes, function(a, b) return a.width*a.height < b.width*b.height end)
v = modes[#modes]
local resolutionPixelsX=v.width
local resolutionPixelsY=v.height
local screenModeFlags = {fullscreen=true, fullscreentype='desktop', vsync=true, msaa=0}
love.window.setMode(resolutionPixelsX, resolutionPixelsY, screenModeFlags)
resolutionPixelsX = love.graphics.getWidth()
resolutionPixelsY = love.graphics.getHeight()

function love.load()
	local pic = svglover.load('examples/forest.svg')
	svglover.display(pic,0,0,resolutionPixelsX,resolutionPixelsY)

	local pic2 = svglover.load('examples/triangle.svg')
	svglover.display(pic2,800,50,100,100,true,{255,0,0,255},1)
	svglover.display(pic2,800,200,100,600,true,{155,0,0,255},3)
	local pic3 = svglover.load('examples/rectangle.svg')
	svglover.display(pic3,1000,200,200,200,true,{0,255,0,255},4)
	local pic4 = svglover.load('examples/ellipse.svg')
	svglover.display(pic4,1250,50,150,300,true,{255,255,0,128},10)
	local pic5 = svglover.load('examples/circle.svg')
	svglover.display(pic5,1100,600,250,250,true,{0,0,255,128},20)
	local pic6 = svglover.load('examples/rotated-rectangle.svg')
	svglover.display(pic6,1520,100,300,750,true,{0,0,0,255},3)
	
	local pic7 = svglover.load('examples/path.svg')
	svglover.display(pic7,50,50,700,1000,false)
end

function love.draw()
	-- draw any scheduled SVGs
	svglover.draw()
end
