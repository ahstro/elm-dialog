module Advanced.Villains.Penguin.View exposing (dialog, root)

import Advanced.Villains.Penguin.Types
    exposing
        ( Model
        , Msg(Close, Wark)
        , PenguinState(Hurt, Quiet, Warking)
        )
import Dialog
import Html exposing (Html, div, h1, h2, text)
import Html.Attributes exposing (class)
import Utils exposing (actionButton, debuggingView)


root : Model -> Html Msg
root model =
    div []
        [ h2 [] [ text "Penguin" ]
        , debuggingView model
        , actionButton ( Wark, "Wark!" )
        ]


dialog : Model -> Maybe (Dialog.Config Msg)
dialog model =
    case model.state of
        Quiet ->
            Nothing

        Hurt ->
            Just
                { closeMessage = Just Close
                , containerClass = Just "penguin-modal-container"
                , content =
                    div
                        []
                        [ div [ class "modal-header" ]
                            [ h1 [] [ text "Penguin says, \"Ouch!\"" ] ]
                        , div [ class "modal-body" ]
                            [ text "The penguin tries to dodge, which goes badly because penguins lack grace on land."
                            ]
                        , div [ class "modal-footer" ]
                            [ actionButton ( Close, "Take the pain" )
                            ]
                        ]
                }

        Warking ->
            Just
                { closeMessage = Just Close
                , containerClass = Just "penguin-modal-container"
                , content =
                    div
                        []
                        [ div [ class "modal-header" ]
                            [ h1 [] [ text "Penguin says, \"Wark!\"" ] ]
                        , div [ class "modal-body" ]
                            [ text "The Penguin laughs his weird laugh"
                            ]
                        , div [ class "modal-footer" ]
                            [ actionButton ( Close, "Calm down" )
                            ]
                        ]
                }
