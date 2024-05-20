module Shared exposing
    ( Flags, decoder
    , Model, Msg
    , init, update, subscriptions
    )

{-|

@docs Flags, decoder
@docs Model, Msg
@docs init, update, subscriptions

-}

import Data.Station
import Effect exposing (Effect)
import Json.Decode
import RemoteData
import Route exposing (Route)
import Shared.Model
import Shared.Msg
import Style.ColorScheme as ColorScheme exposing (ColorScheme)
import Task
import Time
import TimeZone



-- FLAGS


type alias Flags =
    { colorScheme : ColorScheme }


decoder : Json.Decode.Decoder Flags
decoder =
    Json.Decode.map Flags
        (Json.Decode.field "colorScheme" ColorScheme.decode)



-- INIT


type alias Model =
    Shared.Model.Model


init : Result Json.Decode.Error Flags -> Route () -> ( Model, Effect Msg )
init result route =
    let
        flags =
            result
                |> Result.withDefault
                    { colorScheme = ColorScheme.Light }

        tzToMsg =
            RemoteData.fromResult >> Shared.Msg.ReceiveTimeZone
    in
    ( { colorScheme = flags.colorScheme
      , stationInformation = RemoteData.NotAsked
      , zone = RemoteData.Loading
      , time = Time.millisToPosix 0
      }
    , TimeZone.getZone |> Task.attempt tzToMsg |> Effect.sendCmd
    )



-- UPDATE


type alias Msg =
    Shared.Msg.Msg


update : Route () -> Msg -> Model -> ( Model, Effect Msg )
update _ msg model =
    case msg of
        Shared.Msg.FetchBikeData ->
            ( { model | stationInformation = RemoteData.Loading }
            , Effect.sendApiRequest
                { endpoint = "origo"
                , onResponse = Shared.Msg.BikeDataFetched
                , decoder = Data.Station.stationInformationDecoder
                }
            )

        Shared.Msg.BikeDataFetched result ->
            ( case result of
                Ok data ->
                    { model | stationInformation = RemoteData.Success data }

                Err err ->
                    { model | stationInformation = RemoteData.Failure err }
            , Effect.none
            )

        Shared.Msg.Tick newTime ->
            ( { model | time = newTime }
            , Effect.none
            )

        Shared.Msg.ReceiveTimeZone response ->
            ( { model | zone = response }
            , Effect.none
            )



-- SUBSCRIPTIONS


subscriptions : Route () -> Model -> Sub Msg
subscriptions route model =
    Time.every 1000 Shared.Msg.Tick
