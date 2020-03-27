#Activamos librerías
library(tidyverse)
library(wordcloud2)
library(ggwordcloud)
library(sf)
library(rio)


#importamos los datos


data <-  readRDS("splited.Rds")

caba <- st_read("provincia.json") %>% 
  filter(fna == "Ciudad Autónoma de Buenos Aires")


#generamos mask para wordcloud

ggplot(caba)+
  geom_sf(fill = "black")+
  theme_void()

ggsave("caba.png")





#hacemos wordcloud

wordcloud2(data, size = .5,figPath = "caba.png",
                color='random-light',backgroundColor = "black")




