#load required libraries
library(shiny)
library(scales)
library(plyr)
library(ggplot2)
library(grid)
library(reshape2)
source("sources/load_barrow_data.R")


shinyUI(navbarPage(
  
  title = "Barrow Met Data",
  tabPanel("Air Temp.", plotOutput("dailyAirTempPlot", height = "700px")),
  tabPanel("Relative Humidity", plotOutput("dailyRHPlot", height = "700px")),
  tabPanel("Soil Temp.", plotOutput("dailyAvgSoilTempPlot", height = "700px")),
  tabPanel("Soil VWC", plotOutput("dailyVWCPlot", height = "700px")),
  tabPanel("Soil EC", plotOutput("dailySoilECPlot", height = "700px")),
  tabPanel("Average PAR", plotOutput("dailyAvgPARPlot", height = "700px")),
  tabPanel("Total PAR", plotOutput("dailyTotalPARPlot", height = "700px")),
  tabPanel("Rain", plotOutput("dailyRainPlot", height = "700px")),
  tabPanel("Leaf Wetness", plotOutput("dailyLWPlot", height = "700px")),
  tabPanel("Wind", 
           plotOutput(outputId = 'animatedWindrose', width = "800px", height = "700px"),
           sidebarPanel(
             sliderInput(inputId = 'windroseSlider', label = "", 
                         min = min(dailydata$monthInt), 
                         max = max(dailydata$monthInt),
                         step = 1, value = 1, 
                         animate = animationOptions(interval = 4000, loop = TRUE))))
  ))

