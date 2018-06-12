module Simple.App exposing (main)

{-| Fan favourite, it's the "click a button and increment a counter" demo!

When the user clicks a button, the counter will increment and a dialog
will pop up alerting them about the new value. When they click Ok, the
dialog goes away.

-}

import Dialog
import Html exposing (Html, button, div, h2, h3, text)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Utils exposing (modalStyle)


------------------------------------------------------------
-- Types
------------------------------------------------------------


type Msg
    = Increment
    | Acknowledge


type alias Model =
    { counter : Int
    , showDialog : Bool
    }



------------------------------------------------------------
-- State
------------------------------------------------------------


initialState : ( Model, Cmd Msg )
initialState =
    ( { counter = 0
      , showDialog = False
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        Increment ->
            ( { model
                | counter = model.counter + 1
                , showDialog = True
              }
            , Cmd.none
            )

        Acknowledge ->
            ( { model | showDialog = False }
            , Cmd.none
            )



------------------------------------------------------------
-- View
------------------------------------------------------------
--


{-| This is our top-level view, the one that will go straight into the
`<body>` tag. We wire in `Dialog.view` at the top level. Our model
contains the information we need to decide whether to show the dialog
or not.
-}
view : Model -> Html Msg
view model =
    div [ style [ ( "margin", "45px" ) ] ]
        [ modalStyle
        , h2 [] [ text (toString model.counter) ]
        , button
            [ class "btn btn-info"
            , onClick Increment
            ]
            [ text "Increment" ]
        , Dialog.view
            (if model.showDialog then
                Just (dialogConfig model)
             else
                Nothing
            )
        ]


{-| A `Dialog.Config` is just a few piece of optional `Html`, plus "what do we do onClose?"
-}
dialogConfig : Model -> Dialog.Config Msg
dialogConfig model =
    { closeMessage = Just Acknowledge
    , containerClass = Nothing
    , content =
        div
            []
            [ div [ class "modal-header" ]
                [ h3 [] [ text "1 Up!" ] ]
            , div [ class "modal-body" ]
                [ text ("The counter ticks up to " ++ toString model.counter ++ ".") ]
            , div [ class "modal-footer" ]
                [ button
                    [ class "btn btn-success"
                    , onClick Acknowledge
                    ]
                    [ text "OK" ]
                ]
            ]
    }



------------------------------------------------------------
-- StartApp
------------------------------------------------------------


main : Program Never Model Msg
main =
    Html.program
        { init = initialState
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
