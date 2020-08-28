library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(dplyr)
library(shinyjs)
library(shinyalert)

sidebar <- dashboardSidebar(sidebarMenu(
  menuItem("Game", tabName = "game"),
  menuItem("Description", tabName = "description")
))

doorUI <- function(id, title, width) {
  ns <- NS(id)
  box(
    img(src = "door.png", height ="75%", width = "85%", id = ns("img_door")),
    hidden(img(src = "goat.jpeg", height = "100%", width = "100%", id = ns("img_donkey"))),
    hidden(img(src = "car.jpg", height = "100%", width ="100%", id = ns("img_prize"))),
    fluidRow(
      column(6, align = "right",
        actionButton(ns("choice_1"), "Choice 1")
      ),
      column(6, align = "left",
        disabled(actionButton(ns("choice_2"), "Choice 2"))
      )
    ),
    title = title, width = width
  )
}

door <- function(input, output, session, choice_number, door_id, 
                 door_choice, new_game, prize_door, open_door) {
  
  observeEvent(input$choice_1, {
    choice_number(1)
    door_choice$first <- door_id
  })
  
  observeEvent(input$choice_2, {
    choice_number(2)
    door_choice$second <- door_id
  })
  
  observe({
    if(choice_number() == 1) disable("choice_1")
    if(choice_number() == 1) enable("choice_2")
    if(door_id %in% open_door()) {
      disable("choice_2")
      hide("img_door")
      show("img_donkey")
    }
    if(choice_number() == 2) {
      disable("choice_2")
      if(door_id == prize_door()) {
        hide("img_door")
        show("img_prize")
      } else {
        hide("img_door")
        show("img_donkey")        
      }
    }
  })
  
  observeEvent(new_game(), {
    enable("choice_1")
    disable("choice_2")
    hide("img_donkey")
    hide("img_prize")
    show("img_door")
  })
}
