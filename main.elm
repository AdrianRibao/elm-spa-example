module SPA exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type Page
    = Home
    | Login
    | About


type alias Model =
    { currentPage : Page
    }


init : ( Model, Cmd Msg )
init =
    ( Model Home, Cmd.none )



-- UPDATE


type Msg
    = GoHome
    | GoLogin
    | GoAbout


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GoHome ->
            ( { model | currentPage = Home }, Cmd.none )

        GoLogin ->
            ( { model | currentPage = Login }, Cmd.none )

        GoAbout ->
            ( { model | currentPage = About }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "SPA application" ]
        , render_menu model
        , render_page model
        ]


render_menu : Model -> Html Msg
render_menu model =
    div []
        [ button [ onClick GoHome ] [ text "Home" ]
        , button [ onClick GoLogin ] [ text "Login" ]
        , button [ onClick GoAbout ] [ text "About" ]
        ]


render_page : Model -> Html Msg
render_page model =
    let
        page_content =
            case model.currentPage of
                Home ->
                    text "Home"

                Login ->
                    text "Login"

                About ->
                    text "About"
    in
        div [] [ page_content ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
