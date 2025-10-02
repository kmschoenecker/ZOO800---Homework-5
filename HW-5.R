##Homework 5 ----
#Nathan Lim and Kristine Schoenecker

#Load libraries
library(readxl)

##Problem 1 ----

#read in data files
fish_csv <- read.csv("fish.csv")
fish_xlsx <- read_excel("fish.xlsx")
fish_rds <- readRDS("fish.rds")

list_fish <- list(fish_csv, fish_xlsx, fish_rds) #combine into a list to use lapply

#display first with lapply
lapply(X = list_fish, FUN = head, n = 5)

##Problem 2 ----

