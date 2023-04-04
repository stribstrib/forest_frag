# Test script to pull in spatial data in R within personal RStudio OR cyverse



# load spatial packages
library(tidyverse)
library(terra)
library(tidyterra)
library(sf)
library(sp)
library(ggplot2)

##### IMPORT DATA #####

# path to shared folder on cyverse
cyverse.path <- "/iplant/home/mgracemcleod/Forest_Fragments/Data/"
mgm.path <- "/Users/gracemcleod/Documents/ForestEdges/" #from Grace's original Code
oss.path <- "R:/ecohydrology/staff/Stribling/projects/forest_frag_wg/forest_frag/"


# EACH USER SET PATH 
# change as user changes
fp <- oss.path


# load data

cali <- vect(str_c(fp, "US_States.shp"))
trin_cty <- vect(str_c(fp, "Trinity_County.shp"))
cali_counties <- vect(str_c(fp, "US_Counties.shp"))
trin_wsheds <- vect(str_c(fp, "Trinity_Watersheds.shp"))
timb_harv <- vect(str_c(fp, "CAL_FIRE_Timber_Harvesting_Plans_All_TA83.kml"))
cal_gages <- vect(str_c(fp, "cal_gages_acae.shp"))
lu_change <- rast(str_c(fp, "nlcd_2001_2019_change_index_l48_20210604/nlcd_2001_2019_change_index_l48_20210604.img"))
nlcd_2019 <- rast(str_c(fp, "nlcd_2019_land_cover_l48_20210604/nlcd_2019_land_cover_l48_20210604.img"))
#could not get ecostress files or Area.shp to plot


#Explore data
plot(nlcd_2019)
crs(nlcd_2019)
# this raster is in Albers Conical Equal Area; 
# I have heard it is better to reproject vectors rather than rasters, so all relevant vectors will be reprojected to this crs.

plot(trin_cty)
crs(trin_cty)
trin_cty_acea <- project(trin_cty, nlcd_2019)

plot(trin_cty_acea)
plot(nlcd_2019, add=T)
plot(trin_cty_acea, add = T, border = "darkred")

#crop to size
nlcd_2019_trin <- crop(nlcd_2019, trin_cty_acea, mask = T)

writeRaster(nlcd_2019_trin, str_c(fp, "trin_county_NLCD_2019.tif"))
trin_NLCD <- rast(str_c(fp, "trin_county_NLCD_2019.tif"))
plot(trin_NLCD)

plot(cali)
crs(cali)
cali_acea <- project(cali, trin_NLCD)

plot(cali_counties)
crs(cali_counties)
cali_counties_acea <- project(cali_counties, trin_NLCD)


plot(trin_cty, col = "darkred")
crs(trin_cty)
trin_cty_acea = project(trin_cty, trin_NLCD)

plot(trin_wsheds, add = T, col = "lightblue")
crs(trin_wsheds)
trin_wsheds_acea <- project(trin_wsheds, trin_NLCD)

plot(cal_gages, col = "blue")
crs(cal_gages) #ACEA crs


plot(timb_harv)
crs(timb_harv)
timb_harv_acea <- project(timb_harv, trin_NLCD)



plot(trin_cty_acea)
plot(trin_NLCD, add = T)
plot(cali_counties_acea, add=T, border = "darkgrey")
plot(trin_cty_acea, add = T, border = "darkred")
plot(trin_wsheds_acea, add = T, alpha = 1, border = "darkblue")
plot(timb_harv_acea, add=T)
plot(gages_acea, add = T, col = "red")



#plot with ggplot
ggplot(data = st_as_sf(trin_cty_acea)) +
  geom_sf(color = "darkred")+
  geom_sf(data = trin_NLCD)#+
  coord_sf(xlim = c(-123.6, -122.), ylim = c(39.9, 41.4))

# Clip gages to  


