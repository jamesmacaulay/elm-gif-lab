module Gif where

import Graphics.Collage as Collage
import Time exposing (Time)
import Array exposing (Array)

type alias Frame = List Collage.Form
type alias TimedFrame = (Frame, Time)

type alias Gif =
  { width : Int
  , height : Int
  , timedFrames : Array TimedFrame
  }

emptyFrame : Frame
emptyFrame = []

emptyTimedFrame : TimedFrame
emptyTimedFrame = (emptyFrame, 0)

frameWithDelay : Time -> Frame -> TimedFrame
frameWithDelay t f =
  (f, t)

gif : Int -> Int -> List Frame -> Gif
gif width height frames =
  let timedFrames =
        frames
          |> List.map (frameWithDelay 500)
          |> Array.fromList
  in
    Gif width height timedFrames

--
-- withFps : Float -> Gif -> Gif
-- withFps fps gif =
--   let delay = Time.second / fps
--       timedFrames' =
--         gif.timedFrames
--           |> Array.map \(f, _) ->
--   { gif | timedFrames = (gif.frames)}
