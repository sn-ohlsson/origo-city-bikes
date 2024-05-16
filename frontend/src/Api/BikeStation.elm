module Api.BikeStation exposing (..)

import Data.Station
import Http


getData :
    { onResponse : Result Http.Error Data.Station.StationInformation -> msg
    }
    -> Cmd msg
getData options =
    Http.get
        { url = "http://localhost:8080/origo"
        , expect = Http.expectJson options.onResponse Data.Station.stationInformationDecoder
        }
