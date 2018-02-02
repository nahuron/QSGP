#Nick Huron
#R: Quantitative Science to Solve Global Problems
#RfDS_Huron_Nicholas.R
#also available at Github: https://github.com/nahuron

####################################################################################################
#chapter 3
####################################################################################################

#3.1
#Load required packages
library(tidyverse)

#3.2
#use mpg dataframe for this exercise (can use just 'mpg' if ggplot2 is loaded)
ggplot2::mpg

#figure out attributes of mpg
attributes(mpg)
#displ is the volume displacement of the engine (size) and hwy is highway mileage in mi/gal
#ggplot2 code to create a scatter plot of displ vs hwy
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

#3.2.4 exercises

#1
#just the first line here creates a grey box
ggplot(data = mpg)

#2
#find number of cols and rows in mpg (rows x columns returned)
#11 cols and 234 rows
dim(mpg)

#3
#variable drv tells us the type of drive (front vs rear vs 4wd)
?mpg

#4
#scatterplot of hwy vs cyl
ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cyl))

#5
#scatterplot of class vs drv
#this plot maps two factors (categorical vars), which means any cars that contain the same factor for each will stack on a single point... loss of info/not very informative
ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))

#3.3
#group points with aesthetic third class for colour
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, colour = class))

#group points with aesthetic third class for size of point
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

#group points with aesthetic third class for opacity of point
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

#group points with aesthetic third class for opacity of point
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
#shapes are limited to <7 symbols with defaults... ruh roh

#exercises 3.3.1

#1
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = "blue"))  #internal ) needs to close aes prior to color specification

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), colour = "blue")   #legend disappears though

#2
#which data are factors in mpg?
?mpg
#looking at mpg in print out, it gives the classes prior to the first row (manufacturer, model, trans, drv, fl, and class are all categorical, but year technically could be considered an integer version of one too)
#displ is the only "true" continuous variable in the narrow sense, but year, cyl, cty, and hwy are all numeric

#3
#map continuous variable to colour, size, and shape
ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cty, colour = cyl, size = displ, shape = year))
#continuous variables cannot be mapped to shape... error kicks in. others appear to work, color goes to a gradient

#4
#map same variable to multiple aesthetics
ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cty, colour = cyl, size = cyl))
#uses it for both!

#5
#stroke aesthetic? affects thickness of lines in symbols
ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cty, stroke = cyl, colour = year, shape = trans))

#6
#map aes to something other than var name: seems to go binary
ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cty, colour = displ < 5))

#3.5
#adding facets
#changed some things up to play with a bit
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cty, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

#facets by two categories in a single grid
#the formula follows the form of y ~ x
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv~cyl)

#version without faceting in rows
#the '.' is the key
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(.~cyl)

#exercises 3.5.1

#1
ggplot(data = mpg) +
  geom_point(mapping = aes(x = cty, y = hwy)) +
  facet_grid(.~displ)
#when using a continuous var for faceting, it facets for each unique value (messy)

#2
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl)) +
  facet_grid(drv ~ cyl)
#faceting these two categorical vars creates a grid where the values intersect .: empty boxes mean that no rows contain those two values for the vars

#3
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
#plots displ by hwy with faceting of three rows for each of the drv options (plots separately by drv type)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
#now we are plotting the same data but splitting into the 4 columns by the cyl var

#4
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
#Faceting can help separate data that would otherwise be stacked in a smaller space that may not be shown effectively with a colour aesthetic.
#That being said, it separates data into different plots, which may make it more difficult to view as a whole or compare specific pairs of groups if not displayed most effectively.
#With a larger dataset, the point crowding problem can become more prominent, making faceting more favorable.

#5
?facet_wrap
#nrow in this function sets the number of rows for the plot, same goes for ncol for columns
#you can change the scale of dims, change the ordering, drop certain factors for plotting, placement of labels for categories, etc.
#facet_grid is set with the facets argument, which dictates the number of rows and columns based on the number of unique values in the variables in the formula put in

#6
#I actually do not know the answer to this, but i assume that the x axis is easier to read with more items. This would make sense if you are looking at differences in the response variable among groups. Side by side, this is easier to do.


#3.6
#compare left and right plots
#left
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
#right
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

#set the mapping linetype
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

#map multiple aesthetics to one plot
#standard line as before
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
#group by drivetrain as before, but with group instead of linetype
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
#color the lines by group for drivetrain, do not add a legend
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv),
              show.legend = F
              )
#display multiple geoms in the same plotspace, oh snap!
#raw points and raw line together
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

#you can map things globably by doing so in the ggplot command rather than individual geoms
#more efficient version of the above code
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

#you can set the local mapping for a layer nonetheless that overrides the global one
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()
#can also do this to show subsets of data (here use just subcompact cars for the line)
#we are also dropping the SE range around the line
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"), se = F)

#exercises 3.6.1
#1
#line chart: geom_line
#boxplot: geom_boxplot
#histogram: geom_histogram
#area chart: geom_area

