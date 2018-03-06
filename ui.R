library("shiny")
library("plotly")
library("dplyr")
library("rsconnect")
FPD.file <- na.omit(read.csv("./FPD.csv", check.names=FALSE))
water.land.use <- select(FPD.file, "City Name", "Land Area (Square Miles) 2000", "Land Area (Square Miles) 2010", "Water Area (%) 2000", "Water Area (%) 2010")
city.name <- as.character(water.land.use$"City Name")
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Pie Chart for Land & Water Use in 2000 and 2010"),
  
      selectInput("city", "Choose the name of the city:", city.name,
                  selected = "Benton"),
      plotlyOutput("landwaterPlotly")
      )
)

