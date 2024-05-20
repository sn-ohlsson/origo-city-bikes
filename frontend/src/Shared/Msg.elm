module Shared.Msg exposing (Msg(..))

import Data.Station
import Http
import RemoteData exposing (RemoteData)
import Time
import TimeZone


{-| Normally, this value would live in "Shared.elm"
but that would lead to a circular dependency import cycle.

For that reason, both `Shared.Model` and `Shared.Msg` are in their
own file, so they can be imported by `Effect.elm`

-}
type Msg
    = FetchBikeData
    | BikeDataFetched (Result Http.Error Data.Station.StationInformation)
    | Tick Time.Posix
    | ReceiveTimeZone (RemoteData TimeZone.Error ( String, Time.Zone ))