#2
#plot of lines and points, will be all color coded by drv, no SE region in lines
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() + 
  geom_smooth(se = F)

#3
#show.legend=FALSE removes the legend from the display of that particular layer
#it allows us to better understand the code? it also leads to cleaner bigger plots

#4
#se is a binary T/F argument that sets the standard error around the smooth line in the geom_smooth call

#5
# I do not think so, the individual layers in the second plot  call the same global vars from the first one
#first one
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()
#second one
ggplot() +
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#6
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

#3.7
#sparkly diamonds and barplots
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))
#boxplots make statistical transformations ("stats") to display data in a summarized fashion
#the stat argument of any geom has a default you can check

#can use stat_count() to make the same plot as above
ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))
#stats have default geoms too! that is why this works
#if you have the counts tabulated already, you can switch the default stat to reflect that rather than having R calculate the counts of bins
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

#change the mapping to be proportions (rel freq)
#..prop.. is a variable created by the default stat for geom_bar
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

#look at the transformations more closely
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

#exercises 3.7.1
#1
#default geom for stat_summary is "pointrange"

#2
#geom_bar counts the instances of each bin across the x axis and geom_col uses values of the data as they are (identity in an above example)

#3
#geom_bar geom_col stat_count
#geom_bin2d stat_bin_2d 
#geom_boxplot stat_boxplot 
#geom_contour stat_contour 
#geom_count stat_sum 
#geom_density_2d stat_density_2d
#geom_density stat_density 
#geom_hex stat_bin_hex 
#geom_freqpoly geom_histogram stat_bin 
#geom_qq stat_qq 
#geom_quantile stat_quantile 
#geom_smooth stat_smooth 
#geom_violin stat_ydensity 
#geom_sf stat_sf
#most of these obvious pairs have the same post geom_ or post stat_ nomenclature! This makes it easy to call the corresponding geom/stat function in a pair

#4
#stat_smooth computes: a predicted value of y, a lower and upper pointwise confidence interval around the mean, and standard error
#The function is controlled by the following arguments found in the documentation:

#stat_smooth(mapping = NULL, data = NULL, geom = "smooth",
#position = "identity", ..., method = "auto", formula = y ~ x,
#se = TRUE, n = 80, span = 0.75, fullrange = FALSE, level = 0.95,
#method.args = list(), na.rm = FALSE, show.legend = NA,
#inherit.aes = TRUE)

#5
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))
#these plots show the proportions as all 1 (and 1 for each color option in the second case)
#they appear to be unable to understand the call for cumulative proportion...

#3.8
#color outlines by cut with colour argument
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
#or the whole bar with fill
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

#can make stacked bars for each x category according to another var with fill command by a discrete value
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))
#this uses position argument to an auto setting of "stack"
#but we have some other options: identity, dodge, and fill (also jitter too, but it is not helpful for bar plots)
#identity places portions of the bar by their individual totals within the same bar (smaller stuff to the bottom), makes it difficult to see without messing with transparency with alpha or fill=NA
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

#position="fill" makes the bars all proportions and stacks them (proportion of total for that x category)
#so even though ideal is larger in the diamonds dataset, both it and fair are set to the same max of 1.0 total proportion
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

#position="dodge" puts values next to each other, so this makes a bar chart of bar charts for these data
#this is purrrttyyyy
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

#so overplotting... rounding of values when points are close (think xy scatter plots), makes it seem like there are fewer points
#so set position="jitter" to get around this
#adds random noise to each point to make visualization easier
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

#geom_jitter is a shortcut to this argument, it functions just like geom_point(position="jitter")

#exercises 3.8.1
#1
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()
#suspect that points are overplotted, try with geom_jitter instead
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter()
#yup.

#2
?geom_jitter
#width and height control the possible range of jittering that occurs in those particular dims

#3
?geom_jitter
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter()
#vs
?geom_count
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_count()
#so geom_count works nicely when you have numerous instances of the same value. instead of jittering the points to make it seem like they are not identical (think discrete vars this is problematic), it increases point size for n same values
#pretty cool alt to geom_jitter

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
#This is also in the documentation for geom_boxplot()

#3.9

#so coordinate systems...
#coord_flip flips the  x and y axes
#helpful for swapping boxplots, bar plots, etc.
#original horizontal config
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
#now with coord_flip
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()

#coord_quickmap() helps get maps for spatial data happy
#data to play with
nz <- map_data("nz")

#without coord_quickmap: yucky distortion due to trying to stretch to fit plot space
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

#now try this: scales equal-ish and cleaner?
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

#and of course coord_polar works for polar coordinates: have not used those since calc or precalc
#example with diamonds
#create object for calling plot!
bar <- ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut), show.legend = FALSE,width = 1) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

#flip it, cuz we can
bar + coord_flip()
#use polar coords: looks pretty cool actually
bar + coord_polar()

#exercises 3.9.1

