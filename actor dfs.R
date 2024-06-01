rm(list = ls())

load("C:/Users/blort/OneDrive/Desktop/MSBR70340/Quentin Tarantino Project/list.RData")

all_actors <- do.call(rbind, movie_list)

actor_freq <- as.data.frame(table(all_actors$Actor))

names <- unique(all_actors$Actor)

all <- aggregate(rating ~ Actor, all_actors, mean)

actors <- data.frame(actors = names, id = seq_along(names))

combos <- matrix(0, nrow = nrow(actors), ncol = nrow(actors), 
                        dimnames = list(actors$actors, actors$actors))

for (i in 1:length(movie_list)) {
  actors_in_movie <- unique(movie_list[[i]]$Actor)
  actor_combinations <- combn(actors_in_movie, 2)
  for (j in 1:ncol(actor_combinations)) {
    actor1 <- actor_combinations[1, j]
    actor2 <- actor_combinations[2, j]
    combos[actor1, actor2] <- combos[actor1, actor2] + 1
    combos[actor2, actor1] <- combos[actor2, actor1] + 1
  }
}

combos_df <- as.data.frame(as.table(combos))
names(combos_df) <- c("Actor1", "Actor2", "Count")

combos_df <- combos_df[combos_df$Count > 0, ]

combos_df <- merge(combos_df, actors, by.x = "Actor2", by.y = "actors")
combos_df <- merge(combos_df, actors, by.x = "Actor1", by.y = "actors")

names(combos_df)[4:5] <- c("ID2", "ID1")

actors <- merge(actors, actor_freq, by.x = "actors", by.y = "Var1")

names(actors)[1:2] <- c("Name", "ID")

actors <- merge(actors, all, by.x = "Name", by.y = "Actor")

save(combos_df, file = "C:/Users/blort/OneDrive/Desktop/MSBR70340/Quentin Tarantino Project/qt_edges.RData")
save(actors, file = "C:/Users/blort/OneDrive/Desktop/MSBR70340/Quentin Tarantino Project/qt_nodes.RData")
