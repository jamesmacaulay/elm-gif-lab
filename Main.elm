module Main where

import Html
import StartApp
import Effects
import Task

import GifLab
import Gif
import Sandbox

port blobURLs : Signal (Maybe String)

app = StartApp.start
  { init = GifLab.init Sandbox.gif
  , update = GifLab.update
  , view = GifLab.view
  , inputs = GifLab.inputs blobURLs }


main : Signal Html.Html
main = app.html

port tasks : Signal (Task.Task Effects.Never ())
port tasks =
  app.tasks

port renderSettings : GifLab.RenderSettings
port renderSettings = GifLab.renderSettings Sandbox.gif
