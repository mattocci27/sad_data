setwd("./raw_data")
library(tidyverse)
library(RSQLite)

# EPA 2007

epa_url <- "https://www.epa.gov/sites/production/files/2017-02/nla2007_alldata.zip"

if (file.exists("epa.sqlite3")) system("rm epa.sqlite3")
db <- dbConnect(SQLite(), "epa.sqlite3", synchronous="off")

# temporary directory
tmp <- tempdir()

zip_file <- file.path(tmp, "nla2007_alldata.zip")
zip_dir <- file.path(tmp)

download.file(epa_url, zip_file)

unzip(zip_file, exdir = zip_dir)

#list.files(tmp) %>% print

d <- read_csv(file.path(zip_dir, 
  "NLA2007_Phytoplankton_SoftAlgaeCount_20091023.csv"))
db %>% dbWriteTable("nla2007_phytoplankton_count", d)

d <- read_csv(file.path(zip_dir, 
  "NLA2007_Phytoplankton_DiatomCount_20091125.csv"))
db %>% dbWriteTable("nla2007_phytoplankton_diatom_count", d)

d <- read_csv(file.path(zip_dir, 
  "NLA2007_WaterQuality_20091123.csv"))
db %>% dbWriteTable("nla2007_water_quality", d)

d <- read_csv(file.path(zip_dir, 
  "NLA2007_Profile_20091008.csv"))
db %>% dbWriteTable("nla2007_profile", d)

d <- read_csv(file.path(zip_dir, 
  "NLA2007_Basin_Landuse_Metrics_20061022.csv"))
db %>% dbWriteTable("nla2007_basin_landuse", d)

d <- read_csv(file.path(zip_dir, 
  "NLA2007_Buffer_Landuse_Metrics_20091022.csv"))
db %>% dbWriteTable("nla2007_buffer_landuse", d)


d <- read_csv(file.path(zip_dir, 
  "NLA2007_Chemical_ConditionEstimates_20091123.csv"))
db %>% dbWriteTable("nla2007_chemical_condition", d)



d <- read_csv(file.path(zip_dir, 
  "NLA2007_SampledLakeInformation_20091113.csv"))
db %>% dbWriteTable("nla2007_lake_info", d)

#data_list <- dbListTables(db)

#print(paste("Created:", data_list))

# clean tmp files
system(paste("rm -rf ", tmp, "/$nla2007", sep = ""))


# EPA 2012
# no zip files

epa_url2012 <- "https://www.epa.gov/sites/production/files/"

d <- read_csv(file.path(epa_url2012, 
                        "2017-02/nla2012_wide_phytoplankton_count_02122014.csv"))
db %>% dbWriteTable("nla2012_phytoplankton_count", d)

d <- read_csv(file.path(epa_url2012, 
                        "2016-12/nla2012_phytotaxa_wide_10272015.csv"))
db %>% dbWriteTable("nla2012_phytoplankton_taxa", d)

d <- read_csv(file.path(epa_url2012, 
                        "2016-12/nla2012_wide_profile_08232016.csv"))
db %>% dbWriteTable("nla2012_profile", d)

d <- read_csv(file.path(epa_url2012, 
                        "2016-12/nla2012_waterchem_wide.csv"))
db %>% dbWriteTable("nla2012_chemical", d)

d <- read_csv(file.path(epa_url2012, 
                        "2016-12/nla2012_wide_siteinfo_08232016.csv"))
db %>% dbWriteTable("nla2012_siteinfo", d)

data_list <- dbListTables(db)

print(paste("Created:", data_list))