#1
#looking at the coord_polar documentation, setting the x in the bar plot to be a factor grouping of 1 gives you a single stacked bar that can be easily converted to a pie chart for a single var
bar <- ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = factor(1), fill = cut), show.legend = FALSE,width = 1, position="fill") + 
  theme(aspect.ratio = 1)

#setting theta gives the angle mapping such that you cut the pie up rather than getting a bullseye cutting up
bar + coord_polar(theta="y")

#2
#labs() configures labels for the plotting space, you can add custom ones or edit existing ones

#3
#coord_quickmap vs coord_map
#quickmap is a much faster approximation of the map version that preserves straight lines, while the full version uses projections to accurately depict earth's curvature in the 2d plane with lat/long

#4
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()

#they are largely linear and positively correlated, but not with a slope of 1 (hwy is generally higher than city for all data points)
#coord_fixed is important, because it makes it easy to identify what y=x is (the abline command creates this line on the plot) and ensure that the scale on both axes is consistent

#3.10

#general form of plotting template
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(
    mapping = aes(<MAPPINGS>),
    stat = <STAT>, 
    position = <POSITION>
  ) +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION>
  
####################################################################################################
#chapter 4
####################################################################################################

#4.1
#some great humor in this chapter

#summary: you can do cool stuff with r (use as a calc, assign objects), do not be a jerk/code cleanly

#4.2

#code meticulously and name with conventions, lest ye be one who likes to see the world burn

#4.3

#functions!
#surround assignments with () to show values at once

#4.4

#1
my_variable <- 10
my_varıable
#> Error in eval(expr, envir, enclos): object 'my_varıable' not found
#this code does not work, because the i is dotted in the assignment and not dotted in the call for the variable to see what it contains

#2
#tweak each of the commands so that they work

#this library call seems fine...
library(tidyverse)

