module Pages.Home_ exposing (Model, Msg, page)

import Api
import Api.BikeStation
import Html exposing (Html)
import Http
import Page exposing (Page)
import View exposing (View)


page : Page Model Msg
page =
    Page.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- INIT


type alias Model =
    { fromBackend : Api.Data String }


init : ( Model, Cmd Msg )
init =
    ( { fromBackend = Api.Loading }
    , Api.BikeStation.getData { onResponse = BikeDataFetched }
    )



-- UPDATE


type Msg
    = NoOp
    | Fetch
    | BikeDataFetched (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model
            , Cmd.none
            )

        Fetch ->
            ( model
            , Cmd.none
            )

        BikeDataFetched result ->
            ( case result of
                Ok data ->
                    { model | fromBackend = Api.Success data }

                Err err ->
                    { model | fromBackend = Api.Failure err }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Ohlsson | Origo Bysykkel"
    , body =
        [ case model.fromBackend of
            Api.Loading ->
                Html.text "Loading"

            Api.Success val ->
                Html.text val

            Api.Failure err ->
                Html.text <|
                    case err of
                        Http.BadUrl string ->
                            "bad url " ++ string

                        Http.Timeout ->
                            "timeout"

                        Http.NetworkError ->
                            "network error"

                        Http.BadStatus int ->
                            "bad status: " ++ String.fromInt int

                        Http.BadBody string ->
                            "bad body: " ++ string
        ]
    }
