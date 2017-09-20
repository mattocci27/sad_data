setwd("./raw_data")
library(tidyverse)
library(RSQLite)

# BCI
years <- c(1983,
           1985,
           1990,
           1995,
           2000,
           2005,
           2010)

# load data
for (i in 1:length(years)) {
  temp <- paste("~/Dropbox/BCI_TREE/50ha/bci.full", i, ".rdata", sep = "")
  load(temp)
} 

if (file.exists("bci.sqlite3")) system("rm bci.sqlite3")

db <- dbConnect(SQLite(), "bci.sqlite3", synchronous="off")

bci_full <- bci.full1 %>% 
  bind_rows(bci.full2) %>%
  bind_rows(bci.full3) %>%
  bind_rows(bci.full4) %>%
  bind_rows(bci.full5) %>%
  bind_rows(bci.full6) %>%
  bind_rows(bci.full7) 

db %>% dbWriteTable("bci_full", bci_full)


# Lambir

lambir1 <- read_delim("~/Dropbox/Lambir/52ha/Routput.txt", delim = "\t") %>%
  mutate(CensusID =1)
lambir2 <- read_delim("~/Dropbox/Lambir/52ha/Routput(2).txt", delim = "\t") %>%
  mutate(CensusID =2)
lambir3 <- read_delim("~/Dropbox/Lambir/52ha/Routput(3).txt", delim = "\t") %>%
  mutate(CensusID =3)
taxa <- read_delim("~/Dropbox/Lambir/52ha/TaxonomyDataReport.txt", delim = "\t")

lambir_full <- lambir1 %>%
  bind_rows(lambir2) %>%
  bind_rows(lambir3)

if (file.exists("lambir.sqlite3")) system("rm lambir.sqlite3")

db <- dbConnect(SQLite(), "lambir.sqlite3", synchronous="off")

db %>% dbWriteTable("lambir_full", lambir_full)
db %>% dbWriteTable("taxa", taxa)

