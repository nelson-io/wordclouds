#Activamos librerías
library(tidyverse)
library(wordcloud2)
library(tidytext)


#importamos los datos

texto <- readLines("test_text.txt")
splited <- strsplit(texto, " ") %>% unlist() %>% as.data.frame() %>% rename(word=1) %>% 
  mutate(word = as.character(word))

tokenized <- unnest_tokens(tbl = splited, output = "tokenized", input = "word" )

antijoined <- anti_join(tokenized,stop_words, by = c("tokenized" = "word"))


data_table <- table(antijoined) %>% data.frame() %>% 
  arrange(desc(Freq))


# alimentamos stopword

stop_words_c <- 
stop_words %>% bind_rows(tribble(
  ~word, ~lexicon,
  "de", "custom",
  "la","custom",
  "el","custom",
  "del","custom",
  "en","custom",
  "al","custom"
  
))

#corremos nuevamente


antijoined <- anti_join(tokenized,stop_words_c, by = c("tokenized" = "word"))


data_table <- table(antijoined) %>% data.frame() %>% 
  arrange(desc(Freq))

