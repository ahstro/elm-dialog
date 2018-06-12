module Advanced.Villains.Joker.View exposing (dialog, root)

import Advanced.Villains.Joker.Types exposing (JokerState(Laughing, Screaming), Model, Msg(Close))
import Dialog
import Html exposing (Html, div, h1, h2, text)
import Html.Attributes exposing (class)
import Utils exposing (debuggingView)


root : Model -> Html Msg
root model =
    div []
        [ h2 [] [ text "Joker" ]
        , debuggingView model
        ]


dialog : Model -> Maybe (Dialog.Config Msg)
dialog model =
    case model.state of
        Laughing ->
            Nothing

        Screaming ->
            Just
                { closeMessage = Just Close
                , containerClass = Just "joker-modal-container"
                , content =
                    div
                        []
                        [ div [ class "modal-header" ]
                            [ h1 [] [ text "Joker says, \"Argh!\"" ] ]
                        , div [ class "modal-body" ]
                            [ text "The Joker is no longer smiling."
                            ]
                        ]
                }
