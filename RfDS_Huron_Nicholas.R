#Nick Huron
#R: Quantitative Science to Solve Global Problems
#RfDS_Huron_Nicholas_v3_0.R

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
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = class, y = cty))
#vs.
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = class, y = cty, fill = drv))
#the default position for geom_boxplot is dodge! sweet

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