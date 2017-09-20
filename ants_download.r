setwd("./raw_data")
library(tidyverse)
library(RSQLite)

ants_url <- "http://onlinelibrary.wiley.com/store/10.1002/ecy.1682/asset/supinfo/ecy1682-sup-0001-DataS1.zip?v=1&s=99aacbdd50b25cfff6b9e62c9ec48ccfbb168228"

if (file.exists("ants.sqlite3")) system("rm ants.sqlite3")
db <- dbConnect(SQLite(), "ants.sqlite3", synchronous="off")

# temporary directory
tmp <- tempdir()

zip_file <- file.path(tmp, "ants.zip")
zip_dir <- file.path(tmp)

download.file(ants_url, zip_file)

unzip(zip_file, exdir = zip_dir)


#list.files(tmp) %>% print

d <- read_csv(file.path(zip_dir, 
  "Gibb et al. Ecology - localities data.csv"))
db %>% dbWriteTable("ants_site", d)

d <- read_csv(file.path(zip_dir, 
  "Gibb et al. Ecology - observations data.csv"))
db %>% dbWriteTable("ants_obs", d)

d <- read_csv(file.path(zip_dir, 
  "Gibb et al. Ecology - sources data.csv"))
db %>% dbWriteTable("ants_sources", d)

data_list <- dbListTables(db)

print(paste("Created:", data_list))
