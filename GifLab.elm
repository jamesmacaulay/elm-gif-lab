module GifLab where

import Array
import Gif exposing (Gif)
import Effects exposing (Effects)
import Signal
import Html exposing (..)
import Html.Attributes exposing (..)
import Graphics.Collage as Collage

-- MODEL

type alias Model =
  { gif : Gif }

init : Gif -> (Model, Effects Action)
init gif =
  (Model gif, Effects.none)

-- UPDATE

type Action
  = NoOp

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp ->
      (model, Effects.none)

-- VIEW

viewFrameInDimensions : Int -> Int -> Gif.TimedFrame -> Html
viewFrameInDimensions width height (frame, delay) =
  div
    [ ]
    [ Html.fromElement <| Collage.collage width height frame ]

viewIndividualFrames : Model -> Html
viewIndividualFrames model =
  model.gif.timedFrames
    |> Array.map (viewFrameInDimensions model.gif.width model.gif.height)
    |> Array.toList
    |> div [ class "frames" ]

view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ ]
    [ viewIndividualFrames model
    ]
