library(pdftools)
library(tidyverse)
library(rvest)
library(tidytext)
library(tm)
library(rio)

pdf <- pdf_data("normas.pdf")


#definimos links de búsqueda

links <- map(pdf,~ .x %>% filter(str_detect(text,"https://boletinoficial")) %>% select(text)) %>% 
  unlist() %>% as.character() %>% 
  unique()


# hacemos loop con el xpath
xpath <- '//*[contains(concat( " ", @class, " " ), concat( " ", "panel-body", " " ))]'
text <- vector("character")



for(i in links){
  page <- read_html(i) 
  node <- html_nodes(x = page,xpath = xpath)[[2]]
  new_text <- html_text(node)
  
  text <- append(text, new_text)
  
}


#definimos stopwords add
rm(list = setdiff(ls(), "text"))


stopwords_add <- c("n", "aires", "autónoma", "as", "nros", "visto", "dela", "ello",
                   "buenos", "artículo", "decreto", "gcaba", "ciudad", "anexo", "tal", "mediante",
                   "dicha", "dicho", "deberá", "través")

splited <- strsplit(text, " ") %>% unlist() %>% as.data.frame() %>% rename(word=1) %>% 
  mutate(word = as.character(word)) %>% 
  unnest_tokens(output = "word", input = "word") %>% 
  table() %>% as.data.frame() %>% 
  rename(word = 1, freq = 2) %>% 
  arrange(desc(freq)) %>% 
  filter(!(word %in% stopwords("spanish")),
         !(str_detect(word, "1|2|3|4|5|6|7|8|9|0")),
         !(word %in% stopwords_add))




saveRDS(splited, "splited.Rds")



