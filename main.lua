require 'tableshow'
require 'svglover'

modes = love.window.getFullscreenModes()
table.sort(modes, function(a, b) return a.width*a.height < b.width*b.height end)
v = modes[#modes]
resolutionPixelsX=v.width
resolutionPixelsY=v.height
screenModeFlags = {fullscreen=true, fullscreentype='desktop', vsync=true, msaa=0}
love.window.setMode(resolutionPixelsX, resolutionPixelsY, screenModeFlags)
resolutionPixelsX = love.graphics.getWidth()
resolutionPixelsY = love.graphics.getHeight()

function love.load()
	pic = svglover_load('examples/forest.svg')
	svglover_display(pic,0,0,resolutionPixelsX,resolutionPixelsY)
	pic2 = svglover_load('examples/triangle.svg')
	svglover_display(pic2,100,100,100,100,true,{255,0,0,255},1)
	svglover_display(pic2,100,250,100,600,true,{155,0,0,255},3)
	pic3 = svglover_load('examples/rectangle.svg')
	svglover_display(pic3,350,200,200,200,true,{0,255,0,255},4)
	pic4 = svglover_load('examples/ellipse.svg')
	svglover_display(pic4,850,50,150,300,true,{255,255,0,128},10)
	pic5 = svglover_load('examples/circle.svg')
	svglover_display(pic5,600,600,250,250,true,{0,0,255,128},20)
	pic6 = svglover_load('examples/rotated-rectangle.svg')
	svglover_display(pic6,1120,100,300,750,true,{0,0,0,256},3)
end

function love.draw()
	-- draw any scheduled SVGs
	svglover_draw()
end
