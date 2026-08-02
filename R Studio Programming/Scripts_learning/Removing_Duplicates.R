# Removing Duplicates

library(dplyr)

df <- read.csv("C:\\Users\\wijks\\Documents\\Data Analyst Portfolio\\R Studio Programming\\csvs\\Messy_Dataset.csv")

df_no_duplicates <-  df %>%
                      distinct()

df_no_duplicates2 <-  df %>%
                        distinct(Customer_ID, .keep_all = TRUE)

df$Transaction_Date <- parse_date_time(df$Transaction_Date,
                                       orders = c("Y-m-d", "m/d/Y", "Y/m/d", "d-m-Y"))


df_no_duplicates3 <-  df %>%
                        arrange(Customer_ID, desc(Transaction_Date)) %>%
                        distinct(Customer_ID, .keep_all = TRUE)