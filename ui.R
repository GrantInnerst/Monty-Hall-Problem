dashboardPage(
  dashboardHeader(title = "SIAM Monty Hall Game"),
  sidebar,
  dashboardBody(
    useShinyjs(),
    useShinyalert(),
    tags$head(tags$style(HTML("div.box-header {
                                  text-align: center;
                                }"))),
    tabItems(
      
    tabItem(tabName = "game", fluidRow(
        box(includeHTML("www/info.txt"),
          title = HTML("<h3><strong>Game Background</strong></h3>"), width = "100%"
        )
      ,column(9,
         fluidRow(
           column(1, align = "left",
                  actionButton("reset_score", "Reset Score", width = "100%"),
                  br(), br(),
                  actionButton("new_game", "New Game", width = "100%"),
           ),          
           valueBoxOutput("games_played", width = 2),
           valueBoxOutput("actual_score", width = 2), 
           valueBoxOutput("total_games_played", width = 2),
           valueBoxOutput("total_win_pct", width = 2)
         ),
        fluidRow(
          doorUI("door_1", width = 4, title = "Door 1"),
          doorUI("door_2", width = 4, title = "Door 2"),
          doorUI("door_3", width = 4, title = "Door 3")
        ),
      )
    )
    ), 
    tabItem(tabName = "description", 
            box(includeHTML("www/description.txt"),
                title = HTML("<h3><strong>Strategy Description</strong></h3>"), width = "100%"
            )
            )
    )
  )
)