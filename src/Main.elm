module Main where

import Html
import StartApp
import Effects
import Task

import GifLab
import Gif
import Sandbox
import RainbowLambda

port blobURLs : Signal (Maybe String)

-- gif = RainbowLambda.gif
gif = Sandbox.gif

app = StartApp.start
  { init = GifLab.init gif
  , update = GifLab.update
  , view = GifLab.view
  , inputs = GifLab.inputs blobURLs }


main : Signal Html.Html
main = app.html

port tasks : Signal (Task.Task Effects.Never ())
port tasks =
  app.tasks

port renderSettings : GifLab.RenderSettings
port renderSettings = GifLab.renderSettings gif