ggplot(dota = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
#to
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

fliter(mpg, cyl = 8)
filter(diamond, carat > 3)
#to
filter(mpg, cyl == 8)
filter(diamonds, carat > 3)

#3
#alt+shift+k gives you a screen of shortcuts in rstudio! You can get to via dropdowns (Help -> Keyboard Shortcuts Help)

####################################################################################################
#chapter 5
####################################################################################################

#5.1

#packages
library(nycflights13)
library(tidyverse)

#dataset to use
flights

#5.2

#using filter to subset the data according to values
filter(.data = flights, month==1, day==1)

#save the filtered subset in a new object
jan1 <- filter(flights, month==1, day==1)

#put the same command in () to assign to object AND still print
(jan1 <- filter(flights, month==1, day==1))

#floating point numbers make some logical statements not work
#should be TRUE but are FALSE
sqrt(2) ^ 2 == 2

1/49 * 49 == 1

#this is because computers use estimates of numbers rather than infinite continous values
#so use near command to get there instead
near(sqrt(2)^2, 2)
near(1/49*49, 1)
#these now return TRUE

#logical operators
#& is and (intersection)
#! is not
#| is or (union)
#xor( ) is everything but the intersection

filter(flights, month == 1 | month == 12)

#fun little note: there are longer ways to do a logical operator
filter(flights, xor(month == 1, month == 12))
filter(flights, ((month == 1  | month == 12) & !(month == 1  & month == 12)))

#this version does not do the same as the first filter function
filter(flights, month == 11 | 12)
#the argument goes to TRUE which numerically is 1

#using the %in% function
nov_dec <- filter(flights, month %in% c(11,12))

#De Morgan's Law is referenced here
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

#filter only uses rows where conditions are true, you have to ask to keep FALSE's and NA's
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
#to keep NA's, call it
filter(df, is.na(x) | x > 1)

#5.2.4 exercises

#1
#.1: arrival delay >= 120 min
filter(flights, arr_delay >= 120) #10200

#.2: flew to Houston (IAH or HOU)
filter(flights, dest %in% c("IAH", "HOU")) #9313

#.3: operated by united, american, or delta
#find the codes
unique(flights$carrier)
#filter
filter(flights, carrier %in% c("AA","UA", "DL")) #139504

#.4: departed in summer (July, August, September)
filter(flights, month > 6 & month < 10) #86326

#.5: arrive > 120 min late but did not depart late
filter(flights, arr_delay > 120 & dep_delay <= 0) #29
 
#.6: delayed >= 60 min and made up over 30 min in flight (difference in initial and final delays >30)
filter(flights, dep_delay >= 60 & (dep_delay - arr_delay) > 30) #1844

#.7: departed between 00:00 and 06:00 inclusive ( dep_time >= 0000 and dep_time <=0600)
filter(flights, dep_time >= 0 & dep_time <= 600)  #9344

#2
?between
#this function is a shortcut for >= and <= together and is implemented in c++
#you can use it to simplify code in #1.4 and 1.7
#.4
filter(flights, between(month, 7, 9)) #86326 matches
#.7
filter(flights, between(dep_time, 0, 600))  #9344 matches

#3
#how many flights are missing dep_time? what other vars are missing in these? what might these rows represent?
(nodep <- filter(flights, is.na(dep_time)))

#There are 8255 flights without dep_time values (they have NA instead). They are all missing dep_delay, arr_time, arr_delay, and air_time as well. Some also are missing tailnum.
colnames(nodep)[colSums(is.na(nodep)) > 0]
#together, this suggests that these flights never got off the ground but rather were cancelled.

#4
#Why os Na^0 not missing?
NA^0
#mathematically, any value that is raised to the power of 0 is equal to 1. Thus, even though the value is not known, the value equates to 1

#Why is NA | TRUE not missing?
NA | TRUE
#This statement is an 'or' statement. Thus, even though NA is missing, the TRUE evaluates as TRUE. Thus, the returned values is TRUE rather than missing

#Why is FALSE & NA not missing?
FALSE & NA
#The expression here is FALSE for results. If an expression is ambiguous and FALSE, it is altogether FALSE (same goes for FALSE & TRUE).

#Can you figure out a general rule? NA*0 is a tricky counterexample.
NA*0
#this may be an exception because infinity and -infinity are possible values in R. A quick look online suggests that 0*Inf is undefined, which is different from 0. Thus, there may be multiple possible solutions to NA*0
#In general, if the ambiguity of an expression containing NA can be removed to a specific certain value, R will return that as output instead of NA (missing).

#5.3
#changing a tibble's order via arrange()

arrange(flights, year, month, day)

#desc() can be used to do it in descending order
arrange

#missing values are always at the end, regardless of desc

#exercises 5.3.1

#1
arrange(flights, desc(rowSums(is.na(flights)))) #thank you stackoverflow, this sorts by the number of rows with NA values for each column

#2

#most delayed flights for departure
arrange(flights, desc(dep_delay))
#most delayed flights for arrival
arrange(flights, desc(arr_delay))
#maybe this will sort by total net delay...
arrange(flights, desc(dep_delay+(arr_delay - dep_delay)))

#find the flights that left the earliest
arrange(flights, dep_delay)

#3
#sort flights to find the fastest flights
#if by fastest we want greatest avg velocity, we go with greatest distance/air_time
arrange(flights, desc(distance/air_time))

#shortest flight times would be
arrange(flights, air_time)

#4
#flights that travel the longest
arrange(flights, desc(distance))

#flights that travel the shortest
arrange(flights, distance)

#5.4
#using select() to get only some cols

select(flights, year, month, day)
select(flights, year:day)
#select all cols except those from year to day
select(flights, -(year:day))

#functions that help select()
starts_with("abc")
ends_with("xyz")
contains("jkl")
matches("(.)\\1") #finds vars with regex, this one is for repeating chars
num_range("x", 1:3) #matches x1, x2, x3

#you can rename vars with select, but rename() is easier
rename(flights, tail_num = tailnum) #oddly, it doesnt seem to show on this print the first time

#manipulating with select and everything can make moving cols easier
select(flights, time_hour, air_time, everything())
#note: it does not copy the initially selected cols in the command above

#exercises 5.4.1

#1
select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, starts_with("dep_"), starts_with("arr_"))
#i am sure there are more

#2
select(flights, dep_time, dep_time, dep_delay)
#it appears to not add dup columns

#3
?one_of
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
select(flights, one_of(vars))
#one_of appears to select the columns that in an object based on a vector of col names

#4
select(flights, contains("tImE"))
#it appears that it is not case sensitive by default. change the argument ignore.case=FALSE to be case sensitive

#5.5
#mutate() and adding new vars

#7 cols
(flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time))

#adds two cols
mutate(flights_sml, gain = arr_delay - dep_delay, speed = distance / air_time * 60)

#you can do the same command, but as you create vars, you can create an additional col with them
mutate(flights_sml, gain = arr_delay - dep_delay, hours = air_time / 60, gain_per_hour = gain / hours)

#transmute can be used to only keep the new vars
transmute(flights, gain = arr_delay - dep_delay, hours = air_time / 60, gain_per_hour = gain / hours)

#modular maths: using remainders %% and integer division %/%
transmute(flights, dep_time, hour = dep_time %/% 100, minute = dep_time %% 100)

#using leading and lagging commands lead() and lag()
x <- 1:10
lag(x)  #first value is changed to NA and sequence begins, ending without 10
lead(x) #last value is changed to NA and sequence is the same except no 1 (value in x[1]==2)

#cumulative and rolling aggregates
cumsum(x) #adds values as you go along a vector
#also have: cumprod(), cummin(), cummax(), and dplyr::cummean()

#ranking is something else that can be used
y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)
min_rank(desc(y)) #note RE:desc(): values are transformed (in this case, *-1) to get descending order

