library(shiny)
library(ggplot2)
library(tidyverse)

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