rm(list = ls())

library(ergm)
library(intergraph)
library(sna)

load("C:/Users/blort/OneDrive/Desktop/MSBR70340/Quentin Tarantino Project/net.RData")
load("C:/Users/blort/OneDrive/Desktop/MSBR70340/Quentin Tarantino Project/un_net.RData")

# centralization
centralization.degree(un_net, mode = "all")$centralization
which.max(centralization.degree(un_net, mode = "all")$res)

centralization.closeness(un_net, mode = "all")$centralization
which.min(centralization.closeness(un_net, mode = "all")$res)

centralization.betweenness(un_net)$centralization
which.max(centralization.betweenness(un_net)$res)

centralization.evcent(un_net)$centralization
which.max(centralization.evcent(un_net)$vector)

# sna
table(which_loop(net))
table(which_multiple(net))
net_s <- simplify(net)
net_sna <- asNetwork(net_s)

# ergm
search.ergmTerms()
model1 <- ergm(net_sna ~ edges + nodecov("Freq") + nodecov("rating") +
               nodematch("if_mult") + nodefactor("if_mult"))

sum1 <- summary(model1)

coef <- sum1$coefficients[1:5]

prob <- exp(coef)/(1 + exp(coef))
prob

plogis(coef(model1)[[1]] + coef(model1)[[2]] + coef(model1)[[3]] + coef(model1)[[4]])
