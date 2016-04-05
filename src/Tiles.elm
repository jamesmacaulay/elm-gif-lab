module Tiles where

import Graphics.Collage as Collage exposing (..)
import Color exposing (..)
import Gif exposing (Gif)

width = 256
height = 256

animateAngle : Float -> Float
animateAngle time =
  degrees (time * 60 + 30)

animateColor : Float -> Color
animateColor time =
  let
    hue =
      ((abs (time - 0.5)) * -2 + 1)
  in
    hsl hue 0.8 0.5

animate : Float -> Shape -> Form
animate time shape =
  shape
    |> outlined (solid (animateColor time))
    |> rotate (animateAngle time)

linear : Int -> List Float
linear n =
  let
    go n' =
      if n' >= toFloat n then
        []
      else
        (n' / toFloat n) :: go (n' + 1)
  in
    go 0

frames : List Gif.Frame
frames =
  linear 24
    |> List.map (\t -> [ ngon 6 20 |> animate t ])

gif : Gif
gif =
  Gif.gif width height frames |> Gif.withFps 12
