#### Shiny Server ####
#Ryan Test Comment 2 dasffdaf
#more test

shinyServer(function(input, output) {
  
   output$dailyAirTempPlot <- renderPlot({
    data <- scatterdata[which(scatterdata$variable %in% c("AirTC_Min", "AirTC_Avg","AirTC_Max")), ] #input$variables
    g <- ggplot(data, aes(x = day, y = value, group = variable, color = variable)) +   
      facet_grid(node ~ .) + 
      geom_point() + 
      geom_path() +
      labs(x = "", y = "Air Temperature (C)") +
      scale_x_date(labels = date_format("%b-%Y"),
                   breaks = "1 months") + 
      theme_bw() + 
      scatterplot_theme
    print(g)
  })
  
  output$dailyRHPlot <- renderPlot({
    data <- scatterdata[which(scatterdata$variable %in% c("RH_Min", "RH","RH_Max")), ] #input$variables
    g <- ggplot(data, aes(x = day, y = value, group = variable, color = variable)) +   
      facet_grid(node ~ .) + 
      geom_point() + 
      geom_path() +
      labs(x = "", y = "Relative Humidity (%))") +
      scale_x_date(labels = date_format("%b-%Y"),
                   breaks = "1 months") + 
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
                 breaks = "1 months") +
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
                   breaks = "1 months") +
      scale_y_continuous(limits=c(0, 1)) +
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
                   breaks = "1 months") +
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
                   breaks = "1 months") +
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
                   breaks = "1 months") +
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
                   breaks = "1 months") +
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
                   breaks = "1 months") +
      theme_bw() + 
      scatterplot_theme
    print(g)
  })
  
  output$animatedWindrose <- renderPlot({
   print(windroses[[input$windroseSlider]])
  })
  
})

