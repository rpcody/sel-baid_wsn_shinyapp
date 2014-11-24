#### Shiny Server ####
shinyServer(function(input, output) {
  
   output$dailyAirTempPlot <- renderPlot({
    data <- scatterdata[which(scatterdata$variable %in% c("AirTC_Min", "AirTC_Avg","AirTC_Max")), ] #input$variables
    g <- ggplot(data, aes(x = day, y = value, group = variable, color = variable)) +   
      facet_grid(node ~ .) + 
      geom_point() + 
      geom_path() +
      labs(x = "", y = "Air Temperature (C)") +
      scale_x_date(labels = date_format("%b-%Y"),
                   breaks = "1 months",
                   limits = c(as.Date("2013-08-01"), as.Date("2014-04-25"))) + 
      theme_bw() + 
      scatterplot_theme
    print(g)
  })
  
  output$dailyAvgSoilTempPlot <- renderPlot({
    data <- scatterdata[which(scatterdata$variable %in% c("T_1_Avg", "T_2_Avg","T_3_Avg")), ] #input$variables
    g <- ggplot(data, aes(x = day, y = value, group = variable, color = variable)) +  
      facet_grid(node ~ .) + 
      geom_point() + 
      geom_path() +
      labs(x = "", y = "Soil Temperature (C)") +
      scale_x_date(labels = date_format("%b-%Y"),
                 breaks = "1 months",
                 limits = c(as.Date("2013-08-01"), as.Date("2014-04-25"))) + 
      theme_bw() + 
      scatterplot_theme
    print(g)
  })
  
  output$dailyVWCPlot <- renderPlot({
    data <- scatterdata[which(scatterdata$variable %in% c("VWC_1_Avg","VWC_2_Avg", "VWC_3_Avg")), ] #input$variables 
    g <- ggplot(data, aes(x = day, y = value, group = variable, color = variable)) +   
      facet_grid(node ~ .) + 
      geom_point() + 
      geom_line() +
      labs(x = "", y = expression(paste("Volumetric Water Content (", m^3/m^3, ")"))) +
      scale_x_date(labels = date_format("%b-%Y"),
                   breaks = "1 months",
                   limits = c(as.Date("2013-08-01"), as.Date("2014-04-25"))) + 
      theme_bw() + 
      scatterplot_theme
    print(g)
  })
  
  output$dailySoilECPlot <- renderPlot({
    data <- scatterdata[which(scatterdata$variable %in% c("EC_1_Avg","EC_2_Avg", "EC_3_Avg")), ] #input$variables 
    g <- ggplot(data, aes(x = day, y = value, group = variable, color = variable)) +   
      facet_grid(node ~ .) + 
      geom_point() + 
      geom_line() +
      labs(x = "", y = "Electrical Conductivity (dS/m)") +
      scale_x_date(labels = date_format("%b-%Y"),
                   breaks = "1 months",
                   limits = c(as.Date("2013-08-01"), as.Date("2014-04-25"))) + 
      theme_bw() + 
      scatterplot_theme
    print(g)
  })

  output$dailyAvgPARPlot <- renderPlot({
    data <- scatterdata[which(scatterdata$variable %in% c("PAR_Den_Avg")), ] 
    g <- ggplot(data, aes(x = day, y = value)) +   
      facet_grid(node ~ .) + 
      geom_point() + 
      geom_line() +
      labs(x = "", y = expression(paste("PAR (", mu, mol/s/m^2, ")"))) +
      scale_x_date(labels = date_format("%b-%Y"),
                   breaks = "1 months",
                   limits = c(as.Date("2013-08-01"), as.Date("2014-04-25"))) + 
      theme_bw() + 
      scatterplot_theme
    print(g)
  })   
  
  output$dailyTotalPARPlot <- renderPlot({
    data <- scatterdata[which(scatterdata$variable %in% c("PAR_Tot_Tot")), ] 
    g <- ggplot(data, aes(x = day, y = value)) +
      facet_grid(node ~ .) + 
      geom_point() + 
      geom_line() +
      labs(x = "", y = expression(paste("PAR (", mmol/m^2, ")"))) +
      scale_x_date(labels = date_format("%b-%Y"),
                   breaks = "1 months",
                   limits = c(as.Date("2013-08-01"), as.Date("2014-04-25"))) + 
      theme_bw() + 
      scatterplot_theme
    print(g)
  })   
  
  output$dailyLWPlot <- renderPlot({
    data <- scatterdata[which(scatterdata$variable %in% c("LWMDry_Tot","LWMCon_Tot", "LWMWet_Tot")), ] #input$variables 
    g <- ggplot(data, aes(x = day, y = value, group = variable, color = variable)) +   
      facet_grid(node ~ .) + 
      geom_point() + 
      geom_line() +
      labs(x = "", y = "Minutes") +
      scale_x_date(labels = date_format("%b-%Y"),
                   breaks = "1 months",
                   limits = c(as.Date("2013-08-01"), as.Date("2014-04-25"))) + 
      theme_bw() + 
      scatterplot_theme
    print(g)
  })
  
  output$dailyRainPlot <- renderPlot({
    data <- scatterdata[which(scatterdata$variable %in% c("Rain_mm_Tot")), ] #input$variables 
    g <- ggplot(data, aes(x = day, y = value)) +   
      facet_grid(node ~ .) + 
      geom_bar(stat = "identity") + 
      labs(x = "", y = "Precipitation (mm)") +
      scale_x_date(labels = date_format("%b-%Y"),
                   breaks = "1 months",
                   limits = c(as.Date("2013-08-01"), as.Date("2014-04-25"))) + 
      theme_bw() + 
      scatterplot_theme
    print(g)
  })
  
  output$animatedWindrose <- renderPlot({
   print(windroses[[input$windroseSlider]])
  })
  
})

