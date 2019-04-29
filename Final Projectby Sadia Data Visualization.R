rm(list=ls(all=TRUE))

library(foreign)
library(maptools)
library(rgdal)
library(RColorBrewer)
library(ROCR)
library(randomForest)
library(ClassInt)
library(cluster)
source("mapBiPolar.r")             
source("mapColorRamp.r")           
source("mapColorQual.r") 


setwd("H:\\Master'sProject\\data\\Tornado Data")

tornado1980to1990Point.shp <- rgdal::readOGR (dsn= "H:\\Master'sProject\\data\\Tornado Data\\Tornado 1990",
                            layer = "tornado1980to1990Point")
Tonr1990to2000Points.shp <- rgdal::readOGR (dsn= "H:\\Master'sProject\\data\\Tornado Data\\Tornado 2000",
                            layer = "Tonr1990to2000Points")

torn2000to2010Points.shp <- rgdal::readOGR (dsn= "H:\\Master'sProject\\data\\Tornado Data\\Tornado 2010",
                            layer = "torn2000to2010Points")


plot(tornado1980to1990Point.shp, axes=T, bg="lightblue", border="white", col=grey(0.9), xlim=c(-20,40), ylim=c(30,70))

mapColorQual(tornado1980to1990Point.Shp$yr, tornado1980to1990Point.Shp,
             map.title="All Year in Texas",
             legend.title = "Year",legend.pos="bottomleft", legend.cex = 1, add.to.map=T)

summary(tornado1980to1990Point.shp)
summary(Tonr1990to2000Points.shp)
summary(torn2000to2010Points.shp)


# Creatinf Data Frame and Summury
tornado1980to1990Df <- as.data.frame(tornado1980to1990Point.Shp)
summary(tornado1980to1990Df)
Tonr1990to2000Df <- as.data.frame(Tonr1990to2000Points.shp)
Summary(Tonr1990to2000Df)
torn2000to2010Df <- as.data.frame(torn2000to2010Points.shp)
summary(torn2000to2010Df)

# boxlpot comapring ugly vs color
boxplot(mag~yr, data = tornado1980to1990Df, ylab="Magnitude", Main="Magnitude by Type", varwidth=T)
boxplot(mag~yr, data = Tonr1990to2000Df, ylab="Magnitude", Main="Magnitude by Type", varwidth=T)
boxplot(mag~yr, data = torn2000to2010Df, ylab="Magnitude", Main="Magnitude by Type", varwidth=T)

# creating color boxplot
library(plotly)
library(tidyverse)
# for the Period 1980 to 1990
tornado1980to1990Df$yr = as.factor(tornado1980to1990Df$yr)
plot_ly(data = tornado1980to1990Df, y = ~mag, x=~yr, color=~yr, type = "box")%>%
    layout(xaxis = list(title="Year"), yaxis  = list(title = "Magnitude of Tornado"))

#for the Period 1990 to 2000
Tonr1990to2000Df$yr = as.factor(Tonr1990to2000Df$yr)
plot_ly(data = Tonr1990to2000Df, y = ~mag, x=~yr, color=~yr, type = "box")%>%
  layout(xaxis = list(title="Year"), yaxis  = list(title = "Magnitude of Tornado"))

# for the the Period 2000 to 2010
torn2000to2010Df$yr = as.factor(torn2000to2010Df$yr)
plot_ly(data = torn2000to2010Df, y = ~mag, x=~yr, color=~yr, type = "box")%>%
  layout(xaxis = list(title="Year"), yaxis  = list(title = "Magnitude of Tornado"))
