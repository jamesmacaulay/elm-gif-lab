module RainbowLambda where

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Text
import Color exposing (..)
import Time exposing (Time)
import Gif exposing (Gif)

width = 128
height = 128
lineSmoothness = 24
speed = 1.0
fps = 12

minDimension = min width height
lambdasPerColor = lineSmoothness

lambdaForm : Float -> Color -> (Float, Float) -> Form
lambdaForm scaleFactor color pos =
  Text.fromString "𝝀"
    |> Text.color color
    |> text
    |> scale scaleFactor
    |> move pos

colors : List Color
colors =
  [purple, blue, green, yellow, orange, red]
    |> List.map (List.repeat lineSmoothness)
    |> List.concat

animatedColors : List (List Color)
animatedColors =
  let step _ colorLists =
        case colorLists of
          (head :: tail) :: _ -> (tail ++ [head]) :: colorLists
          _ -> []
  in
    List.foldr step [colors] colors
      |> List.map (\xs -> xs ++ [lightOrange])
      |> List.reverse
      |> List.indexedMap (\i x -> if i % (floor (lambdasPerColor / (1 / (speed / (fps / 4))))) == 0 then Just x else Nothing)
      |> List.filterMap identity


positions : (Float, Float) -> Float -> Float -> List (Float, Float)
positions start diffX diffY =
  let step _ xs =
        case xs of
          (x,y) :: _ -> (x + diffX, y - diffY) :: xs
          [] -> []
  in
    List.foldr step [start] colors

viewFrame : List Color -> List Form
viewFrame colors =
  let lambdaView = lambdaForm (minDimension * 0.075)
      lambdas = List.map2 lambdaView
                  colors
                  (positions
                    (minDimension * -0.155, minDimension * 0.255)
                    (minDimension * 0.045 * (1 / lambdasPerColor))
                    (minDimension * 0.0225 * (1 / lambdasPerColor)))
      background = (rect width height |> filled lightGrey)
  in
    background :: lambdas

frames : List (Gif.Frame)
frames =
  List.map viewFrame animatedColors


gif : Gif
gif =
  Gif.gif width height frames |> Gif.withFps fps
