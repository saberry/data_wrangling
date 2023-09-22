library(dplyr)
library(DBI)
library(dbplyr)
library(odbc)

odbcListDrivers()

con <- DBI::dbConnect(odbc(),
                      Driver = "ODBC Driver 17 for SQL Server",
                      Server = "mcobsql.business.nd.edu",
                      UID = "MSBAstudent",
                      PWD = "SQL%database!Mendoza",
                      Port = 3306, 
                      Database = "ChicagoCrime")

dbListFields(con, "wards")

select_q <- dbSendQuery(con, "SELECT id, block FROM crimes")

res <- dbFetch(select_q)

dbClearResult(select_q)

table_1 <- tbl(con, 
               from = dbplyr::in_schema("dbo", "crimes"))

sub_table <- table_1 %>% 
  select(id:longitude)

show_query(sub_table)

sub_df <- sub_table %>% collect()

DBI::dbDisconnect(con)
