#load_barrow_data.R

source("sources/WindRose.R")

#### load and clean data from the four towers ####
nodeAmetadata <- read.csv("data-current/Node_A.csv", skip = 1, 
                          stringsAsFactors = FALSE)[1:3,]
headers <- names(nodeAmetadata)
units <- nodeAmetadata[1,]
stattype <- nodeAmetadata[2,]

nodeA <- read.csv("data-current/Node_A.csv", skip = 4, stringsAsFactors = FALSE,
                  na.strings = c("7999","NAN"))
nodeB <- read.csv("data-current/Node_B.csv", skip = 4, stringsAsFactors = FALSE,
                  na.strings = c("7999","NAN"))
nodeC <- read.csv("data-current/Node_C.csv", skip = 4, stringsAsFactors = FALSE,
                  na.strings = c("7999","NAN"))
nodeD <- read.csv("data-current/Node_D.csv", skip = 4, stringsAsFactors = FALSE,
                  na.strings = c("7999","NAN"))

names(nodeA) <- headers
names(nodeB) <- headers
names(nodeC) <- headers
names(nodeD) <- headers

nodeA$node <- rep("A", nrow(nodeA))
nodeB$node <- rep("B", nrow(nodeB))
nodeC$node <- rep("C", nrow(nodeC))
nodeD$node <- rep("D", nrow(nodeD))

alldata <- rbind(nodeA, nodeB, nodeC, nodeD)

alldata$TIMESTAMP <- as.POSIXct(alldata$TIMESTAMP, format = "%m/%d/%Y %H:%M")
alldata$WS_ms_TMx <- as.POSIXct(alldata$WS_ms_TMx, format = "%m/%d/%Y %H:%M")
alldata$WS_ms_TMn <- as.POSIXct(alldata$WS_ms_TMn, format = "%m/%d/%Y %H:%M")

nodes <- unique(alldata$node)

#### Aggregate the data into daily, weekly, and monthly averages ####
alldata$day <- cut(alldata$TIMESTAMP, "day")
dailymeans <- ddply(alldata, .(day, node), function(df) colwise(mean, na.rm = TRUE)(df[,3:32])) 
days <- unique(alldata$day)
all_days_nodes <- merge(days, nodes, all = TRUE)
dailymeans <- merge(dailymeans, all_days_nodes, by.x = c("day","node"), 
                    by.y = c("x","y"), all = TRUE)

alldata$week <- cut(alldata$TIMESTAMP, "week")
weeklymeans <- ddply(alldata, .(week, node), function(df) colwise(mean, na.rm = TRUE)(df[,3:32])) 
weeks <- unique(alldata$week)
all_weeks_nodes <- merge(weeks, nodes, all = TRUE)
weeklymeans <- merge(weeklymeans, all_weeks_nodes, by.x = c("week","node"), 
                     by.y = c("x","y"), all = TRUE)


alldata$month <- cut(alldata$TIMESTAMP, "month")
monthlymeans <- ddply(alldata, .(month, node), function(df) colwise(mean, na.rm = TRUE)(df[,3:32])) 
months <- unique(alldata$month)
all_months_nodes <- merge(months, nodes, all = TRUE)
monthlymeans <- merge(monthlymeans, all_months_nodes, by.x = c("month","node"), 
                     by.y = c("x","y"), all = TRUE)

#### Aggregate the precipitation data into daily, weekly, and monthly totals ####
dailyppt <- ddply(alldata, .(day, node), function(df) sum(df[,16], na.rm = TRUE))
names(dailyppt)[3] <-"Rain_mm_Tot"
dailyppt <- merge(dailyppt, all_days_nodes, by.x = c("day","node"), 
                    by.y = c("x","y"), all = TRUE)


weeklyppt <- ddply(alldata, .(week, node), function(df) sum(df[,16], na.rm = TRUE))
names(weeklyppt)[3] <-"Rain_mm_Tot"
weeklyppt <- merge(weeklyppt, all_weeks_nodes, by.x = c("week","node"), 
                     by.y = c("x","y"), all = TRUE)

monthlyppt <- ddply(alldata, .(month, node), function(df) sum(df[,16], na.rm = TRUE))
names(monthlyppt)[3] <-"Rain_mm_Tot"
monthlyppt <- merge(monthlyppt, all_months_nodes, by.x = c("month","node"), 
                      by.y = c("x","y"), all = TRUE)


dailydata <- dailymeans
dailydata$Rain_mm_Tot <- dailyppt$Rain_mm_Tot
dailydata$day = as.Date(dailydata$day, "%Y-%m-%d")
dailydata$month <- as.character(format(dailydata$day, "%B-%Y"))
months <- unique(dailydata$month)
dailydata$monthInt <- integer(nrow(dailydata))
for(i in 1:length(months)){
  dailydata$monthInt[which(dailydata$month == months[i])] <- i
}

#### Generate windroses for each month using hourly data ####
d <- dailydata
d$day = as.Date(d$day, "%Y-%m-%d")
d <- d[order(d$day), ]
d$month <- as.character(format(d$day, "%m-%B"))
d$yearmonth <- format(d$day, "%Y-%m")
d$monthyear <- format(d$day, "%B-%Y")
d$day = as.Date(d$day, "%Y-%m-%d")
windroses <- list()
for(i in 1:length(levels(factor(d$yearmonth)))){
  p <- plot.windrose(d[which(d$monthInt == i), ],  
                     spd = "WS_ms_Avg", dir = "WindDir_D1_WVT", spdres = 2, 
                     spdmin = 0, spdmax = max(d$WS_ms_Avg, na.rm = TRUE)+2,
                     dirres = 30, countmax = 20) 
  #, spdseq = c(0,3,6,12,15)) +
  pl <- print(p +
                ggtitle(paste("Daily averages,", levels(factor(d$yearmonth))[i]))  +
                xlab("") + ylab("Count") +
                facet_wrap(~node, nrow = 2, ncol = 2) +
                theme(title = element_text(size = 18, face = "bold"),
                      axis.title.x = element_text(size=16),
                      axis.text.x = element_text(size=12),
                      axis.title.y = element_text(size=16),
                      axis.text.y = element_text(size=12),
                      legend.title = element_text(size=16),
                      legend.text = element_text(size=16),
                      panel.border = element_blank(), 
                      axis.ticks = element_blank(), 
                      axis.text.y = element_blank(),
                      strip.text.x = element_text(size=16, face = "bold"),
                      strip.background = element_rect(colour="darkblue", fill="white"),
                      legend.position = "left",
                      panel.grid.major.y = element_line(size = .5, colour = "gray80"),
                      panel.grid.major.x = element_line(size = .5, colour = "gray80"),
                      panel.background = element_rect(fill = "white")))
  windroses[[i]] <- pl
}

#### Arrange data and plotting theme for scatter plots ####
scatterdata <- melt(dailydata, id.vars = c("day", "node","month","monthInt"), 
                    variable.name = "variable") 
scatterdata$day <- as.Date(scatterdata$day, format = "%Y-%m-%d")
scatterdata <- scatterdata[order(scatterdata$day), ]

scatterplot_theme <- theme(axis.title.x = element_text(size=16, color = "black"),
                           axis.text.x = element_text(size=14, color = "black", angle = 45, hjust = 1),
                           axis.title.y = element_text(size=16, color = "black"),
                           axis.text.y = element_text(size=14, color = "black"),
                           legend.title = element_text(size=16, color = "black"),
                           legend.text = element_text(size=14, color = "black"),
                           strip.text.y = element_text(size=16, face = "bold", angle = 0),
                           strip.background = element_rect(colour="darkblue", fill="white"))


