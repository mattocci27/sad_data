rm(list = ls()) # This clears everything from memory.

setwd("./raw_data")
library(tidyverse)
library(dbplyr)

# check sqlite files
file_list <- list.files() %>%
  .[grep(".sqlite3$", .)]

# site, year, sp, ab


# Gentry (forest) 
if (file.exists("gentry-forest-transects.sqlite3")) {
  db <- src_sqlite("gentry-forest-transects.sqlite3", create = TRUE)

  abund <- db %>% 
    tbl("gentry_forest_transects_counts")  %>%
    select(site = site_code,
           sp = species_id,
           ab = count) %>%
    group_by(site, sp) %>%
    summarize(ab = sum(ab)) %>%
    mutate(year = "") %>%
    ungroup()

  abund2 <- abund %>%
    group_by(site) %>%
    summarise(n = n()) %>%
    filter(n >= 10) %>%
    select(site) %>%
    inner_join(abund, by = "site") %>%
    select(site, year, sp, ab)

  write.csv(abund2, "gentry_spab.csv", row.names = FALSE)
  print("Created gentry_spab.csv")
}


# MCDB (mammal)
if (file.exists("mammal-community-db.sqlite3")) {
  db <- src_sqlite("mammal-community-db.sqlite3", create = TRUE)

  abund <- db %>%
    tbl("mammal_community_db_communities") %>%
    select(site = site_id,
           year = initial_year,
           sp = species_id,
           ab = abundance)

# at least 10 species 
  abund2 <- abund %>% 
    group_by(site) %>%
    summarise(n = n()) %>%
    filter(n >= 10) %>%
    select(site) %>%
    inner_join(abund, by = "site")

  write.csv(abund2, "mcdb_spab.csv", row.names = FALSE)
  print("Created mcdb_spab.csv")
}

# BBS (bird)
# Very intensive data from 1964 to 2016
# Use only 2016's data for now

if (file.exists("breed-bird-survey.sqlite3")) {
  db <- src_sqlite("breed-bird-survey.sqlite3", create = TRUE)

  abund <- db %>%
    tbl("breed_bird_survey_counts") %>%
    filter(year == 2016) %>% # only use 2016's data
    filter(rpid == 101) %>% # standard BBS 
    mutate(site_id = statenum * 1000 + route) %>%
    select(site_id, aou, speciestotal, year) %>%
    collect

#png("bird_data.png")
#hist(abund$year)
#dev.off()

  weather <- db %>%
    tbl("breed_bird_survey_weather") %>%
    filter(year == 2016) %>% # only use 2016's data
    filter(runtype == 1) %>% # run is acceptable by BBS standards
    filter(rpid == 101) %>% # standard BBS 
    mutate(site_id = statenum * 1000 + route) %>%
    select(site_id) %>%
    collect

# at least 10 species 
  abund2 <- abund %>% 
    group_by(site_id) %>%
    summarise(n = n()) %>%
    filter(n >= 10) %>%
    select(site_id) %>% 
    inner_join(abund, by = "site_id")

  abund3 <- inner_join(weather, abund2, by = "site_id") %>%
    select(site = site_id,
           year = year,
           sp = aou,
           ab = speciestotal)

  write.csv(abund3, "bbs_spab.csv", row.names = FALSE)
  print("Created bbs_spab.csv")
}

# FIA

