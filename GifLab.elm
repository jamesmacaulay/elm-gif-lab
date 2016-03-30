module GifLab where

import Array
import Time exposing (Time)
import Signal exposing (Signal)
import Effects exposing (Effects)
import Html exposing (..)
import Html.Attributes exposing (..)
import Graphics.Collage as Collage

import Gif exposing (Gif)

-- INPUTS

inputs : Signal (Maybe String) -> List (Signal Action)
inputs blobURLs =
  [ Signal.map BlobURL blobURLs ]

-- MODEL


type alias AnimationState =
  Maybe { prevClockTime : Time, elapsedTime : Time }

type alias Model =
  { gif : Gif
  , playing : Bool
  , frameOffset : Int
  , animationState : AnimationState
  , blobURL : Maybe String
  }

init : Gif -> (Model, Effects Action)
init gif =
  ( { gif = gif
    , playing = True
    , frameOffset = 0
    , animationState = Nothing
    , blobURL = Nothing
    }
  , Effects.tick Tick
  )

currentFrame : Model -> Gif.TimedFrame
currentFrame model =
  model.gif.timedFrames
    |> Array.get model.frameOffset
    |> Maybe.withDefault Gif.emptyTimedFrame

nextOffset : Model -> Int
nextOffset model =
  (model.frameOffset + 1) % (Array.length model.gif.timedFrames)

type alias RenderSettings =
  { frameDelays : List Time }

renderSettings : Gif -> RenderSettings
renderSettings gif =
  { frameDelays =
      gif.timedFrames
        |> Array.map snd
        |> Array.toList
  }
-- UPDATE

type Action
  = Tick Time
  | BlobURL (Maybe String)

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    Tick clockTime ->
      if not model.playing then
        ( { model | animationState = Nothing }, Effects.none )
      else
        let
          (_, duration) = currentFrame model
          newElapsedTime =
            case model.animationState of
              Nothing ->
                0

              Just {elapsedTime, prevClockTime} ->
                elapsedTime + (clockTime - prevClockTime)
        in
          if newElapsedTime > duration then
            ( { model
              | frameOffset = nextOffset model
              , animationState = Nothing
              }
            , Effects.tick Tick
            )
          else
            ( { model
              | animationState = Just { elapsedTime = newElapsedTime, prevClockTime = clockTime }
              }
            , Effects.tick Tick
            )
    BlobURL maybeURL ->
      ( { model | blobURL = maybeURL }, Effects.none )

-- VIEW

viewBlob : Model -> Html
viewBlob model =
  case model.blobURL of
    Nothing ->
      div [ ] [ ]
    Just url ->
      img [ src url ] [ ]

viewCurrentFrame : Model -> Html
viewCurrentFrame model =
  div
    [ ]
    [ model
        |> currentFrame
        |> viewFrameInDimensions model.gif.width model.gif.height
    ]

viewFrameInDimensions : Int -> Int -> Gif.TimedFrame -> Html
viewFrameInDimensions width height (frame, _) =
  div
    [ ]
    [ Html.fromElement <| Collage.collage width height frame ]

viewIndividualFrames : Model -> Html
viewIndividualFrames model =
  model.gif.timedFrames
    |> Array.map (viewFrameInDimensions model.gif.width model.gif.height)
    |> Array.toList
    |> div
         [ class "frames" ]

view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ ]
    [ viewBlob model
    , viewCurrentFrame model
    , viewIndividualFrames model
    ]
