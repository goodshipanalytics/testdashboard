###########################################
## Data management to create Test Dashboard
###########################################

library(RCurl)
library(tidyverse)
library(lubridate)
library(ggplot2)
library(alphavantager)

av_api_key("IP3TG8GBOWDEVU2S")
args(av_get)
test_df<-av_get(symbol = "MSFT", av_fun = "TIME_SERIES_DAILY", interval = "daily")