#some alternatives to min_rank
row_number(y)   #no ties
dense_rank(y)   #ties, but does not skip numbers
percent_rank(y) #values between 0-1 by rescaling min_rank
cume_dist(y)    #cum distr function, all values less than or equal to current rang
ntile(y, n = 2) #uses quantiles (n) to bin rankings

#exercises 5.5.2

#1
#convert dep_time and sched_dep_time from numeric representation of time to min since midnight
transmute(flights,
          dep_time,
          minutes = ((dep_time %/% 100)*60)+(dep_time %% 100), 
          sched_dep_time, 
          sched_minutes =  ((sched_dep_time %/% 100)*60)+(sched_dep_time %% 100)
          )

#2
#expect to see a difference between air_time and the difference in arr and dep times, since they are not in minutes and air_time is. Furthermore, they may include different time zones, which leads to incorrect  calculations
select(flights, air_time, arr_time, dep_time)
#try the function comparing them
transmute(flights,
          air_time, 
          (arr_time - dep_time)
          )
#yup, they do not match
#to fix it (somewhat), let's convert the two latter times to minutes as new vars and then do the maths
transmute(flights, 
          origin,
          dep_time, 
          dep_minutes = (((dep_time %/% 100)*60)+(dep_time %% 100)), 
          dest,
          arr_time, 
          arr_minutes = (((arr_time %/% 100)*60)+(arr_time %% 100)), 
          air_time,
          (arr_minutes - dep_minutes)
          )
#however, we still have not accounted for differences in time zones =/

#3
#compare dep_time, sched_dep_time, and dep_delay
select(flights, dep_time, sched_dep_time, dep_delay)
#dep_time - sched_dep_time should == dep_delay, except where days transition for time
#to show this:
transmute(flights, dep_time, sched_dep_time, dep_delay, dep_delay_check = ((((dep_time %/% 100)*60)+(dep_time %% 100)) - (((sched_dep_time %/% 100)*60)+(sched_dep_time %% 100))))
#we can see that the first ten entries seem to check out
#however, if we sort by dep_delay with desc()
arrange(transmute(flights, dep_time, sched_dep_time, dep_delay, dep_delay_check = ((((dep_time %/% 100)*60)+(dep_time %% 100)) - (((sched_dep_time %/% 100)*60)+(sched_dep_time %% 100)))), desc(dep_delay))
#still not matching up for all of these, you can see from the first entry that this is because of not accounting for changing of dates

#4
#find 10 most delayed flights via ranking function, use row_number() to skip ties
arrange((mutate(flights, dep_delay_rank = row_number(desc(dep_delay)))), dep_delay_rank, dep_delay)
#displays the top 10 most delayed flights

#5
1:3 + 1:10
#This retuns the sequence below
#[1]  2  4  6  5  7  9  8 10 12 11
#Warning message:
#  In 1:3 + 1:10 :
#  longer object length is not a multiple of shorter object length
#Since the two sequences are not of the same length, the shorter is repeated until the longer has been completed for the task, this is why the last number is 11 (repeats to the start of the first sequence, so 1+10=11)

#6
#trig functions in R?
#normal trig functions: sin, cos, tan
#these have analogues that assume you are multiplying the interior by pi: sinpi, cospi, tanpi
#arc trig functions: acos, asin, atan, and the "two argument arc tangent": atan2

#5.6
#summarise() as a way to group summaries

summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

#gets more useful with the group_by() function
(by_day <- group_by(flights, year, month, day))
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))
#we now have a summary for each day of the average delay across all flights then

#using the pipe to combine multiple operations... ooooooo
(by_dest <- group_by(flights, dest))
(delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
))
(delay <- filter(delay, count > 20, dest != "HNL"))

#graph the data!
ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

#the above code is a pain, we have to name intermediate objects, gets time consuming
#with the pipe (%>%) we do not have to! THINK OF THE PIPE AS "THEN" IN CODE

delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")

#using NA removal functions
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

#using counts and counts of non-NA's
delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarise(delay = mean(arr_delay))

ggplot(data = delays,
       mapping = aes(x = delay)) +
geom_freqpoly(binwidth = 10)

#flights vs average delay
delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )

ggplot(data = delays, 
       mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)

#filtering out small sample groups and plot in the %>% and + approach
delays %>%
  filter(n >50) %>%
  ggplot(mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)

#use command + shift + p to resend a previous block of code! so convenient!

#now to do it again with the Lahman package
install.packages("Lahman", dependencies = T)
library(tidyverse)
library(Lahman)

#gather data and organize to compare batters BA and # at bats (AB)
batting <- as_tibble(Lahman::Batting)

batters <- batting %>%
  group_by(playerID) %>%
  summarise(
    ba = sum(H, na.rm=T) / sum(AB, na.rm=T),
    ab = sum(AB, na.rm=T)
  )

#now let's pipe it to get it plotted
batters %>%
  filter(ab > 100)  %>%
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() +
  geom_smooth(se = F)

