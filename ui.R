library(shiny)
library(ggplot2)
library(tidyverse)
library(alphavantager)

av_api_key("IP3TG8GBOWDEVU2S")
args(av_get)
amazonDF <- av_get(symbol = "AMZN", av_fun = "TIME_SERIES_DAILY", interval = "daily")
appleDF <- av_get(symbol = "AAPL", av_fun = "TIME_SERIES_DAILY", interval = "daily")
alphabetDF <- av_get(symbol = "GOOGL", av_fun = "TIME_SERIES_DAILY", interval = "daily")

amazonDF$Company <- "Amazon"
appleDF$Company <- "Apple"
alphabetDF$Company <- "Alphabet"

combinedDF <- rbind(amazonDF,appleDF,alphabetDF)

fluidPage(
  
  titlePanel("Select your favourite companies"),
  
  fluidRow(
    column(width = 12,
           fluidRow(
             column(width = 12,
                    fluidRow(
                      column(width = 6, plotOutput("plot1", height = 300)),
                      column(width = 6, plotlyOutput("plot2", height = 300))
               )
               ),
             fluidRow(
             column(width = 12, sidebarPanel(
               selectInput("Company", label = "Company:",
                           choices = c("Amazon","Apple", "Alphabet"),selected = c("Amazon"), 
                           multiple = TRUE),
               sliderInput("timestamp", label = "Date to display:",
                           min(combinedDF$timestamp), max(combinedDF$timestamp), 
                           value = c(min(combinedDF$timestamp), max(combinedDF$timestamp)), 
                           step = NULL)
                    
                      )
             )
                    )
             )
           )
    )
)