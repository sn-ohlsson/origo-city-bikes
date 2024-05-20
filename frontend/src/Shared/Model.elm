module Shared.Model exposing (Model)

import Data.Station
import RemoteData exposing (RemoteData, WebData)
import Style.ColorScheme exposing (ColorScheme)
import Time
import TimeZone


{-| Normally, this value would live in "Shared.elm"
but that would lead to a circular dependency import cycle.

For that reason, both `Shared.Model` and `Shared.Msg` are in their
own file, so they can be imported by `Effect.elm`

-}
type alias Model =
    { colorScheme : ColorScheme
    , stationInformation : WebData Data.Station.StationInformation
    , zone : RemoteData TimeZone.Error ( String, Time.Zone )
    , time : Time.Posix
    }
