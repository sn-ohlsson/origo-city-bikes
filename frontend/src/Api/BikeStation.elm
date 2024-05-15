module Api.BikeStation exposing (..)

import Http
import Json.Decode as Decode


getData :
    { onResponse : Result Http.Error String -> msg
    }
    -> Cmd msg
getData options =
    Http.get
        { url = "http://localhost:8080/origo"
        , expect = Http.expectString options.onResponse
        }
