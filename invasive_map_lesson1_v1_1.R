# ----------------------------------------------------------------------------------------------------------------------------
#
# Created on 12Feb18
# Purpose: Map invasive species observations in Pennsylvania
# Author: Tyler J Tran - tylerjtran at temple.edu, Matthew R Helmus - mrhelmus at temple.edu
#
# ----------------------------------------------------------------------------------------------------------------------------
#Load packages
rm(list=ls()) #start with a clean slate!
require(ggmap); require(sp); require(rgdal); require(raster); require(tidyverse); require(RColorBrewer)
# ---------------------------------------------------------------------------------
# Load Data

# Load from googlesheet
# invasives <- gs_title('all_obs_imap_18Dec17_v2_1.csv')
# invasives <- invasives %>% gs_read(ws = "all_obs_imap_18Dec17_v2_1.csv")

# Load invasive data from csv
invasives <- read_csv("/Users/nicholashuron/Google Drive/QuantSci_GP/data/PA_Invasive_Species/all_obs_imap_18Dec17_v2_0.csv") #replace file.choose() with your directory if you choose.

# Load raster data
temp <- raster("/Users/nicholashuron/Google Drive/QuantSci_GP/data/PA_Invasive_Species/raster/paTemp.tif") # Temperature data across the state
# temp <- raster('./data/raster/paTemp.tif') # Temperature data across the state

# Load polygon shapefile (can also use congressional maps, senate maps, etc. See shapefile folder)
#county <- readOGR(dsn='./data/shapefiles', layer='PaCounty2017_01')
#state <- readOGR(dsn='./data/shapefiles', layer='PaState2017_01')
county <- readOGR(dsn="/Users/nicholashuron/Google Drive/QuantSci_GP/data/PA_Invasive_Species/shapefiles/", layer='PaCounty2017_01')
state <- readOGR(dsn="/Users/nicholashuron/Google Drive/QuantSci_GP/data/PA_Invasive_Species/shapefiles/", layer='PaState2017_01')
# --------------------------------------------------------------------------------

# --------------------------------------------------------------------------------
# Clean Data

# Change some column names so we have 'lat' and 'long'
colnames(invasives)[colnames(invasives) %in% 'obsorigxcoord'] <- 'long'
colnames(invasives)[colnames(invasives) %in% 'obsorigycoord'] <- 'lat'

# what coordinate system are the raster data?
temp #WGS84

# Turn the invasives dataframe into a spatialPolygonsDataFrame of the same coordinate system
coordinates(invasives) <- ~long+lat
proj4string(invasives) <- '+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0'

# Make sure that all polygon data are in the same coordinate system WGS1984
county <- spTransform(county, CRS('+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0'))
state <- spTransform(state, CRS('+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0'))

# ---------------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------------------
### Do some exploratory data analyses on the invasives data across the state.

##  How many invasive locations per county? (or senate district, congressional area, etc.)
invasivesPerCounty <- over(invasives, county)
invasivesPerCounty <- table(invasivesPerCounty$COUNTY_NAM)
invasivesPerCounty <- as.tibble(invasivesPerCounty)
colnames(invasivesPerCounty) <- c('county', 'nInvasives')
invasivesPerCounty

## How many invasive species per county (species richness)?
srPerCounty <- over(invasives, county)
srPerCounty <- cbind(srPerCounty, invasives$state_scientific_name)
colnames(srPerCounty)[colnames(srPerCounty) %in% 'invasives$state_scientific_name'] <- 'species' # Change colname just to clean things up
srPerCounty <- group_by(srPerCounty, COUNTY_NAM) # Group data by county
srPerCounty <- dplyr::summarise(srPerCounty, sr=length(unique(species))) # Count number of unique species per county
srPerCounty

#Make a barchart of the number of invasive species (species richness) per PA county. Bonus: Can you make the plot in descending order?
#by county

