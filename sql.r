# test using rsqlite
con <- dbConnect(SQLite(), "forest-inventory-analysis.sqlite3", synchronous="off")

dbListTables(con)

dbGetQuery(con, "drop table cond")
dbGetQuery(con, "drop table site2")
dbGetQuery(con, "drop table site")
dbGetQuery(con, "drop table site4")
dbGetQuery(con, "drop table abund")
dbGetQuery(con, "drop table abund2")

con %>%
  dbGetQuery("SELECT * FROM site") %>% nrow

con %>%
  dbGetQuery("SELECT * FROM site2") %>% head

con %>%
  dbGetQuery("SELECT * FROM site3") %>% head

con %>%
  dbGetQuery("SELECT * FROM site4") %>% head

con %>%
  dbGetQuery("SELECT * FROM abund") %>% nrow

con %>%
  dbGetQuery("SELECT * FROM abund2") %>% nrow

con %>% 
  dbGetQuery("CREATE TABLE survey AS
              SELECT ann_inventory, cn FROM
              forest_inventory_analysis_SURVEY")

con %>% 
  # Natural stands
  # No observable treatments
  dbGetQuery("CREATE TABLE cond AS
              SELECT plt_cn FROM forest_inventory_analysis_COND
              WHERE (stdorgcd = 0 OR stdorgcd = '')  
                AND (trtcd1 = '' OR trtcd1 = 0) 
                AND (trtcd2 = '' OR trtcd2 = 0)
                AND (trtcd3 = '' OR trtcd3 = 0)
              GROUP BY plt_cn
              ")

moge <- con %>% dbGetQuery("SELECT * FROM cond")


con %>% 
  dbGetQuery("CREATE TABLE site AS
               SELECT srv_cn, cn, invyr, statecd, unitcd, countycd, plot
               FROM forest_inventory_analysis_PLOT
               WHERE plot_status_cd = 1 AND
                 samp_method_cd = 1 AND
                 manual >= 1 AND
                 qa_status = 1 AND
                 kindcd >= 1 AND kindcd <= 4 AND
                 invyr < 3000 AND 
                 (designcd = 1 OR
                  designcd = 311 OR
                  designcd = 312 OR
                  designcd = 313 OR
                  designcd = 314 OR
                  designcd = 328 OR
                  designcd = 200) 
                  ")

con %>%
  dbGetQuery("CREATE TABLE site2 as
             SELECT * FROM site 
             INNER JOIN survey on site.srv_cn = survey.cn
             ") 

con %>% 
  dbGetQuery("CREATE TABLE site3 as
              SELECT cn, statecd, unitcd, countycd ,plot, 
                MAX(invyr) AS invyr from site2
              GROUP BY statecd, unitcd, countycd, plot")

con %>%
  dbGetQuery("CREATE TABLE site4 as 
             SELECT cn, statecd, unitcd, countycd,
              plot, invyr from site3
             INNER JOIN cond on site3.cn = cond.plt_cn")

con %>%
  dbGetQuery("CREATE TABLE abund as
              SELECT plt_cn, spcd
                FROM forest_inventory_analysis_TREE
              WHERE statuscd = 1")

con %>%
  dbGetQuery("CREATE TABLE abund2 as
              SELECT statecd * 10000000000 + 
                unitcd * 100000000 + countycd * 100000 + 
                plot AS plot_id, plt_cn, spcd, 
              COUNT(spcd) AS ab
              FROM abund
              INNER JOIN site4 on abund.plt_cn = site4.cn
              GROUP BY plot_id, plt_cn, spcd")


site2 <- con %>%
  dbGetQuery("SELECT * FROM site2")

site3 <- con %>%
  dbGetQuery("SELECT * FROM site3")

abund2 <- con %>%
  dbGetQuery("SELECT * FROM abund2")

write.csv(abund2, "fia_spab.csv", row.names = FALSE)

moge <- site3 %>%
  as_data_frame %>%
  mutate(moge = paste(statecd,unitcd,countycd,plot, sep ="_"))


moge$moge %>% unique %>% length

