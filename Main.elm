module Main where

import Html
import StartApp
import GifLab
import Sandbox

app = StartApp.start
  { init = GifLab.init Sandbox.gif
  , update = GifLab.update
  , view = GifLab.view
  , inputs = [ ] }


main : Signal Html.Html
main = app.html
