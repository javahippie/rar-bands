
library("DBI")
library("ggplot2")
con <- dbConnect(duckdb::duckdb(), ":memory:")

dbExecute(con, "INSTALL spatial")
dbExecute(con, "LOAD spatial")
dbExecute(con, "CREATE TABLE bands AS SELECT * FROM ST_Read('RaR Bands.xlsx')")
bands_male <- dbGetQuery(con, "SELECT * FROM bands where main_person_gender = 'männlich'")

bands_non_male <- dbGetQuery(con, "SELECT * FROM bands where main_person_gender <> 'männlich'")

ggplot(bands, aes(x=main_person_age))  + 
  geom_histogram(aes(y=..density..),     
                 colour="black", fill="white")
