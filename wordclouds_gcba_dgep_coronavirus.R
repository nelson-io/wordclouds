#Activamos librerías
library(tidyverse)
library(wordcloud2)
library(ggwordcloud)


#importamos los datos


data <-  readRDS("splited.Rds")

#hacemos wordcloud

wordcloud2(data, size = .5,figPath = "t3.png", color='random-light',backgroundColor = "black")



