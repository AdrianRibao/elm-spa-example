module SPA exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Navigation exposing (..)
import UrlParser exposing (..)


main =
    Navigation.program locFor
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- ROUTING


route : Parser (Page -> a) a
route =
    oneOf
        [ UrlParser.map Home (UrlParser.s "home")
        , UrlParser.map Login (UrlParser.s "login")
        , UrlParser.map About (UrlParser.s "about")
        , UrlParser.map PostShow (UrlParser.s "post" </> int)
        ]


locFor : Location -> Msg
locFor location =
    parseHash route location
        |> GoTo



-- MODEL


type Page
    = Home
    | Login
    | About
    | PostShow Int


type alias Model =
    { currentPage : Page
    }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        page =
            case parseHash route location of
                Nothing ->
                    Home

                Just page ->
                    page
    in
        ( Model page, Cmd.none )



-- UPDATE


type Msg
    = GoTo (Maybe Page)
    | LinkTo String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GoTo maybepage ->
            case maybepage of
                Nothing ->
                    ( { model | currentPage = Home }, Cmd.none )

                Just page ->
                    ( { model | currentPage = page }, Cmd.none )

        LinkTo path ->
            ( model, newUrl path )



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
        [ button [ onClick (LinkTo "#home") ] [ text "Home" ]
        , button [ onClick (LinkTo "#login") ] [ text "Login" ]
        , button [ onClick (LinkTo "#about") ] [ text "About" ]
        , button [ onClick (LinkTo "#post/17") ] [ text "Go to post 17" ]
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

                PostShow postid ->
                    text ("Render the post with id: " ++ toString postid)
    in
        div [] [ page_content ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
