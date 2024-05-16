module Pages.Home_ exposing (Model, Msg, page)

import Api
import Api.BikeStation
import Html.Styled exposing (Html, div, header, img, main_, p, text)
import Html.Styled.Attributes exposing (alt, css, src)
import Http
import Page exposing (Page)
import Tailwind.Breakpoints as Breakpoints
import Tailwind.Theme as Theme
import Tailwind.Utilities as Tw
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
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Ohlsson | Origo Bysykkel"
    , body =
        [ header
            [ css
                [ Tw.w_full
                , Tw.sticky
                , Tw.top_0
                , Tw.flex
                , Tw.bg_color Theme.slate_100
                , Tw.h_24
                , Tw.py_2
                , Tw.px_4
                , Tw.justify_between
                , Tw.items_center
                ]
            ]
            [ img
                [ src "/node_modules/@oslokommune/punkt-assets/dist/logos/oslologo.svg"
                , alt "Oslo Kommune"
                , css [ Tw.h_16 ]
                ]
                []
            , p [ css [ Tw.text_xl, Tw.text_end, Breakpoints.sm [ Tw.text_2xl ] ] ] [ text "Sondre N. Ohlsson" ]
            ]
        , main_ []
            [ case model.fromBackend of
                Api.Loading ->
                    text "Lastar innhald..."

                Api.Success val ->
                    div [ css [ Tw.font_sans ] ]
                        [ text <| val
                        ]

                Api.Failure err ->
                    text <|
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
        ]
    }
