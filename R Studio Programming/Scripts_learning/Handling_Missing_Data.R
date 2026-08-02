# Cleaning Messy Data

install.packages("tidyverse")

library(dplyr)
library(tidyr)
library(tidyverse)

df <- read.csv("C:\\Users\\wijks\\Documents\\Data Analyst Portfolio\\R Studio Programming\\csvs\\Messy_Dataset.csv", na.strings = c("","NA"))

colSums(is.na(df))

# Remove Rows when no email is present
df_cleaned <- df %>% drop_na("Email")

# Populate null Numeric Values
df_cleaned$Transaction_Amount[is.na(df_cleaned$Transaction_Amount)] <- 0


df_cleaned$Transaction_Amount[is.na(df_cleaned$Transaction_Amount)] <- mean(df_cleaned$Transaction_Amount, na.rm = TRUE)

#Populating Character Columns
df_cleaned$Customer_Name[is.na(df_cleaned$Customer_Name)] <- "Unknown"