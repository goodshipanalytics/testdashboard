library(shiny)
library(ggplot2)
library(tidyverse)
library(plotly)

av_api_key("IP3TG8GBOWDEVU2S")
args(av_get)
amazonDF <- av_get(symbol = "AMZN", av_fun = "TIME_SERIES_DAILY", interval = "daily")
appleDF <- av_get(symbol = "AAPL", av_fun = "TIME_SERIES_DAILY", interval = "daily")
alphabetDF <- av_get(symbol = "GOOGL", av_fun = "TIME_SERIES_DAILY", interval = "daily")

amazonDF$Company <- "Amazon"
appleDF$Company <- "Apple"
alphabetDF$Company <- "Alphabet"

combinedDF <- rbind(amazonDF,appleDF,alphabetDF)

function(input, output) {
  
  dataset <- reactive({
    combinedDF %>%
      filter(Company == input[['Company']]) %>%
      filter(between(timestamp, as.Date(input$timestamp[1]),        
      as.Date(input$timestamp[2])))
  })
  
  output$plot1 <- renderPlot({
    ggplot(dataset(), aes(x = timestamp, y = open, colour = Company)) +
    geom_line() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    theme_bw() +
    xlab("Date") + ylab("Opening value") +
    theme(text = element_text(size=15))
  })
  
  output$plot2 <- renderPlotly({
    plot_ly(dataset(), x = ~timestamp, y = ~open, color = ~Company, 
    type =   'scatter', mode = 'lines') %>%
    layout(xaxis = list(title = 'Date', showline = TRUE, zeroline = TRUE), 
    yaxis = list(title = 'Opening value', showline = TRUE, zeroline = TRUE))
  })
  
}