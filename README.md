# [WIP] elm-gif-lab

A little sandbox for making animated GIFs with Elm!

![animated rainbow lambda](rainbow-lambda.gif?raw=true)

Uses the excellent [gif.js](https://jnordberg.github.io/gif.js/) for GIF encoding :)

## Usage

[TODO: make a more usable workflow]

1. If you haven't already, [install Elm](http://elm-lang.org/install).
2. Clone this repository.
3. In the `elm-gif-lab` directory:
  * run `elm make Main.elm --output elm.js` to build the project.
  * run `python -m SimpleHTTPServer` to serve up the files
4. Open `http://localhost:8000` in a modern browser that supports WebWorkers and the Files API.
5. After a short time, the individual frames you see should be replaced by an animated GIF that you can do whatever you like with.
6. Crack open [Sandbox.elm](blob/master/Sandbox.elm) and start messing around.
7. Rebuild the project with `elm make Main.elm --output elm.js` whenever you save the file.
8. Reload the browser to generate a new GIF!

## Tips

The job of `Sandbox.elm` is to [generate a `Gif` value](https://github.com/jamesmacaulay/elm-gif-lab/blob/7e8e00b5383f7db13a72bdec66e6a8a44d91e310/Sandbox.elm#L74-L76) that is used by [`Main.elm`](Main.elm). The `Gif` is generated with the  [`Gif.gif`](https://github.com/jamesmacaulay/elm-gif-lab/blob/40779309a8f8f5e634b6a323b0dedf56b94a1366/Gif.elm#L26) constructor function, which takes a width, a height, and a list `Gif.Frame` values as arguments, and returns a `Gif`. A `Gif.Frame` is just an alias for `List Graphics.Collage.Form`, so the third argument is really a list-of-lists-of [`Graphics.Collage.Form`](http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Graphics-Collage#Form) values.

## The big gotcha

Unfortunately, some kinds of `Graphics.Collage.Form` values supplied to the `gif` constructor will not correctly render into the final GIF. The most common examples of this are `Graphics.Element` values that have later been converted into `Form` values with `Graphics.Collage.toForm`. This restriction is due to the fact that the `gif.js` renderer is given `canvas` nodes as input, and values generated from `Graphics.Element` do not render as `canvas` nodes. If you stay away from `toForm` then you should be fine.