ggplot(srPerCounty) +
  geom_bar(mapping = aes(x = COUNTY_NAM, y = sr, fill = factor(..x..)), stat = "identity", show.legend=FALSE) +
  coord_flip() +
  labs(y = "Species Richness", x = "County", title = "Species Richness of Invasive Species in PA by County") +
  scale_x_discrete(limits = rev(levels(srPerCounty$COUNTY_NAM)))
#this removes NA's though...

#by SR
ggplot(data = srPerCounty) +
  geom_bar(mapping = aes(x = reorder(COUNTY_NAM, sr), y = sr, fill = factor(..x..)), stat = "identity", show.legend=FALSE) +
  coord_flip() +
  labs(y = "Species Richness", x = "County", title = "Species Richness of Invasive Species in PA by County") +
  theme(axis.text.y=element_text(size=5))


#----------------------------------------------------------------------
#----------------------------------------------------------------------
## How has the number of invasives occurences changed over time?

# First, bins number of invasives over time (bin by decade)
fixDates <- unlist(strsplit(as.character(invasives$obsdate), ' '))
fixDates <- fixDates[seq(1, length(fixDates), by=2)]
invasives$obsdate <- as.Date(fixDates, format='%m/%d/%Y')
invasives$year <- as.numeric(substr(invasives$obsdate, start=1, stop=4))

# Subset the data by decade for bins 
# Note: This code could be made shorter with a 'for loop' or different type of function, 
# but let's start by showing all the code.

# invasives1900s <- invasives@data %>% filter(year >= 1900 & year <= 1909) # This is probably possible with dplyr pipe/filter() but I think easier w/ indexing bc of dataframe within spatial object
#invasivesNArm <- invasives[!is.na(invasives@data$year),] # Get rid of entries without a year
invasives1910s <- invasivesNArm[invasivesNArm@data$year >= 1910 & invasivesNArm@data$year <= 1919,] # Subset dataset to just have 1910s decade
#invasives1900s <- invasivesNArm[invasivesNArm@data$year >= 1900 & invasivesNArm@data$year <= 1909,] # Subset dataset to just have 1900s decade
#invasives1920s <- invasivesNArm[invasivesNArm@data$year >= 1920 & invasivesNArm@data$year <= 1929,] # Subset dataset to just have 1920s decade
#invasives1930s <- invasivesNArm[invasivesNArm@data$year >= 1930 & invasivesNArm@data$year <= 1939,] # Subset dataset to just have 1930s decade
# And so on... can you complete the code?

# Because I am a masochist, let's try to figure out the loop version of this
invasivesNArm <- invasives[! is.na(invasives@data$year),] # Get rid of entries without a year
(startdec <- seq(from = 1900, to = 2017, by = 10))
for(a in 1:length(startdec)){
  print(paste0("Decade starting with ", startdec[a], " and ending with ", (startdec[a]+9)))
  assign(x = paste0("invasives",startdec[a],"s"), value = invasivesNArm[invasivesNArm@data$year >= startdec[a] & invasivesNArm@data$year <= (startdec[a] + 9),])
}

# Now do the same as we did above (count # observations per county) but for each of the decade bins. 
invasivesPerCounty1940s <- over(invasives1940s, county)
invasivesPerCounty1940s <- table(invasivesPerCounty1940s$COUNTY_NAM)
invasivesPerCounty1940s <- as.data.frame(invasivesPerCounty1940s)
colnames(invasivesPerCounty1940s) <- c('COUNTY_NAM', 'nInvasives')

invasivesPerCounty1910s <- over(invasives1910s, county)
invasivesPerCounty1910s <- table(invasivesPerCounty1910s$COUNTY_NAM)
invasivesPerCounty1910s <- as.data.frame(invasivesPerCounty1910s)
colnames(invasivesPerCounty1910s) <- c('COUNTY_NAM', 'nInvasives')

invasivesPerCounty1920s <- over(invasives1920s, county)
invasivesPerCounty1920s <- table(invasivesPerCounty1920s$COUNTY_NAM)
invasivesPerCounty1920s <- as.data.frame(invasivesPerCounty1920s)
colnames(invasivesPerCounty1920s) <- c('COUNTY_NAM', 'nInvasives')

