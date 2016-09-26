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
	pic = svglover_load('demo.svg')
	svglover_display(pic,100,100,100,100,true,{255,0,0,255},1)
	svglover_display(pic,350,200,200,200,true,{0,255,0,255},4)
	svglover_display(pic,850,50,150,300,true,{255,255,0,128},10)
	svglover_display(pic,600,600,250,250,true,{0,0,255,128},20)
end

function love.draw()
	-- draw any scheduled SVGs
	svglover_draw()
end
