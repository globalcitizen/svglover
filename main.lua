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
	svglover_display(pic,100,100,100,100,true)
	svglover_display(pic,350,200,200,200,true)
	svglover_display(pic,850,50,150,300,true)
	svglover_display(pic,600,600,250,250,true)
end

function love.draw()
	-- draw any scheduled SVGs
	svglover_draw()
end
