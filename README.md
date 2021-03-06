## SAD data
This repository includes codes to automatically download and clean datasets that
 can be used for SAD analysis.

### R dependencies
tidyrverse
dbplyr
RSQLite

### Python dependencies
Some of community datasets require the
 [EcoData Retriever](https://github.com/weecology/retriever) for import.

### Usage

```sh
# clone git repo
git clone git://github.com/mattocci27/sad_data.git
cd sad_data

# Download: this will download sqlite3 files.
# WARNING: These databases are large (> 5GB) and take a long time to download
sh ./download_data.sh

# Data cleaning: this produce *_spab.csv files in ./raw_data
Rscript data_cleaning.r
```


| Dataset                           | Dataset code   | Availability | Total sites | Citation                                      |
|-----------------------------------|----------------|--------------|-------------|-----------------------------------------------|
| Breeding bird survey              | BBS            | Public       | 2,769       | Pardieck, Ziolkowski Jr & Hudson (2014)       |
| Christmas bird count              | !CBC            | Private      | 1,999      | National Audubon Society (2002)               |
| Gentry's forest transects         | Gentry         | Public       | 220         | Phillips & Miller (2002)                      |
| Forest inventory and analysis     | FIA            | Public       | 10,355      | USDA Forest Service (2010)                    |
| Mammal community database         | MCDB           | Public       | 103         | Thibault et al. (2011)                        |
| NA butterfly count                | !NABA           | Private      | 400        | North American Butterfly Assoc (2009)         |
| Actinopterygii                    | Actinopterygii | Public       | 161         | Baldridge (2013)                              |
| Reptilia                          | Reptilia       | Public       | 129         | Baldridge (2013)                              |
| Amphibia                          | Amphibia       | Public       | 43          | Baldridge (2013)                              |
| Coleoptera                        | Coleoptera     | Public       | 5           | Baldridge (2013)                              |
| Arachnida                         | Arachnida      | Public       | 25          | Baldridge (2013)                              |
| BCI Forest Dynamcis Plot          | BCI            | Request      | 1-1250 * 7  | Hubbell and Foster 1983; Condit et al. (2012) |
| Lambir Forest Dynamics Plot       | Lambir         | Request      | 1-1300 * 3  | Condit 1998; Ashotn et al. 1999               |
| Freshwater phytoplankton 2007     | EPA2007        | Public       | > 500       | U.S. Environmental Protection Agency. 2010    |
| Freshwater phytoplankton 2012     | EPA2012        | Public       | > 500       | U.S. Environmental Protection Agency. 2016    |
| Global ant abundacnes             | Ants           | Public       | > 1000      | Gibb et al. 2017                              |

| Dataset code   |Traits                | Environment                   
|----------------|------                |-----          
| BBS            |                      | PRISM Climate, Elevation
| !CBC           |                      |
| Gentry         |                      | ?
| FIA            |                      | PRISM Climate, Elevation
| MCDB           |                      |
| !NABA          |                      |
| Actinopterygii |                      |
| Reptilia       |                      |
| Amphibia       |                      |
| Coleoptera     |                      |
| Arachnida      |                      |
| BCI            | Leaf, wood and seed  | soil and topography (subplot) 
| Lambir         | Leaf                 | soil and topography (subplot) 
| EPA2007        |                      | PRISM Climate, Elevation, water chemistry 
| EPA2012        |                      | PRISM Climate, Elevatoin, water chemistry 
| Ants           |                      |

### Notes
- PRISM Climate (4km resolutioin PRISM data; PRISM Climate Group 2004)
- BCI and Lambir require permission.
- fia_spab.csv is too large to store here.
- bbs_spab.csv and fia_spab.csv only use the latest census.
- The misc data uses multiple years' data (site_id indicates site x year combination).
- Each data contains at least 10 species per site.
- Spatial scale is not considered.

### ToDo
- Add trait and env info. 
- Update Total sites in the table
- Check private data in the table
- Script for downloading metadata?
- Add Japanese FIA?
