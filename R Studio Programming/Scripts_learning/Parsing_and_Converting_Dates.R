# parsing and Converting Dates

library(dplyr)
library(lubridate)

df <- read.csv("C:\\Users\\wijks\\Documents\\Data Analyst Portfolio\\R Studio Programming\\csvs\\Messy_Dataset.csv")

df_raw <- df

df$Transaction_Date <- parse_date_time(df$Transaction_Date,
                                       orders = c("Y-m-d","m/d/Y","Y/m/d", "d-m-Y"))


df$Transaction_Date_Year <- year(df$Transaction_Date)

df$Transaction_Date_Month <- month(df$Transaction_Date)

df$Transaction_Date_Day <- day(df$Transaction_Date)
