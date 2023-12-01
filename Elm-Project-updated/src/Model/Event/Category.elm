module Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected, eventCategories, isEventCategorySelected, set, view)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (checked, class, style, type_)
import Html.Events exposing (onCheck)


type EventCategory
    = Academic
    | Work
    | Project
    | Award


eventCategories =
    [ Academic, Work, Project, Award ]


{-| Type used to represent the state of the selected event categories
-}
type SelectedEventCategories
    = SelectedEventCategories{
         academic : Bool
        ,work : Bool
        ,project : Bool
        ,award : Bool
    }


{-| Returns an instance of `SelectedEventCategories` with all categories selected

    isEventCategorySelected Academic allSelected --> True

-}
allSelected : SelectedEventCategories
allSelected =
     SelectedEventCategories{academic = True, work = True, project = True,award = True}
    -- Debug.todo "Implement Model.Event.Category.allSelected"

{-| Returns an instance of `SelectedEventCategories` with no categories selected

-- isEventCategorySelected Academic noneSelected --> False

-}
noneSelected : SelectedEventCategories
noneSelected =
     SelectedEventCategories{academic = False, work = False, project = False,award = False}
    -- Debug.todo "Implement Model.Event.Category.noneSelected"

{-| Given a the current state and a `category` it returns whether the `category` is selected.

    isEventCategorySelected Academic allSelected --> True

-}
isEventCategorySelected : EventCategory -> SelectedEventCategories -> Bool
isEventCategorySelected category current =
     getEventCategoryField category current
        
    --Debug.todo "Implement Model.Event.Category.isEventCategorySelected"

getEventCategoryField : EventCategory -> SelectedEventCategories -> Bool
getEventCategoryField category (SelectedEventCategories selectedEvent) =
    case category of
        Academic -> selectedEvent.academic
        Work -> selectedEvent.work
        Project -> selectedEvent.project
        Award -> selectedEvent.award
{-| Given an `category`, a boolean `value` and the current state, it sets the given `category` in `current` to `value`.

    allSelected |> set Academic False |> isEventCategorySelected Academic --> False

    allSelected |> set Academic False |> isEventCategorySelected Work --> True

-}
set : EventCategory -> Bool -> SelectedEventCategories -> SelectedEventCategories
set category value current =
      case category of
            Academic -> SelectedEventCategories {academic = value, work = getEventCategoryField Work current, project = getEventCategoryField Project current, award = getEventCategoryField Award current}
            Work -> SelectedEventCategories {academic = getEventCategoryField Academic current, work =  value, project = getEventCategoryField Project current, award = getEventCategoryField Award current}
            Project ->SelectedEventCategories {academic = getEventCategoryField Academic current, work = getEventCategoryField Work current, project = value, award = getEventCategoryField Award current}
            Award ->SelectedEventCategories {academic = getEventCategoryField Academic current, work = getEventCategoryField Work current, project = getEventCategoryField Project current, award =  value}
    -- Debug.todo "Implement Model.Event.Category.set"


checkbox : String -> Bool -> EventCategory -> Html ( EventCategory, Bool )
checkbox name state category =
    div [ style "display" "inline", class "category-checkbox" ]
        [ input [ type_ "checkbox", onCheck (\c -> ( category, c )), checked state ] []
        , text name
        ]


view : SelectedEventCategories -> Html ( EventCategory, Bool )
view model =
     div []
        [ div [] [ checkbox "Academic" (getEventCategoryField Academic model) Academic ]
        , div [] [ checkbox "Project" (getEventCategoryField Project model) Project ]
        , div [] [ checkbox "Work" (getEventCategoryField Work model) Work ]
        , div [] [ checkbox "Award" (getEventCategoryField Award model) Award ]
        ]
    -- Debug.todo "Implement the Model.Event.Category.view function"
