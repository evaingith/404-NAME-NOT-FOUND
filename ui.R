library(rsconnect)
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

ui <- navbarPage("whattttt",
  tabPanel("a",
    # Application title
    titlePanel("Occupancy Rate"),

    # Sidebar with slider input that allows the users to choose the city that they are interested in
    sidebarLayout(
      sidebarPanel(
        textInput(inputId = "city", label = "Choose the City")
      ),
  
      mainPanel(
        plotlyOutput("plot")
      )
    )
  )
)


