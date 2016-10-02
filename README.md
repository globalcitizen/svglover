# svglover

A library to import and display simple SVGs in [LÖVE](http://love2d.org/).

Note that because it is specifically written for LÖVE, it is probably not useful for other [Lua](http://www.lua.org/) environments.

Also note that I basically only test it with the output of [primitive](https://github.com/fogleman/primitive), which generates simple SVGs automatically from bitmap/raster images. (This could be viewed as a form of compression)

The latest code can always be found at [Github](https://github.com/globalcitizen/svglover).

## News

* 2016-10-02: [v1.0.2](https://github.com/globalcitizen/svglover/releases/tag/v1.0.2) released!
  - Fix Lua logic error that was stopping fill-related scaling from working properly

* 2016-09-27: [v1.0.1](https://github.com/globalcitizen/svglover/releases/tag/v1.0.1) released!
  - Add `<circle>` support (when circles are not drawn as `<ellipse>`)
  - Slightly hardier parsing
  - Improved documentation

* 2016-09-27: [v1.0.0](https://github.com/globalcitizen/svglover/releases/tag/v1.0.0) released!
  - Basic functionality

## Status

The library is currently functional only for polygons, elipses (and circles), and rectangles. All forms of translation, rotation and scaling are supported. Groups are supported. Transparency is supported. It does not support gradient fills of any kind, `<path>` ([see issue #1](https://github.com/globalcitizen/svglover/issues/1)) or view boxes. Here is an example screenshot.

![Polygon, rectangle, circle, ellipse example](https://raw.githubusercontent.com/globalcitizen/svglover/master/screenshot-polygon.jpg)

## Why?

* SVGs are scalable, which is useful in today's era of vastly differing device screen resolutions
* SVGs are small
* Vector images look cool
* With a little more coding you can probably animate their bits

## Usage

You should normally load your SVGs straight away in the `love.load()` function to prevent duplicate reads. The syntax for doing this is as follows:

```
vector_image = svglover_load('some.svg')
```

You then specify where you want them displayed using:

```
svglover_display(vector_image,topleft_x,topleft_y,width,height,completely_fill_region,border_color,border_width)
```

... where `completely_fill_region`, `border_color` and `border_width` are optional.

Finally, you should add the `svglover_draw()` call to the end of your `love.draw()` function.

A complete example:

```
function love.load()
        vector_image = svglover_load('some.svg')
        svglover_display(vector_image,100,100,100,100,true,{255,0,0,255},1)
end

function love.draw()
        -- draw any scheduled SVGs
        svglover_draw()
end
```

## Development

Feel free to hack, fork, create issues, or send pull requests. It should be possible and not too difficult to add advanced features like text and post-draw handles for dynamic manipuplation of the resulting images to support things like transitions. However, I am personally happy with the existing functionality and will not be adding features in the near future.

## Motivation

I wanted to place SVG vector images in a roguelike game I was making, [Zomia](https://github.com/globalcitizen/zomia), but there was no pre-existing library. I first built [a proof of concept in perl, svg2love](https://github.com/globalcitizen/svg2love), but then wanted to load files direct from SVG in Lua instead of an intermediate format.

This is my first Lua library, so it probably ignores many best practices.
