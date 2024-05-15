module Api exposing (Data(..))

import Http
import Json.Decode as Decode


type Data value
    = Loading
    | Success value
    | Failure Http.Error
