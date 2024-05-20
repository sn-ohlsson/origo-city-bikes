module Pages.Home_ exposing (Model, Msg, page)

import Accessibility.Styled.Live as Live
import Css exposing (hover)
import Data.Station exposing (Station, StationInformation)
import Effect exposing (Effect)
import Html.Styled exposing (Attribute, Html, button, dd, div, dl, dt, h1, h2, h3, header, img, li, main_, p, span, text, ul)
import Html.Styled.Attributes exposing (alt, css, src)
import Html.Styled.Events exposing (onClick)
import Http
import Page exposing (Page)
import RemoteData exposing (WebData)
import Route exposing (Route)
import Shared
import String.Extra
import Tailwind.Breakpoints as Breakpoints
import Tailwind.Theme as Theme
import Tailwind.Utilities as Tw
import Time
import View exposing (View)


page : Shared.Model -> Route () -> Page Model Msg
page shared _ =
    Page.new
        { init = init
        , update = update
        , view = view shared
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    { stationInformation : WebData Data.Station.StationInformation }


init : () -> ( Model, Effect Msg )
init _ =
    ( { stationInformation = RemoteData.NotAsked }
    , Effect.none
    )



-- UPDATE


type Msg
    = FetchStationData


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        FetchStationData ->
            ( model
            , Effect.fetchBikeData
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Shared.Model -> Model -> View Msg
view shared _ =
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
                , Tw.shadow_md
                ]
            ]
            [ img
                [ src "/node_modules/@oslokommune/punkt-assets/dist/logos/oslologo.svg"
                , alt "Oslo Kommune"
                , css [ Tw.h_16 ]
                ]
                []
            , p [ css [ Tw.font_light, Tw.text_xl, Tw.text_end, Breakpoints.sm [ Tw.text_2xl ] ] ] [ text "Sondre N. Ohlsson" ]
            ]
        , main_
            [ css
                [ Tw.flex
                , Tw.w_full
                , Tw.px_4
                , Tw.py_8
                , Breakpoints.md [ Tw.px_24 ]
                ]
            , Live.polite
            , Live.busy (shared.stationInformation == RemoteData.Loading)
            ]
            [ case shared.stationInformation of
                RemoteData.Loading ->
                    div [ css [ Tw.flex, Tw.w_full, Tw.justify_center ] ]
                        [ img
                            [ src "/node_modules/@oslokommune/punkt-assets/dist/animations/loader.svg"
                            , css [ Tw.w_48 ]
                            ]
                            []
                        ]

                RemoteData.Success stationInformation ->
                    let
                        updateTime =
                            case shared.zone of
                                RemoteData.Success ( _, timeZone ) ->
                                    Just
                                        ( String.fromInt (Time.toHour timeZone (Time.millisToPosix stationInformation.lastUpdated))
                                        , String.fromInt (Time.toMinute timeZone (Time.millisToPosix stationInformation.lastUpdated))
                                        , String.fromInt (Time.toSecond timeZone (Time.millisToPosix stationInformation.lastUpdated))
                                        )

                                _ ->
                                    Nothing

                        time =
                            case updateTime of
                                Just ( hour, minute, second ) ->
                                    String.join ":" [ hour, minute, second ]

                                Nothing ->
                                    ""
                    in
                    div [ css [ Tw.flex, Tw.flex_col, Tw.w_full, Tw.gap_4 ] ]
                        [ div [ css [ Tw.w_full, Tw.flex, Tw.justify_between, Tw.items_end ] ]
                            [ h1 [ css [ Tw.text_3xl ] ] [ text "Stasjonar" ]
                            , button
                                [ buttonStyle
                                , onClick FetchStationData
                                ]
                                [ text "Hent ein gong til!" ]
                            , p [ css [ Tw.text_color Theme.slate_500, Tw.flex, Tw.gap_1, Tw.flex_col, Tw.items_end ] ]
                                [ span [] [ text <| "Ver. " ++ stationInformation.version ]
                                , span [] [ text <| "Sist oppdatert kl. " ++ time ]
                                ]
                            ]
                        , viewStationInformation stationInformation
                        ]

                RemoteData.Failure err ->
                    h1 [ css [ Tw.text_2xl ] ]
                        [ text <|
                            case err of
                                Http.BadUrl string ->
                                    "Det ser ikkje til at sida du prøver å nå finst: " ++ string

                                Http.Timeout ->
                                    "Dette tok for lang tid. Prøv om att!"

                                Http.NetworkError ->
                                    "Kunne ikkje kople til. Er du kopla til internett? "

                                Http.BadStatus int ->
                                    "Noko gjekk gale (bad status): " ++ String.fromInt int

                                Http.BadBody string ->
                                    "Noko gjekk gale (bad body): " ++ string
                        ]

                RemoteData.NotAsked ->
                    div [ css [ Tw.flex, Tw.w_full, Tw.justify_center ] ]
                        [ button
                            [ buttonStyle
                            , onClick FetchStationData
                            ]
                            [ text "Gje meg det eg vil ha!" ]
                        ]
            ]
        ]
    }


viewStationInformation : StationInformation -> Html msg
viewStationInformation stationInfo =
    ul [ css [ Tw.flex, Tw.flex_col, Tw.flex_wrap, Tw.gap_4, Tw.w_full ] ]
        (List.map viewStation stationInfo.data)


viewStation : Station -> Html msg
viewStation station =
    let
        stationDescription =
            station.address
                ++ ", "
                ++ String.Extra.decapitalize station.crossStreet
    in
    li [ css [ Tw.rounded, Tw.bg_color Theme.slate_100, Tw.p_4 ] ]
        [ div [ css [ Tw.flex, Tw.gap_x_2, Tw.items_baseline ] ]
            [ img [ css [ Tw.w_4 ], src "/node_modules/@oslokommune/punkt-assets/dist/icons/location-pin-filled.svg" ] []
            , h2 [ css [ Tw.text_lg ] ] [ text station.name ]
            ]
        , dl []
            [ dt [ dtStyle ] [ text "Plassering:" ]
            , dd [ dlStyle ] [ text stationDescription ]
            , dt [ dtStyle ] [ text "Kapasitet:" ]
            , dl [ dlStyle ]
                [ text <|
                    String.fromInt station.capacity
                        ++ (if station.isVirtualStation then
                                " digitale plassar"

                            else
                                " fysiske plassar"
                           )
                ]
            , dt [ dtStyle ] [ text "Ledige syklar" ]
            , dl [ dlStyle ] [ text <| String.fromInt station.numBikesAvailable ]
            , dt [ dtStyle ] [ text "Ledige plassar" ]
            , dl [ dlStyle ] [ text <| String.fromInt station.numDocksAvailable ]
            ]
        ]



-- STYLES


buttonStyle : Attribute msg
buttonStyle =
    css
        [ Tw.rounded_sm
        , Tw.px_4
        , Tw.py_2
        , Tw.bg_color Theme.slate_800
        , Tw.text_color Theme.slate_50
        , Tw.transition_colors
        , Tw.duration_75
        , Tw.ease_linear
        , hover
            [ Tw.bg_color Theme.green_300
            , Tw.text_color Theme.slate_800
            ]
        , Css.pseudoClass "focus-visible"
            [ Tw.bg_color Theme.green_300
            , Tw.text_color Theme.slate_800
            ]
        ]


dtStyle : Attribute msg
dtStyle =
    css [ Tw.font_medium ]


dlStyle : Attribute msg
dlStyle =
    css [ Tw.pl_2 ]
