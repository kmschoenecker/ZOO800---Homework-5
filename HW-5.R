##Homework 5 ----
#Nathan Lim and Kristine Schoenecker

#Load libraries
library(readxl)
library(writexl)

##Problem 1 ----

#read in data files
fish_csv <- read.csv("fish.csv")
fish_xlsx <- read_excel("fish.xlsx")
fish_rds <- readRDS("fish.rds")

list_fish <- list(fish_csv, fish_xlsx, fish_rds) #combine into a list to use lapply

#display first with lapply
lapply(X = list_fish, FUN = head, n = 5)


##Problem 2 ----

# We will use the fish_csv dataset
# Save as csv, xlsx, and rds -- make the Outputs folder first
# dir.create("./Outputs")
write.csv(fish_csv, "Outputs/second_fish.csv", row.names=FALSE)
write_xlsx(fish_csv, "Outputs/second_fish.xlsx")
saveRDS(fish_csv, "Outputs/second_fish.rds")

# Grab the file names
second_fish_filenames_list <- list.files("Outputs", full.names=TRUE)

# Check the file info to compare file sizes
lapply(X=second_fish_filenames_list, FUN=file.info)
# The csv was 12128 bytes, the xlsx was 13870 bytes, and the rds was 3033 bytes.

# It looks like csv is the best for sharing because it's not a huge file size and viewable in R or with most other platforms. For compact storage RDS is the smallest.


##Problem 3 ----
