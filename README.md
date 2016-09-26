# svglover

A library to import and display simple SVGs in [LÖVE](http://love2d.org/).

Note that because it is specifically written for LÖVE, it is probably not useful for other [Lua](http://www.lua.org/) environments.

The latest code can always be found at [Github](https://github.com/globalcitizen/svglover).

## Status

The library is not yet functional.

## Motivation

I wanted to place images in a roguelike game I was making, [Zomia](https://github.com/globalcitizen/zomia), but there was no pre-existing library. I first built [a proof of concept in perl, svg2love](https://github.com/globalcitizen/svg2love), but then wanted to load files direct from SVG in Lua instead of an intermediate format.

This is my first Lua library, so it probably ignores many best practices.
