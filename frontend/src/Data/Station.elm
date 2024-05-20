module Data.Station exposing (..)

import Json.Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)


type alias StationInformation =
    { lastUpdated : Int
    , ttl : Int
    , version : String
    , data : List Station
    }


type alias Station =
    { stationId : String
    , name : String
    , address : String
    , crossStreet : String
    , isVirtualStation : Bool
    , capacity : Int
    , numBikesAvailable : Int
    , numDocksAvailable : Int
    }


stationInformationDecoder : Decoder StationInformation
stationInformationDecoder =
    Json.Decode.succeed StationInformation
        |> required "last_updated" Json.Decode.int
        |> required "ttl" Json.Decode.int
        |> required "version" Json.Decode.string
        |> required "data" (Json.Decode.list stationDecoder)


stationDecoder : Decoder Station
stationDecoder =
    Json.Decode.succeed Station
        |> required "station_id" Json.Decode.string
        |> required "name" Json.Decode.string
        |> required "address" Json.Decode.string
        |> required "cross_street" Json.Decode.string
        |> required "is_virtual_station" Json.Decode.bool
        |> required "capacity" Json.Decode.int
        |> required "num_bikes_available" Json.Decode.int
        |> required "num_docks_available" Json.Decode.int
