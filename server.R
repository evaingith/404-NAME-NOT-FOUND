#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library("shiny")
library("plotly")
library("dplyr")
library("rsconnect")
library("tibble")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  FPD.file <- na.omit(read.csv("./FPD.csv", check.names=FALSE))
  water.land.use <- select(FPD.file, "City Name", "Land Area (Square Miles) 2000", "Land Area (Square Miles) 2010", "Water Area (%) 2000", "Water Area (%) 2010")
  
  output$landwaterPlotly <- renderPlotly({
    
    #pie.data <- filter(water.land.use, City.Name == input$city)
    that.city <- subset(water.land.use, water.land.use[,"City Name"] == input$city)
      #City.Name == input$city, ]
    df1 <- add_column(that.city, "Land Area (%) 2000" = 100-that.city[,4], .after = 2)
    df2 <- add_column(df1, "Water Area (Square Miles) 2000" = df1[,2]/df1[,"Land Area (%) 2000"]*100 - df1[,2], .after = 4) 
    df3 <- add_column(df2, "Land Area (%) 2010" = 100-df2[,6], .after = 4) 
    df4 <- add_column(df3, "Water Area (Square Miles) 2010" = df3[,2]/df3[,"Land Area (%) 2010"]*100 - df3[,2], .after = 7)
    flip.df <- t(df4)
    data.percent.2000 <-as.data.frame(flip.df[c(3,7),])
    data.area.2000 <-as.data.frame(flip.df[c(2,6),])
    
    data.percent.2010 <-as.data.frame(flip.df[c(5,9),])
    data.area.2010 <-as.data.frame(flip.df[c(4,8),])
    
    colors <- c('rgb(179, 119, 0)', 'rgb(102, 153, 255)')
    
    p2000 <- plot_ly(data.percent.2000, labels = rownames(data.percent.2000), values = data.percent.2000[,1], type = "pie", 
                     domain = list(x = c(0, 0.4)),
                     textposition = 'inside',
                     textinfo = 'label+percent',
                     insidetextfont = list(color = '#FFFFFF'),
                     hoverinfo = 'text',
                     text = ~paste(data.area.2000$`flip.df[c(2, 6), ]`, ' Square Miles'),
                     marker = list(colors = colors,
                          line = list(color = '#FFFFFF', width = 1)),
            showlegend = FALSE) %>% 
      
      add_trace(labels = rownames(data.percent.2010), values = data.percent.2010[,1], type = "pie", 
                     domain = list(x = c(0.6, 1)),
                     textposition = 'inside',
                     textinfo = 'label+percent',
                     insidetextfont = list(color = '#FFFFFF'),
                     hoverinfo = 'text',
                     text = ~paste(data.area.2010$`flip.df[c(4, 8), ]`, ' Square Miles'),
                     marker = list(colors = colors,
                                   line = list(color = '#FFFFFF', width = 1)),
                     showlegend = FALSE) 
   
    #subplot(p2000, p2010, nrows = 1)
})
})