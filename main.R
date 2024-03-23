
library("DBI")
library("ggplot2")
library("duckdb")
con <- dbConnect(duckdb::duckdb(), ":memory:")

dbExecute(con, "INSTALL spatial")
dbExecute(con, "LOAD spatial")
dbExecute(con, "CREATE TABLE bands AS SELECT * FROM ST_Read('RaR Bands.xlsx')")
bands <- dbGetQuery(con, "SELECT * FROM bands")

ggplot(bands, aes(x=main_person_age, fill=main_person_gender))  + 
  geom_histogram(alpha = 0.5) 