if (file.exists("forest-inventory-analysis.sqlite3")) {
  db <- src_sqlite("forest-inventory-analysis.sqlite3", create = TRUE)

  survey <- db %>%
    tbl("forest_inventory_analysis_SURVEY") %>%
    filter(ann_inventory == "Y") %>% # Use annual inventory
    select(cn)

  cond <- db %>%
    tbl("forest_inventory_analysis_COND") %>%
    filter(stdorgcd == 0 | stdorgcd == '') %>%
    filter(trtcd1 == 0 | trtcd1 == '') %>%
    filter(trtcd2 == 0 | trtcd2 == '') %>%
    filter(trtcd3 == 0 | trtcd3 == '') %>%
    select(plt_cn) 

  site <- db %>%
    tbl("forest_inventory_analysis_PLOT") %>%
    filter(plot_status_cd == 1) %>% # sampled
    filter(samp_method_cd == 1) %>% # field visited (not remotely sensed)
    filter(manual >= 1) %>% # Use field guide version >= 1.0
    filter(kindcd >= 1 & kindcd <= 4) %>% # within range
    filter(invyr < 3000) %>% # within range
    filter(designcd == 1 | # National plot design (FIA) 
      designcd == 311 | # similar to 1
      designcd == 312 | # designcd 1. initial plot establishment
      designcd == 313 | # designcd 311. overlaid on previous plot. no remeasurement.
      designcd == 314 | # designcd 1. overlaid on previous plot. no remeasurement.
      designcd == 328 | # designcd 1. overlaid on 311 previous plot. remesured.
      designcd == 220  # Four 1/24 acre plots for trees >= 5 inches DBH 
      ## and 4, 1/300 acre plots for seedlings and trees >= 1 and <5 inches DBH.
      ## The 1/24 acre and 1/300 acre plots have common centers. Conditions are
      ## mapped and boundaries may be within the plots. 
      ## Remeasurement plot not described by 221-229
      ) %>%
    mutate(plot_id =  statecd * 10^10 + unitcd * 10^8 + countycd * 10^5 + plot) %>%
    select(invyr, cn, srv_cn, plot_id)

  site2 <- inner_join(site, survey, by = c("srv_cn" = "cn")) 

  site3 <- inner_join(site2, cond, by = c("cn" = "plt_cn"))

  site4 <- site3 %>%
    inner_join(site3 %>% 
               group_by(plot_id) %>%
    # only use the latest census
               summarize(invyr_max = max(invyr)), by = "plot_id") %>%
    collect() %>%
    filter(invyr == invyr_max)

  abund <- db %>%
    tbl("forest_inventory_analysis_TREE") %>%
    filter(statuscd == 1) %>% # live tree
    ## plot_id = statecd_unitcd_countycd_plot
    ## plot_id may not be displyed on your screen because it's double
    ## not using paste because it requires collect first
    #mutate(plot_id =  statecd * 10^10 + unitcd * 10^8 + countycd * 10^5 + plot) %>%
    select(plt_cn, spcd) %>% 
    collect

  abund2 <- abund %>%
    group_by(plt_cn) %>%
    summarise(n = n()) %>%
    filter(n >= 10) %>%
    select(plt_cn) %>% 
    inner_join(abund, by = "plt_cn") 

  #plt_cn ~= year
  abund3 <- inner_join(abund2, site4, c("plt_cn" = "cn")) %>%
    #filter(invyr == invyr_max) %>% # only use the latest census
    #group_by(plot_id, plt_cn, spcd) %>%
    group_by(plot_id, invyr, spcd) %>%
    summarise(ab = n()) %>%
    select(site = plot_id,
           #year = plt_cn,
           year = invyr,
           sp = spcd,
           ab = ab)

  #abund3 <- inner_join(abund2, site4, c("plt_cn" = "cn")) %>%
    #filter(invyr == invyr_max) %>% # only use the latest census

  write.csv(abund3, "fia_spab.csv", row.names = FALSE)
  print("Created fia_spab.csv")
}

# misc including:
# Reptilia 
# Arachnida 
# Colepstera
# Amphibia
# Actinopterygii
# note: sample sise of Aves and Chondichtyes are too small

if (file.exists("community-abundance-misc.sqlite3")) {
  db <- src_sqlite("community-abundance-misc.sqlite3", create = TRUE)

  abund <- db %>%
    tbl("community_abundance_misc_main") 

  site <- db %>%
    tbl("community_abundance_misc_sites") 

  abund2 <- inner_join(abund, site, by = "site_id") %>%
    collect %>%
    filter(abundance > 0) %>%
    mutate(sp = paste(genus, species, sep = "_")) %>%
    select(class, 
           site = site_id, 
           year = collection_year,
           sp, 
           ab = abundance) %>%
    filter(sp != "_sp.") # remove unkonw data 

  site <- abund2 %>%
    mutate(moge = 1) %>%
    group_by(class, site) %>%
    summarise(n = n()) %>%
    filter(n >= 10) %>% # at least 10 species per site
    select(site)

  abund3 <- inner_join(abund2, site, by = "site")

  write_csv <- function(Class = "Reptilia") {
    class <- tolower(Class)
    file_name <- paste(class, "_spab.csv", sep = "")
    abund3 %>% 
      filter(class.x == paste(Class)) %>%
      select(-class.x) %>%
      select(-class.y) %>%
      write.csv(paste(file_name), row.names = FALSE)
  }

  write_csv("Reptilia")
  write_csv("Arachnida")
  write_csv("Coleoptera")
  write_csv("Amphibia")
  write_csv("Actinopterygii")
  print("Created misc_spab files")
}

# BCI
# treeID: unique to tree individual 
# stemID: unique to measuremnt 

