#snippets_for_later.R

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
