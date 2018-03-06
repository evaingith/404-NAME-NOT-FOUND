library(rsconnect)
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
dataFPD <- na.omit(read.csv(file = 'FPD.csv', stringsAsFactors = FALSE))

server <- function(input, output) {

  # get the occupancy rate of 2000 and 2010 for the city that the users want to look at and plot the graph  
  output$plot <- renderPlotly({
    info = dataFPD %>% filter(City.Name == input$city)
    city.data <- data.frame(
      years = c("2000", "2010"),
      rates = c(info$Occupancy.Rate.....2000, info$Occupancy.Rate.....2010)
    )
    year <- city.data$years
    rate <- city.data$rates
    
    graph <- ggplot(data = city.data) +
      geom_point(mapping = aes(x = year, y = rate)) +
      labs(title = "Occupancy Rate in 2000 and 2010",
           x = "Year",
           y = "Occupancy Rate") 
    graph
    
  })
  
}
