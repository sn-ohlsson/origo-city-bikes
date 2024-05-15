module Style.ColorScheme exposing (..)

import Json.Decode exposing (Decoder)


type ColorScheme
    = Light
    | Dark


decode : Decoder ColorScheme
decode =
    let
        get id =
            case id of
                "Light" ->
                    Json.Decode.succeed Light

                "Dark" ->
                    Json.Decode.succeed Dark

                _ ->
                    Json.Decode.fail ("unknown value for ColorScheme: " ++ id)
    in
    Json.Decode.string |> Json.Decode.andThen get
