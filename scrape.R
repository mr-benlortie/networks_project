library(rvest)
library(dplyr)

films <- c("Reservoir_Dogs", "Pulp_Fiction", "Jackie_Brown", "Kill_Bill", "Death_Proof", 
           "Inglourious_Basterds", "Django_Unchained", "The_Hateful_Eight", "Once_Upon_a_Time_in_Hollywood")

kill_bill <- c("Kill_Bill:_Volume_1", "Kill_Bill:_Volume_2")

imdb_ratings <- c(8.3, 8.9, 7.5, 8.1, 7.0, 8.4, 8.5, 7.8, 7.6)

movie_list <- list()

for (i in 1:length(films)){
  film_name <- films[i]
  url <- glue::glue("https://en.wikipedia.org/wiki/{film_name}")
  
  if (film_name == "Pulp_Fiction") {
    cast <- character()
    for (j in 1:12){
      cast <- c(cast, read_html(url) %>%
                  html_nodes(xpath=glue::glue('//span[@id="Cast"]/following::ul[{j}]//li')) %>%
                  html_text())
    }
  } else if (film_name == "Kill_Bill") {
    cast <- character()
    for (k in 1:length(kill_bill)){
      sub_film_name <- kill_bill[k]
      sub_url <- glue::glue("https://en.wikipedia.org/wiki/{sub_film_name}")
      temp_cast <- read_html(sub_url) %>%
        html_nodes(xpath='//span[@id="Cast"]/following::ul[1]//li') %>%
        html_text()
      
      cast <- c(cast, temp_cast)
    }
  } else {
    cast <- read_html(url) %>%
      html_nodes(xpath='//span[@id="Cast"]/following::ul[1]//li') %>%
      html_text()
  }
  
  cast <- unique(gsub(" as .*", "", cast))
  cast <- cast[!grepl("Quentin Tarantino", cast)]
  
  df <- data.frame(Actor = cast, 
                   rating = imdb_ratings[i])
  
  film_name <- paste0("cast_", film_name)
  assign(film_name, df)
  
  movie_list[[i]] <- df
}

save(movie_list, file = "C:/Users/blort/OneDrive/Desktop/MSBR70340/Quentin Tarantino Project/list.RData")
