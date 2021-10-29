library(usethis)
library(here)
library(rgdal)
library(sf)
library(tidyverse)
library(magrittr)
world_countries_map <- st_read("World_Countries_(Generalized)")
install.packages("countrycodes")
library(gitcreds)
gitcreds_set("https://github.com/leah-aaron/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")
library(janitor)
HDI <- read_csv(here("Gender Inequality Index (GII).csv"))
rm(HDI)
HDI <- read_csv(here("Gender Inequality Index (GII).csv"),locale=locale(encoding="latin1"),
                na="..",skip=5)
## locale is how the data is stored, ie latin1, na specifies in what format no data is stored, skip= 5
## for more info see https://readr.tidyverse.org/reference/read_delim.html
install.packages("remotes")
library(remotes)
install_github('vincentarelbundock/countrycode')
library(countrycode)
view(HDI)

test <- janitor::clean_names(HDI)

HDI_difference_00_05 <- test %>%
  dplyr::select(country,x2000,x2005)%>%
  mutate(difference=x2005-x2000)%>%
  slice(1:189)%>%
mutate(iso_code=countrycode(country, origin = 'country.name', destination = 'iso2c'))
view(HDI_difference_00_05)
  
## create a new dataframe with the two variables you want to compare THEN select the two columns you want to compare (2000 and 2005) THEN
## create a new column which is the difference between 2005-2000 THEN specify the number of rows you want to apply it to (in this case the whole table)
## THEN create a new column which converts the country name into a 2 character ISO country code 

#now join csv to world shapefile


Join_HDI <- world_countries_map %>%
  clean_names()%>%
  left_join(.,
            HDI_difference_00_05,
            by=c("aff_iso" = "iso_code"))

#create a new object for the joining of the spatial data to the HDI data THEN
# clean the names so they are all lower case etc. THEN
# do a 'left join' [where you merge 2 rows]
# selecting all the data (.) COMMA the new object with the differences between '00 and '05 (HDI_difference_00_05) COMMA which rows will be merged- in the world map this is AFF_ISO, in the HDI data this has been converted to iso_code

view(Join_HDI)


  
  

