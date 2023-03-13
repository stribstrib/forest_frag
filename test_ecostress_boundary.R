# PLOTTING FOREST FRAGMENTS OVER EVAPOTRANSPIRATION AND WATER USE EFFICIENCY DATA
# Author: Grace McLeod (Feb. 2023)

# Version: 1 
# Description: This script plots the ecostress data for evapotranspiration (ET) and water use efficiency (WUE) within the boundary of a fragmented forest area in northern California.
# This was the test we did during the Forest Resiliancy Working Group.

# clean Global Environment 
rm(list=ls())

# load libraries
library(sf)
library(rgdal)
library(sp)


##### IMPORT DATA ###########################################################################################################

# import KML file
kml <- st_read("/Users/gracemcleod/Documents/ForestEdges/CAL_FIRE_Timber_Harvesting_Plans_All_TA83.kml")
plot(kml)
# import frag area boundary
frag_bound <-readOGR("/iplant/home/mgracemcleod/Forest_Fragments/Areas.shp")
plot(frag_bound)
crs(frag_bound)
# import ecostress
etpt <- raster("/Users/gracemcleod/Documents/ForestEdges/ECOSTRESS_L3_ET_PT-JPL_22964_005_20220725T010100_0601_01_ETcanopy_GEO.tif")
wue <- raster("/Users/gracemcleod/Documents/ForestEdges/ECOSTRESS_L4_WUE_22964_005_20220725T010100_0601_01_WUEavg_GEO.tif")



##### PLOT WITHIN BOUNDARY ###########################################################################################################

# MATCH PROJECTIONS
# spatial data must share the same coordinate reference system (crs) to be plotted or analyzed together
crs(wue) # get crs for ecostress data
frag_bound1 <- spTransform(frag_bound, CRS("+proj=longlat +datum=WGS84 +no_defs")) # apply ecostress crs to boundary
crs(frag_bound1) # check it

# PLOT OVERLAYS
# WUE
plot(wue, ext=extent(frag_bound1))
plot(frag_bound1, add=T)
# ET
plot(etpt, ext=extent(frag_bound1))
plot(frag_bound1, add=T)