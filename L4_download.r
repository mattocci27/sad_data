setwd("./raw_data")
library(tidyverse)
library(RSQLite)

# L4
L4_url <- "https://doi.pangaea.de/10.1594/PANGAEA.756537?format=zip"

if (file.exists("L4.sqlite3")) system("rm L4.sqlite3")
db <- dbConnect(SQLite(), "L4.sqlite3", synchronous="off")

# temporary directory
tmp <- tempdir()

zip_file <- file.path(tmp, "L4_alldata.zip")
zip_dir <- file.path(tmp)

download.file(L4_url, zip_file)
unzip(zip_file, exdir = zip_dir)