invasivesPerCounty1930s <- over(invasives1930s, county)
invasivesPerCounty1930s <- table(invasivesPerCounty1930s$COUNTY_NAM)
invasivesPerCounty1930s <- as.data.frame(invasivesPerCounty1930s)
colnames(invasivesPerCounty1930s) <- c('COUNTY_NAM', 'nInvasives')

# Complete the code...

# ------------------------------------------------------------------------------------------
### Now let's actually start plotting/mapping
# There are many ways to map in R, including just base graphics using plot(), or a handy function from the sp package spplot(). Below I'm going to show mapping using both the function spplot() and using ggplot.
# A quick note on ggplot: it will only accept dataframes as input, and because we're using spatialPolygonsDataFrames (SPDF), we'll have to do a little work first. See below.


## Map counties of PA (or whatever other jurisdiction you want) colored by # of invasive *observations* per county
# First join the data we put together above with the spatialPolygonsDataframe 'county' otherwise if you do not link the data, R will not know what to plot
invasivesCounty <- county
colnames(invasivesCounty@data)[colnames(invasivesCounty@data) %in% 'COUNTY_NAM'] <- 'county' # Need colnames in common between two dataframes that you're trying to join
invasivesCounty@data <- left_join(invasivesCounty@data, invasivesPerCounty, by='county') # Join df invasivesPerCounty to the df associated with shapefile invasivesCounty by the column 'county'

# Map with ggplot
invasivesCountygg <- fortify(invasivesCounty, region='county') # Now let's plot using ggplot. This is to alter the SPDF so that we can input into ggplot
invasivesCountygg <- left_join(invasivesCountygg, invasivesCounty@data, by=c("id" = 'county')) # Join the attributes back to the df from fortify()
p <- ggplot(data=invasivesCountygg)+
  geom_polygon(aes(x=long, y=lat, group=group, fill=nInvasives))+ # Color the counties by nInvasives
  coord_fixed(1.3)+ # This is to fix the height-width scale. Try without it and see what happens.
  scale_fill_gradient()
p # See the map


# There is is also a simpler way to map!
spplot(invasivesCounty, 'nInvasives') # First using spplot(). This can be altered for map aesthetics.

## Map counties of PA (or whatever other jurisdiction you want) colored by # of invasive species (invasive species richness) per county
invasivesSR <- county
invasivesSR@data <- left_join(invasivesSR@data, srPerCounty, by='COUNTY_NAM') # Join df invasivesPerCounty to the df associated with shapefile invasivesCounty by the column 'COUNTY_NAM'

spplot(invasivesSR, 'sr') # OR you can use ggplot (see above)
# -------------------------------------------------------------------------------
# -------------------------------------------------------------------------------

## Map counties of PA colored by # observations binned by decade to show time series. I will show only a couple decades but the process is the same...
# Like above, we'll first join the invasivesPerCounty decadal dataframes to a spatialPolygonsDataFrame so that we can map
# For 1900s decade
invasivesCounty1900s <- county
invasivesCounty1900s@data <- left_join(invasivesCounty1900s@data, invasivesPerCounty1900s, by='COUNTY_NAM') # Join df invasivesPerCounty1900s to the df associated with shapefile invasivesCounty by the column 'county'

spplot(invasivesCounty1900s, 'nInvasives') # This is the line that draws map. This is the simplest version of this function, and can be altered for map aesthetics

# For 1910s decade
invasivesCounty1910s <- county
invasivesCounty1910s@data <- left_join(invasivesCounty1910s@data, invasivesPerCounty1910s, by='COUNTY_NAM') # Join df invasivesPerCounty1910s to the df associated with shapefile invasivesCounty by the column 'county'

spplot(invasivesCounty1910s, 'nInvasives') # This is the line that draws map. This is the simplest version of this function, and can be altered for map aesthetics

# and so on for other decades...
# ---------------------------------
# END OF LESSON 1