if (file.exists("bci.sqlite3")) {
  db <- src_sqlite("bci.sqlite3", create = TRUE)

  abund <- db %>%
    tbl("bci_full") %>%
    filter(CensusID >= 1 & CensusID <= 7) %>% # 7 censuses
    filter(status == "A") %>% # alive and lost_stem
    filter(dbh >= 10.0) %>% # dbh >= 1cm
    select(treeID, sp, CensusID, quadrat, gx, gy)


  abund2 <- abund %>%
    group_by(sp, CensusID) %>%
    summarise(ab = n()) %>%
    mutate(year = CensusID) %>%
    select(site = CensusID,
           year,
           sp,
           ab)

  write.csv(abund2, "bci_spab.csv", row.names = FALSE)
  print("Created bci_spab.csv")
}

# Lambir
if (file.exists("lambir.sqlite3")) {
  db <- src_sqlite("lambir.sqlite3", create = TRUE)

  abund <- db %>%
    tbl("lambir_full") %>%
    filter(status != "P" & status != "D") %>% # alive and lost_stem
    filter(dbh >= 1.0) %>% # dbh >= 1cm
    select(treeID, CensusID, sp, quadrat, gx, gy)

  taxa <- db %>%
    tbl("taxa") %>%
    filter(IDlevel == "species" | IDlevel == "genus") %>% # ID level
    select(sp = mnemonic)

  abund2 <- inner_join(abund, taxa, by = "sp") %>%
    group_by(sp, CensusID) %>%
    summarise(ab = n()) %>%
    mutate(year = CensusID) %>%
    select(site = CensusID,
           year,
           sp,
           ab) %>%
    inner_join(taxa, by = "sp")

  write.csv(abund2, "lambir_spab.csv", row.names = FALSE)
  print("Created lambir_spab.csv")
}


# EPA

if (file.exists("epa.sqlite3")) {
  db <- src_sqlite("epa.sqlite3", create = TRUE)
 
  abund <- db %>% 
    tbl("nla2007_phytoplankton_count") %>%
    filter(VISIT_NO == 1) %>% # Use only 1st visit; ignoring pesuedosamples
    filter(SITE_TYPE == "PROB_Lake") %>% # can be used for population estimation
    filter(SAMPLED_PHYT != "Sample lost")  %>% # remove lost data
    select(site = SITE_ID,
           #sp = OTU_TAXA,
           sp = TAXANAME,
           ab = ABUND # (cells/mL)
           ) %>%
    mutate(year = 2007) 

  abund2 <- abund %>%
    group_by(site) %>%
    summarise(n = n()) %>%
    filter(n >= 10) %>%
    select(site) %>%
    inner_join(abund, by = "site") %>%
    select(site, year, sp, ab)

  write.csv(abund2, "epa2007_spab.csv", row.names = FALSE)
  print("Created epa2007_spab.csv")
   
  abund3 <- db %>% 
    tbl("nla2012_phytoplankton_count") %>%
    filter(VISIT_NO == 1) %>% # Use only 1st visit; ignoring pesuedosamples
    select(site = SITE_ID,
           sp = TAXA_ID, # sp level
           ab = DENSITY) %>% # metadata says cells/L but it looks cells/mL
    mutate(year = 2012) 
  
  abund4 <- abund3 %>%
    group_by(site) %>%
    summarise(n = n()) %>%
    filter(n >= 10) %>%
    select(site) %>%
    inner_join(abund3, by = "site") %>%
    select(site, year, sp, ab)

  write.csv(abund4, "epa2012_spab.csv", row.names = FALSE)
  print("Created epa2012_spab.csv")
}

# Ants

if (file.exists("ants.sqlite3")) {
  db <- src_sqlite("ants.sqlite3", create = TRUE)

  abund <- db %>%
    tbl("ants_obs") %>%
    filter(Abundance > 0) %>% # containg abundance data
    collect %>%
    mutate(sp = paste(Genus, Species, sep = "_")) %>%
    select(site = `Locality ID`,
           sp,
           ab = Abundance)

  site <- db %>%
    tbl("ants_site") %>%
    # at least 10 species
    filter(`Total Ant Species Richness` >= 10) %>%
    select(site = `Locality ID`) %>%
    collect

  abund2 <- inner_join(abund, site, by = "site") %>%
    mutate(year = site) %>%
    select(site, year, sp, ab)

  write.csv(abund2, "ants_spab.csv", row.names = FALSE)
  print("Created ants_spab.csv")
  #source_ <- db %>%
  #  tbl("ants_sources")
}

