# Test script to pull in spatial data in R within personal RStudio OR cyverse



# load spatial packages
library(tidyverse)
library(terra)
# library(tidyterra)
# library(sf)
# library(sp)
# library(ggplot2)

##### IMPORT DATA #####

# path to shared folder on cyverse
cyverse.path <- "/iplant/home/mgracemcleod/Forest_Fragments/Data/"
mgm.path <- "/Users/gracemcleod/Documents/ForestEdges/" #from Grace's original Code
oss.path <- "R:/ecohydrology/staff/Stribling/projects/forest_frag_wg/forest_frag/"


# EACH USER SET PATH 
# change as user/working drive changes
fp <- oss.path


# load data

cali <- vect(str_c(fp, "political_boundaries/US_States.shp"))
trin_cty <- vect(str_c(fp, "political_boundaries/Trinity_County.shp"))
cali_counties <- vect(str_c(fp, "political_boundaries/US_Counties.shp"))
trin_wsheds <- vect(str_c(fp, "Trinity_Watersheds/Trinity_Watersheds.shp"))
timb_harv <- vect(str_c(fp, "CAL_FIRE_Timber_Harvesting_Plans_All_TA83.kml"))
cal_gages <- vect(str_c(fp, "cal_gages_acae.shp"))
trin_NLCD <- rast(str_c(fp, "trin_county_NLCD_2019.tif"))
#could not get ecostress files or Area.shp to plot


#Explore data
plot(trin_NLCD)
crs(trin_NLCD)
# this raster is in Albers Conical Equal Area; 
# I have heard it is better to reproject vectors rather than rasters, so all relevant vectors will be reprojected to this crs.

plot(trin_cty)
crs(trin_cty)
trin_cty_acea <- project(trin_cty, trin_NLCD)

plot(cali)
crs(cali)
cali_acea <- project(cali, trin_NLCD)

plot(cali_counties)
crs(cali_counties)
cali_counties_acea <- project(cali_counties, trin_NLCD)

plot(trin_wsheds, col = "lightblue")
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
plot(trin_wsheds_acea, add = T, col = "lightblue", alpha = 0.2, border = "darkblue")
plot(timb_harv_acea, add=T)
plot(cal_gages, add = T, col = "red")