#arrange dataset by ba in descending order
batters %>% arrange(desc(ba))
#players with great BA seem lucky!!!

#some other summary functions

#measures of central location
not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0]) #average of actual delays
  )
#median() is also an option

#measure of spread
#sd()
#IQR()
#mad()

not_cancelled %>%
  group_by(dest) %>%
  summarise(distance_sd = sd(distance)) %>%
  arrange(desc(distance_sd))

#measure of rank
#min()
#max()
#quantile(x, 0.25)

not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

#measures of position
#first()
#last()
#nth(x, 1) this is the first

not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(
    first_dep = first(dep_time),
    last_dep = last(dep_time)
  )

#can use ranking with filtering by range to get the min and max values for each date
not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r))

#you can also count different values
#n() for size of a current group
#sum(!is.na(x)) for all non-NA values
#n_distinct(x) for all unique values --> how is this different from the unique() command?


# Which destinations have the most carriers?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))

#dplyr has a counts function to make finding counts easier!
not_cancelled %>%
  count(dest)
#counts can be weighted too, this one gets the total miles a plane flew
not_cancelled %>%
  count(tailnum, wt = distance)

#can count number of logical values, TRUE is 1 and FALSE is 0
# How many flights left before 5am? (these usually indicate delayed
# flights from the previous day)

not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(n_early = sum(dep_time < 500))

# What proportion of flights are delayed by more than an hour?
not_cancelled %>% 
  group_by(year, month, day) %>%
  summarise(hour_perc = mean(arr_delay > 60))

#grouping by multiple vars (progressively)
daily <- group_by(flights, year, month, day)
(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))

#ungroup() can be used to ungroup data
daily %>%
  ungroup %>%
  summarise(flights = n())

#exercises 5.6.7

#1
#Brainstorm at least 5 different ways to assess the typical delay characteristics of a group of flights. Consider the following scenarios:
#A flight is 15 minutes early 50% of the time, and 15 minutes late 50% of the time.
#A flight is always 10 minutes late.
#A flight is 30 minutes early 50% of the time, and 30 minutes late 50% of the time.
#99% of the time a flight is on time. 1% of the time it’s 2 hours late.

#if we are assuming the EXACT amount of time late or early:

delays <- flights %>%
  group_by(flight) %>%
  summarise(per_flight_num = n(), 
            early15 = mean(dep_delay == -15, na.rm = T),
            late15 = mean(dep_delay == 15, na.rm = T),
            always10late = mean(dep_delay == 10, na.rm = T),
            early30 = mean(dep_delay == -30, na.rm = T),
            late30 = mean(dep_delay == 30, na.rm = T),
            ontime99 = mean(dep_delay == 0, na.rm = T),
            twohourslate = mean(dep_delay == 120, na.rm = T)
            )
#A flight is 15 minutes early 50% of the time, and 15 minutes late 50% of the time.
delays %>%
  filter(early15 == 0.5, late15 == 0.5) #never the case
#A flight is always 10 minutes late.
delays %>%
  filter(always10late == 1.0) #5 instances
#A flight is 30 minutes early 50% of the time, and 30 minutes late 50% of the time.
delays %>%
  filter(early30 == 0.5, late30 == 0.5) #never the case
#99% of the time a flight is on time. 1% of the time it’s 2 hours late.
delays %>%
  filter(ontime99 == 0.99, twohourslate == 0.01)  #never the case

#Which is more important: arrival delay or departure delay?
#This depends on the question. Since there are some flights with wonky arrival delay data, I may stick with departure. 
#Additionally, departure may be a decent indicator of how smoothly everything is running, assuming expected stable/consistent flight times.

#2
#find alternative to code without using count()
not_cancelled %>% count(dest)

#alternative without count
not_cancelled %>%
  group_by(dest) %>%
  summarise(n())

not_cancelled %>% count(tailnum, wt = distance)

#alternative without count
not_cancelled %>%
  group_by(tailnum) %>%
  summarise(sum(distance))

#3
#the definition: (is.na(dep_delay) | is.na(arr_delay) )  for canceled flights is suboptimal. why? Which col is more important?

#using NA removal functions
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

#if we take the original function above and remove the ! from the arr_delay query, we can see that there are a number of flights that contain a departure delay 
#but have NA for the arrival delay but have an actual arrival time and scheduled arrival time. While they do not have air time values either, this suggests that
#some flights may have not been cancelled (perhaps redirected)? With this in mind, it seems like !is.na(dep_delay) is more important.
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), is.na(arr_delay))
View(not_cancelled)

#4
#get summary table of number of cancelled flights per day
(cancel <- flights %>%
  group_by(year, month, day) %>%
  filter(is.na(dep_delay)) %>%
  summarise(n_cancelled = n()))

#find relative number of cancelled flights per day (prop of flights) and mean delay
(all_flights <- flights %>%
    group_by(year, month, day) %>%
    summarise(prop_cancelled = sum(is.na(dep_delay))/n(), n_cancelled = sum(is.na(dep_delay)), n_flights = n(), mean_delay = mean(dep_delay, na.rm =T)))
  
