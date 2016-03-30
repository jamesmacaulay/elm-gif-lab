# elm-gif-lab [WIP]

A little sandbox for making animated GIFs with Elm!

![animated rainbow lambda](rainbow-lambda.gif?raw=true)

## Usage

[TODO: make a more usable workflow]

1. If you haven't already, [install Elm](http://elm-lang.org/install).
2. Clone this repository.
3. In the `elm-gif-lab` directory:
  * run `elm make Main.elm --output elm.js` to build the project.
  * run `python -m SimpleHTTPServer` to serve up the files
4. Open `http://localhost:8000` in your browser.
5. After a short time, the individual frames you see should be replaced by an animated GIF that you can do whatever you like with.
6. Crack open [Sandbox.elm](https://github.com/jamesmacaulay/elm-gif-lab/blob/master/Sandbox.elm) and start messing around.
7. Rebuild the project with `elm make Main.elm --output elm.js` whenever you save the file.
8. Reload the browser to generate a new GIF!
