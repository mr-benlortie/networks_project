rm(list = ls())

library(igraph)
library(ggraph)
library(gplots)
library(ggplot2)

load("C:/Users/blort/OneDrive/Desktop/MSBR70340/Quentin Tarantino Project/qt_edges.RData")
load("C:/Users/blort/OneDrive/Desktop/MSBR70340/Quentin Tarantino Project/qt_nodes.RData")

edges <- combos_df
nodes <- actors

nodes$if_mult <- as.factor(ifelse(nodes$Freq > 1, 1, 0))

net <- graph_from_data_frame(edges, directed = TRUE, vertices = nodes)
un_net <- graph_from_data_frame(edges, directed = FALSE, vertices = nodes)

# ggraph
suppressWarnings(ggraph(net, layout = "stress")+
  geom_edge_link(alpha = 0.1, color = "black")+
  geom_node_point(shape = 21, size = 6, aes(fill = Freq))+
  scale_fill_gradient(low = "white", high = "red3")+
  geom_node_text(aes(label = ID), size = 2, color = "black")+
  theme_graph()+
  labs(fill = "# of Appearances")+
  theme(legend.position = "bottom"))

save(net, file = "C:/Users/blort/OneDrive/Desktop/MSBR70340/Quentin Tarantino Project/net.RData")
save(un_net, file = "C:/Users/blort/OneDrive/Desktop/MSBR70340/Quentin Tarantino Project/un_net.RData")

# # network d3
# edges2 <- edges
# edges2$ID1 <- edges2$ID1 - 1
# edges2$ID2 <- edges2$ID2 - 1
# 
# nodes2 <- nodes
# nodes2$ID <- nodes2$ID - 1
# nodes2$Freq_scaled <- scale(nodes2$Freq, center = 1)
# 
# forceNetwork(Links = edges2, Nodes = nodes2, Source = "ID1", Target = "ID2", Value = "Count", NodeID = "Name",
#              Group = "Freq_scaled", Nodesize = "Freq_scaled", fontSize = 24, opacity = 0.5, zoom = TRUE)
