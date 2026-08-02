df <- read.csv("C:\\Users\\wijks\\Documents\\Data Analyst Portfolio\\R Studio Programming\\csvs\\parks_and_rec_dataset.csv")

library(dplyr)

df %>%
  group_by(Department) %>%
  summarize(n())

df %>%
  group_by(Department) %>%
  summarize(Count = n())

df %>%
  group_by(Department) %>%
  summarize(mean(Annual_Salary))

agg_df <- df %>%
  group_by(Department) %>%
  summarize(AVG_Salary = mean(Annual_Salary),
            Count = n(),
            min(Annual_Salary),
            max(Annual_Salary),
            median(Annual_Salary))