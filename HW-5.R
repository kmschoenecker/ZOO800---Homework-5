##Homework 5 ----
#Nathan Lim and Kristine Schoenecker

#Load libraries
library(readxl)
library(writexl)
library(tidyverse)

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

fish_output <- fish_csv %>%
  filter(Species %in% c("Walleye", "Yellow Perch", "Smallmouth Bass")) %>%
  filter(Lake %in% c("Michigan", "Erie")) %>%
  select(-"Age_years") %>%
  mutate("Length_mm" = Length_cm * 10) %>%
  mutate("Length_group" = cut(Length_mm, breaks = c(0, 200, 400, 600, Inf)))
  
#not sure how to connect from the length group to species counts and then
#the summary data, led to us separating them out
species_counts <- fish_output %>%
  count(Species, Length_group)

#export counts as a csv
write.csv(species_counts, "Outputs/species_counts.csv", row.names=FALSE)

#summarize information

species_year_sum <- fish_output %>%
  group_by(Species, Year) %>%
  summarise("Mean_weight" = mean(Weight_g), "Median_weight" = median(Weight_g), "Sample_size" = n())

#export your new info as a csv

write.csv(species_year_sum, "Outputs/species_year_sum.csv", row.names=FALSE)

#quick plot of the fish

Fish_plot <- species_year_sum %>%
  ggplot(aes(x = Year, y = Mean_weight, col = Species)) +
  geom_line()
Fish_plot #view fish plot

ggsave("Outputs/Fish_plot.png") #save as a png to your outputs folder

##Problem 4 ----

