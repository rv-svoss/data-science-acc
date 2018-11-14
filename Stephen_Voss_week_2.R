# Stephen Voss - Data Science Accelerator Week 2
# R for Data Science, Chapters 4 and 5.1-5.4 - http://r4ds.had.co.nz/

# Chapter 4.4 Questions

# Question #1
my_variable <- 10
# my_varıable
# > Error in eval(expr, envir, enclos): object 'my_varıable' not found

# ANSWER: Does not work because when printing the object, 'i' is replaced with 'ı'.
my_variable

# Question #2
# Tweak each of the following R commands so that they run correctly

# ANSWER: If you run this code and get the error message “there is no package called ‘tidyverse’”,
# you’ll need to first install it, then run library() once again.
install.packages("tidyverse")
library(tidyverse)

# ANSWER: The library must be included using 'library()' after the package has been installed
library(ggplot2)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

# ANSWER: After fixing the spelling error (fliter -> filter), the variables mpg
# and cyl need to be pulled out from the mtcars object
filter(mtcars$mpg, mtcars$cyl == 8)

# ANSER: The library 'diamonds' was missing an 's'. The second argument was not being parsed from the diamonds dataset using the '$'.
filter(diamonds, diamonds$carat > 3)
# https://ggplot2.tidyverse.org/reference/diamonds.html

# Chapter 5.2.4
library(nycflights13)
library(tidyverse)
print(nycflights13::flights)
# Find all flights that:
data <- nycflights13::flights
  # Had an arrival delay of two or more hours
  filter(data, data$dep_delay >= 2)
  
  # Flew to Houston (IAH or HOU)
  filter(data, data$dest %in% c('IAH', 'HOU'))
  
  # Were operated by United, American, or Delta
  filter(data, data$carrier %in% c('United', 'American', 'Delta'))
  
  # Departed in summer (July, August, and September)
  filter(data, data$month == 7 | data$month == 8 | data$month == 9)
  
  # Arrived more than two hours late, but didn’t leave late
  filter(data, data$dep_delay == 0 & data$arr_delay > 2)
  
  # Were delayed by at least an hour, but made up over 30 minutes in flight
  flight_time <- data$sched_arr_time - data$sched_dep_time
  filter(data, (data$dep_delay > 1 | data$arr_delay > 1) & flight_time - data$flight <= -30)
  
  # Departed between midnight and 6am (inclusive)
  filter(data, data$dep_time >= 000 & data$dep_time <= 600)
  
# Another useful dplyr filtering helper is between(). What does it do? Can you use it to simplify the code needed to answer the previous challenges?
  # The between function is a shortcut for the x >= 7 and x <= y or the inverse
  filter(data, between(data$dep_time, 000, 600))
  # https://www.rdocumentation.org/packages/dplyr/versions/0.7.7/topics/between

# How many flights have a missing dep_time? What other variables are missing? What might these rows represent?
  filter(data, is.na(data$dep_time))
  # Other missing values are delay times and arrival times. This would indicate the flight was cancelled altogether.
  # https://www.rdocumentation.org/packages/base/versions/3.5.1/topics/NA

# Why is NA ^ 0 not missing? 
  # ANSWER: Because anything to the power of 0 is 1

# Why is NA | TRUE not missing?
  # ANSWER: Because it is a logical constant with a length of 1

# Why is FALSE & NA not missing? Can you figure out the general rule? (NA * 0 is a tricky counterexample!)
    # ANSWER: Because 0 and 1 returns FALSE. General rule is NA has a length of 1 when being used in comparisons but as an integer
    # does not represent a value and therefore no mathematical formulas may be used because a value is not known.
  
# Chapter 5.3.1
# How could you use arrange() to sort all missing values to the start? (Hint: use is.na()).
  arrange(data, desc(is.na(data)))
  # https://www.rdocumentation.org/packages/dplyr/versions/0.7.7/topics/arrange
# Sort flights to find the most delayed flights. Find the flights that left earliest.
  most_delays <- arrange(data, desc(data$sched_arr_time - data$arr_time))
  earliest <- arrange(data, desc(data$dep_time))
# Sort flights to find the fastest flights.
  fastest <- arrange(data, desc(data$air_time))
# Which flights travelled the longest? Which travelled the shortest?
  longest <- arrange(data, data$distance)
  shortest <- arrange(data, desc(data$distance))
 
# Chapter 5.4.1
# What happens if you include the name of a variable multiple times in a select() call?
  # ANSWER: The reoccurances are ignored. Ex: select(data, year, year)

# What does the one_of() function do? Why might it be helpful in conjunction with this vector?
 # ANSWER: Is used to easily select columns that are contained within an already declared vector
 
# Does the result of running the following code surprise you? How do the select helpers deal with case by default? How can you change that default?
 select(flights, contains("TIME"))
 # https://dplyr.tidyverse.org/reference/select_helpers.html
 # No because it selects any columns with a header containing the string 'TIME')
 # By default, heplers are case insisitive but to change that one can pass in an argument like so: ignore.case = FALSE (default is TRUE)