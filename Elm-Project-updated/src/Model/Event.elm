module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, href)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval)


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"


sortByInterval : List Event -> List Event
sortByInterval events =
     List.sortWith (\e1 e2 -> Interval.compare e1.interval e2.interval) events
    --Debug.todo "Implement Event.sortByInterval"


view : Event -> Html Never
view event =
    div [classList 
           [("event", True)
          ,("event event-important", event.important)]
              ]
        [h1 [class "event-title"] [text event.title]
        ,p [class "event-description"] [ event.description]
        ,p [class "event-category"] [ categoryView event.category]
        ,case event.url of
            Just url ->
                p [class "event-url"] [a [href url] [text url]]

            Nothing ->
                text ""
        ,p [class "event-interval"][Interval.view event.interval]
        
     ]
    -- Debug.todo "Implement the Model.Event.view function"