#plot prop cancelled v mean delay
ggplot(data = all_flights) +
  geom_point(mapping = aes(x = prop_cancelled, y = mean_delay))
#it sure seems like a positive relationship exists between mean delay and proportion of cancelled flights!

#5
#which carrier has the worst delays?
carriers <- flights %>%
  group_by(carrier) %>%
  summarise(mean_dep_delay = mean(dep_delay, na.rm = T), mean_arr_delay = mean(arr_delay, na.rm = T))

#plot
ggplot(data = carriers, mapping = aes(x = carrier)) +
  geom_bar(mapping = aes(y= mean_dep_delay), stat = "identity")
ggplot(data = carriers, mapping = aes(x = carrier)) +
  geom_bar(mapping = aes(y= mean_arr_delay), stat = "identity")
#seems like F9 has the worst delays on average for both arr and dep

#Challenge: can you disentangle the effects of bad airports vs. bad carriers? Why/why not? (Hint: think about flights %>% group_by(carrier, dest) %>% summarise(n()))
delays <- flights %>% 
  group_by(carrier, dest) %>% 
  summarise(mean_dep_delay = mean(dep_delay, na.rm = T)) %>% 
  group_by(carrier) %>% 
  summarise(SD = sd(mean_dep_delay, na.rm = T), M = mean(mean_dep_delay, na.rm = T))
#we can see the means and SD by dest here, so we can kind of get the picture...

#while it may be possible to potentially get at the dest biases, there is great disparity of flights to airports. Some airlines only go to 1 or 2 destinations, such as F9
#this can be deconstructed
carriers_dest <- flights %>%
  group_by(carrier, dest) %>%
  filter(!is.na(dep_delay) & dep_delay > 0)
#look at dest and carriers
ggplot(data = carriers_dest) +
  geom_bar(mapping = aes(x = carrier, fill = dest), position = "dodge", show.legend = F)

#6
?count
#the sort=TRUE argument in count() sorts the output in descending order. This can make it easy to see which groupings have the most observations! Determining the top x groups would be easier with this function/argument

#5.7

#convenient options for mutate and filter
flights_sml %>% 
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)
#this uses the rank function to find the 10 worst instances for the grouping

#find observations over a certain amount
(popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365))
#can continue with this dataset to find summary data of delays by dest and date
popular_dests %>% 
  filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)

#generally avoid a grouped mutate followed by an ungrouped filter, they are hard to make sure you did them correctly
#visit the vignette("window-functions") sometime

#exercises 5.7.1

#1
#mutate and filter "helpful" functions
#lag, lead      #lead or lag is applied to the last/first value for each particular group
View(flights %>%
  group_by(carrier) %>%
  mutate(dep_delay_2 = lag(dep_delay, n = 1)) %>%
  filter(carrier == "AA"))
#cumsum, cumprod, cummin, cummax, cummeans    #again the function is applied by group
View(flights %>%
       group_by(carrier) %>%
       mutate(dep_delay_2 = cumsum(air_time)) %>%
       filter(carrier == "UA"))
#min_rank, row_number, dense_rank, percent_rank, cume_dist, ntile   #see previous entries
View(flights %>%
       group_by(carrier) %>%
       mutate(dep_delay_2 = min_rank(air_time)) %>%
       filter(carrier == "UA"))
#rank, desc   #see above entry
View(flights %>%
       group_by(carrier) %>%
       mutate(dep_delay_2 = rank(air_time)) %>%
       filter(carrier == "UA"))
#desc just makes everything *-1 for a numeric col
#n      #this now tells you the total n of observations for the group, repeated for each entry with mutate
View(flights %>%
       group_by(carrier) %>%
       mutate(dep_delay_2 = n()) %>%
       filter(carrier == "UA"))


#2
#Which plane (tailnum) has the worst on-time record?

flights %>%
  group_by(tailnum) %>%
  mutate(mean_dep = mean(dep_delay, na.rm = T)) %>%
  select(tailnum, mean_dep) %>%
  arrange(desc(mean_dep))
#N844MH has the worst average departure delay

#3
flights %>%
  group_by(hour) %>%
  filter(!is.na(dep_delay) & dep_delay > 0) %>%
  summarise(worst_time = mean(dep_delay, na.rm = T)) %>%
  ggplot() +
  geom_bar(mapping = aes(x = hour, y = worst_time), stat = "identity")
#sure seems like 1900 is a pretty terrible time to fly, but the same goes for all evening times

#4
#For each destination, compute the total minutes of delay. 
View(flights %>%
  group_by(dest) %>%
  filter(!is.na(dep_delay)) %>%
  summarise(total_delay = sum(dep_delay))) #ATL has a ton of delays... I can confirm that this is true after spending a night sleeping there after ~3 weeks of fieldwork

