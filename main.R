
library("DBI")
library("ggplot2")
library("duckdb")
con <- dbConnect(duckdb::duckdb(), ":memory:")

dbExecute(con, "INSTALL spatial")
dbExecute(con, "LOAD spatial")
dbExecute(con, "CREATE TABLE bands AS SELECT * FROM ST_Read('RaR Bands.xlsx')")
bands_male <- dbGetQuery(con, "SELECT * FROM bands where main_person_gender = 'male'")

bands_non_male <- dbGetQuery(con, "SELECT * FROM bands where main_person_gender <> 'male'")

ggplot(bands_male, aes(x=main_person_age))  + 
  geom_histogram(
                 binwidth = 1,
                 colour="black", fill="green")  + 
  geom_histogram(data=bands_non_male,
                 binwidth = .75,
                 colour="black", fill="blue")
