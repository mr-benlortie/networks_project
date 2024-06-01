library(rvest)
library(dplyr)

films <- c("Reservoir_Dogs", "Pulp_Fiction", "Jackie_Brown", "Kill_Bill", "Death_Proof", 
           "Inglourious_Basterds", "Django_Unchained", "The_Hateful_Eight", "Once_Upon_a_Time_in_Hollywood")

kill_bill <- c("Kill_Bill:_Volume_1", "Kill_Bill:_Volume_2")

imdb_ratings <- c(8.3, 8.9, 7.5, 8.1, 7.0, 8.4, 8.5, 7.8, 7.6)

box_office_m <- c(2.9, 213.9, 74.7, 166.55, 31.1, 321.5, 426.0, 156.5, 377.6)

budget_m <- c(2.1, 8.25, 12.0, 30.0, 30.0, 70.0, 100.0, 53.0, 93.0)

movie_data <- data.frame(row.names = films, rating = imdb_ratings, box_office_m = box_office_m, 
                         budget_m = budget_m, box_to_budget = box_office_m / budget_m)

# for (i in 1:length(films)){
#   film_name <- films[i]
#   url <- glue::glue("https://en.wikipedia.org/wiki/{film_name}")
#   
#   if (film_name == "Kill_Bill"){
#     for (j in 1:length(kill_bill)){
#       film_name <- kill_bill[j]
#       url <- glue::glue("https://en.wikipedia.org/wiki/{film_name}")
#       
#       box <- read_html(url) %>%
#         html_nodes(xpath = '//*[contains(text(),"Box office")]/following-sibling::td[1]') %>%
#         html_text() %>%
#         gsub("\\$| million|\\[\\d+\\]", "", ., perl = TRUE) %>% 
#         as.numeric()
#       
#       if(film_name == "Kill_Bill:_Volume_1"){
#         temp_box <- box
#       } else {
#         box <- mean(c(temp_box, box))
#         film_name <- "Kill_Bill"
#       }
#     }
#   } else {
#     box <- read_html(url) %>%
#       html_nodes(xpath = '//*[contains(text(),"Box office")]/following-sibling::td[1]') %>%
#       html_text() %>%
#       gsub("\\$| million|\\[\\d+\\]", "", ., perl = TRUE) %>% 
#       as.numeric()
#   }
#   movie_data[i, 2] <- box
# }