#For each, flight, compute the proportion of the total delay for its destination.
View(flights %>%
  group_by(dest) %>%
  filter(!is.na(dep_delay)) %>%
  mutate(total_delay = sum(dep_delay)) %>%
    group_by(flight) %>%
    mutate(prop_delay = dep_delay/total_delay))

#5
#Using lag() explore how the delay of a flight is related to the delay of the immediately preceding flight.
flights %>%
  group_by(year, month, day, sched_dep_time) %>%
  arrange(origin) %>%
  group_by(origin) %>%
  filter(!is.na(dep_delay)) %>%
  mutate(previous_flight = lag(dep_delay, n = 1)) %>%
  filter(!is.na(previous_flight)) %>%
ggplot() +
  geom_point(mapping = aes(x = dep_delay, y = previous_flight), position = "jitter", show.legend = F, size = 0.75) +
  geom_smooth(mapping = aes(x = dep_delay, y = previous_flight), se = F, method = "lm")
#does not look like there is a crazy relationship, but it is positive...
  
#6
  #look at destinations for flights that are suspiciously fast
#Compute the air time a flight relative to the shortest flight to that destination. Which flights were most delayed in the air?
flights %>%
  filter(!is.na(air_time)) %>%
  group_by(dest, origin) %>%
  arrange(air_time) %>%
  summarise(mean(air_time), min(air_time))
#now compare individual flights to the mean air times
flights %>%
  filter(!is.na(air_time)) %>%
  group_by(dest, origin) %>%
  arrange(air_time) %>%
  mutate(quickest = min(air_time), quick_diff = air_time - quickest, mean_air = mean(air_time)) %>%
  arrange(desc(quick_diff)) %>%
  group_by(dest, origin, mean_air) %>%
  summarise(q_flight = quantile(quickest, 0.01)) %>%
  arrange(desc(mean_air - q_flight))
#now we have a tibble with the most "questionable" air times at the top

#7
#Find all destinations that are flown by at least two carriers. Use that information to rank the carriers.
  flights %>%
  group_by(dest) %>%
  filter(!is.na(dep_delay)) %>%
  filter(n_distinct(carrier) > 1) %>%
  group_by(carrier) %>%
  summarise(n_dest = n_distinct(dest)) %>%
  mutate(carrier_rank = min_rank(desc(n_dest)))

#8
#For each plane, count the number of flights before the first delay of greater than 1 hour.
flights %>%
  group_by(tailnum) %>%
  arrange(year, month, day) %>%   #cannot group by date but can arrange by it
  filter(!cumany(dep_delay >60)) %>%  #found cumany() on a google search. this command looks for the first instance of a particular set of criteria and returns true thereafter... using a ! gives us a filter of everything before that
  summarise(flights_prior = n()) %>%
  arrange(desc(flights_prior))

#in theory, this could be accomplished with ranking and filtering too!

####################################################################################################
#chapter 27
####################################################################################################

#27.1

#R Markdown is for collaboration, communication, and as a modern day lab notebook

#? will not help much with markdown
#instead use R markdown cheatsheet and reference guide

#make sure to have rmarkdown package!

#27.2

#R markdown has extension .rmd

#RMD has 3 types of content
#1. optional YAML header surrounded by ---
#2. chunks of R code surrounded by '''
#3. text mixed with simple text formatting

#when opening an RMD, can run code chunks
#can also use knit to do a complete report (cmd + shift + k)
#can also do rmarkdown::render("filename.rmd") as well
#knitting uses knitr to show code, output, and rest of RMD

#exercises 27.2.1

#1

#play around with RMD instructions in an R notebook and running included intro code, with some modifications
#some notes: running with command + return is trickier
#using command + option + ` will run the next chunk
#adding shift to the usual run code command will run the current chunk
# command + option + p will run all chunks above the current position
#`` will recognize the inside as code
#command + option + I will get you a new code chunk
#can run preview, just like knitr command, though it uses the last code executed to show output

#2

#knitting my modifications to the original RMD example code
#file is called test.Rmd

#3

#Some differences between markdown and notebook:

#Notebook can conveniently hide or show code chunks. RMD does not. They have slightly different save files: .nb.html and .html
#For the most part, they contain similar content (the three main types of content: code/output, text, and header)
#The headers seem compatible!

#4
#Markdown in a PDF uses a slightly different format. There are no boxes around output, the boxes for input are subdued in contrast (not for snippets embedded in non-code text),
#and a serif font is used for non-code text. Links are not colored blue. Colors of input text are coded similarly to in Rstudio, albeit with a different palette.
#For word (.docx), a single box surrounds input/output code that is subtly shaded grey (little snippets in non-code text are not bordered). Non-code text is serifed for body text and
#sans serif for section titles, which are also colored various shades of blue. Links are also coded blue, as in html. Input text color is the same as pdf format.
#Note: HTML resembles word, but with less coloration of text and contains specific input and output colored boxes.

