module Model.PersonalDetails exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, id, href)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }


view : PersonalDetails -> Html msg
view details =
    div []
        [ h1 [id "name"] [text details.name]
        ,em [id "intro"] [text details.intro]
        , div [] (List.map viewContact details.contacts)
        , div [] (List.map viewSocial details.socials)
        ]


viewContact : DetailWithName -> Html msg
viewContact contact =
    contact |> (\c -> div [class "contact-detail"] [text c.detail])

viewSocial : DetailWithName -> Html msg
viewSocial =
     \socialLink -> a [class "social-link", href socialLink.detail] [text socialLink.name]