#### Single windrose with average monthly wind speed and direction ####
# output$windrose <- renderPlot({
#   d <- monthlydata
#   d$date = as.Date(d$month, "%Y-%m-%d")
#   d$month <- as.character(format(d$date, "%m"))
#   p <- plot.windrose(d, spd = "WS_ms_Avg", dir = "WindDir_D1_WVT")
#   print(p +
#           theme_bw()  +
#           ggtitle(paste("Monthly averages, ", min(d$date), "to", max(d$date)))  +
#           xlab("Node") + ylab("Count") +
#           theme(title = element_text(size = 18, face = "bold"),
#                 axis.title.x = element_text(size=14),
#                 axis.text.x = element_text(size=8),
#                 axis.title.y = element_text(size=14),
#                 axis.text.y = element_text(size=8),
#                 legend.title = element_text(size=14),
#                 legend.text = element_text(size=13))
#   )
# })

####Facetted windrose ####
# output$facetted_windrose <- renderPlot({
#   d <- dailydata
#   d$day = as.Date(d$day, "%Y-%m-%d")
#   d$month <- as.character(format(d$day, "%m-%B"))
#   d$day = as.Date(d$day, "%Y-%m-%d")
#   p <- plot.windrose(d, spd = "WS_ms_Avg", dir = "WindDir_D1_WVT", spdres = 2, 
#                      spdmin = 0, spdmax = max(d$WS_ms_Avg)+2,
#                      dirres = 30) #, spdseq = c(0,3,6,12,15)) +
#   print(p +
#           theme_bw()  +
#           ggtitle(paste("Daily averages, ", min(d$day), "to", max(d$day)))  +
#           xlab("Node") + ylab("Count") +
#           facet_wrap(~node, nrow = 2, ncol = 2) +
#           theme(title = element_text(size = 18, face = "bold"),
#                 axis.title.x = element_text(size=14),
#                 axis.text.x = element_text(size=8),
#                 axis.title.y = element_text(size=14),
#                 axis.text.y = element_text(size=8),
#                 legend.title = element_text(size=14),
#                 legend.text = element_text(size=13),
#                 panel.border = element_blank(), 
#                 axis.ticks = element_blank(), 
#                 axis.text.y = element_blank(),
#                 legend.position = "left")
#   )
# })
