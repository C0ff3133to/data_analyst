df <- read.csv("C:\\Users\\wijks\\Documents\\Data Analyst Portfolio\\RStudio\\csvs\\parks_and_rec_dataset.csv")

head(df)

str(df)

summary(df)

df2 <- read.csv("C:\\Users\\wijks\\Documents\\Data Analyst Portfolio\\RStudio\\csvs\\parks_and_rec_dataset.csv", header = TRUE, sep = ",")

write.csv(df2, "C:\\Users\\wijks\\Documents\\Data Analyst Portfolio\\RStudio\\csvs\\parks_and_rec_dataset.csv", row.names = FALSE)

df3 <- read.csv("C:\\Users\\wijks\\Documents\\Data Analyst Portfolio\\RStudio\\csvs\\parks_and_rec_dataset_output.csv", header = TRUE, sep = ",")