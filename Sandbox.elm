module Sandbox where

import Graphics.Collage as Collage
import Color
import Gif exposing (Gif)
import Time exposing (Time)

width = 128
height = 128

frames : List (List Collage.Form)
frames = [ [ Collage.rect width height |> Collage.filled Color.red ]
         , [ Collage.rect width height |> Collage.filled Color.green ]
         , [ Collage.rect width height |> Collage.filled Color.blue ]
         ]

gif : Gif
gif =
  Gif.gif width height frames
