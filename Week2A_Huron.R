#Nick Huron
#R: Quantitative Science to Solve Global Problems
#Week2A_Huron.R
#also available at Github: https://github.com/nahuron

####################################################################################################
#chapter 3
####################################################################################################

#required data and packages
library(tidyverse)

#3.6 Question 6
#6
#Recreate the R code necessary to generate the following graphs.
#let's recreate each plot going L to R and T to B
#a
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se=F)
#b
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se=F, mapping = aes(group = drv))
#c
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se=F, mapping = aes(group = drv))
#d
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(se=F)
#e
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(se=F, mapping = aes(linetype = drv))
#f
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(fill = drv), stroke = 5, color = "white", lwd = 5,  shape = 21)

#3.8 Question 4
#4
#What’s the default position adjustment for geom_boxplot()? Create a visualisation of the mpg dataset that demonstrates it.
#default aggregated data
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = class, y = cty))

#vs.
#data partitioned by drv
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = class, y = cty, fill = drv))
#the default position for geom_boxplot is dodge! sweet

#3.9 Question 3

#What’s the difference between coord_quickmap() and coord_map()?
#coord_quickmap vs coord_map
#quickmap is a much faster approximation of the map version that preserves straight lines, while the full version uses projections to accurately depict earth's curvature in the 2d plane with lat/long
