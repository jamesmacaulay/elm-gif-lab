# [WIP] elm-gif-lab

A little sandbox for making animated GIFs with Elm!

![animated rainbow lambda](RainbowLambda.gif?raw=true)

Uses the excellent [gif.js](https://jnordberg.github.io/gif.js/) for GIF encoding :)

## Usage

[TODO: make a more usable workflow]

1. If you haven't already, [install Elm](http://elm-lang.org/install).
2. Clone this repository.
3. In the `elm-gif-lab` directory:
  * run `elm make src/Main.elm --output elm.js` to build the project.
  * run `python -m SimpleHTTPServer` to serve up the files
4. Open `http://localhost:8000` in a modern browser that supports WebWorkers and the Files API.
5. After a short time, the individual frames you see should be replaced by an animated GIF that you can do whatever you like with.
6. Crack open [Sandbox.elm](src/Sandbox.elm) and start messing around.
7. Rebuild the project with `elm make src/Main.elm --output elm.js` whenever you save the file.
8. Reload the browser to generate a new GIF!

## Tips

The job of [`Sandbox.elm`](src/Sandbox.elm) is to [generate a `Gif` value](https://github.com/jamesmacaulay/elm-gif-lab/blob/3aadc93a9fa29b7b335e65d89a6678157494d34b/src/Sandbox.elm#L42-L44) that is [used by `Main.elm`](https://github.com/jamesmacaulay/elm-gif-lab/blob/3aadc93a9fa29b7b335e65d89a6678157494d34b/src/Main.elm#L15-L16). The `Gif` is generated with the  [`Gif.gif`](https://github.com/jamesmacaulay/elm-gif-lab/blob/3aadc93a9fa29b7b335e65d89a6678157494d34b/src/Gif.elm#L26-L33) constructor function, which takes a width, a height, and a list `Gif.Frame` values as arguments, and returns a `Gif`.

A `Gif.Frame` is just an alias for `List Graphics.Collage.Form`, so the third argument is really a list-of-lists-of [`Graphics.Collage.Form`](http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Graphics-Collage#Form) values. Each list of `Form` values that makes up a frame eventually gets handed off to [`Graphics.Collage.collage`](http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Graphics-Collage#collage) as part of rendering, so each `Form` in a frame's list gets layered from bottom to top in the order of the list.

## The big gotcha

Unfortunately, some kinds of `Graphics.Collage.Form` values supplied to the `gif` constructor will not correctly render into the final GIF. The most common examples of this are `Graphics.Element` values that have later been converted into `Form` values with `Graphics.Collage.toForm`. This restriction is due to the fact that the `gif.js` renderer is given `canvas` nodes as input, and values generated from `Graphics.Element` do not render as `canvas` nodes. If you stay away from `toForm` then you will probably (?) be fine.

![animated rainbow rectangles footer](Sandbox.gif?raw=true)
