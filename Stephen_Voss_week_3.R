# Stephen Voss - Data Science Accelerator Week 2
# R for Data Science, Chapters 4 and 5.1-5.4 - http://r4ds.had.co.nz/

# Chapter 5.5.2
 # Currently dep_time and sched_dep_time are convenient to look at, but hard to compute with because they’re not really continuous numbers. Convert them to a more convenient representation of number of minutes since midnight.
 transmute(flights, 
           dep_time = (dep_time * 60) - 000,
           sched_dep_time = (sched_dep_time * 60) - 000)
 # Compare air_time with arr_time - dep_time. What do you expect to see? What do you see? What do you need to do to fix it?
   flights$air_time == (flights$arr_time - flights$dep_time)
   # I expect to see a list of TRUE or FALSE values. Instead I see NAs scattered throughout. To remove them, I will need to also use a filter function

   # Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?
   flights$dep_time == flights$sched_dep_time # Expect to evaluate TRUE
   flights$dep_time == flights$dep_delay # Expect to evaluate FALSE
   flights$sched_dep_time == flights$dep_delay # Expect to evaluate FALSE
  
   # Find the 10 most delayed flights using a ranking function. How do you want to handle ties? Carefully read the documentation for min_rank().
   rank(data$sched_arr_time - data$arr_time, ties.method = "min")
 # What does 1:3 + 1:10 return? Why?
   # return 'longer object length is not a multiple of shorter object length' because R is unable to use 'recycling' because they are not multiples

# Chapter 5.6.7
   
   # Come up with another approach that will give you the same output as not_cancelled %>% count(dest) and not_cancelled %>% count(tailnum, wt = distance) (without using count()).
   not_cancelled <- filter(data, !is.na(arr_delay) | !is.na(dep_delay))
   not_cancelled %>% 
     group_by(dest) %>% 
     summarise(carriers = n_distinct(carrier))
   # Our definition of cancelled flights (is.na(dep_delay) | is.na(arr_delay) ) is slightly suboptimal. Why? Which is the most important column?
     # ANSWER: The first check should be is.na(arr_delay) because if this is NA then the flight was definitely cancelled. As it stands now, the flight may have just left late
     # and was unable to make up time before landing or was rerouted unexpectedly mid-flight before making it to its destination.
     
     # Look at the number of cancelled flights per day. Is there a pattern? Is the proportion of cancelled flights related to the average delay?
     total_delays <- data %>% group_by(month, day) %>% summarise(total_cancelled = sum(is.na(dep_delay)) + sum(is.na(arr_delay)))
     # ANSWER: More cancellations occur around the holidays which is proportional to the average delay
     
     # Which carrier has the worst delays? Challenge: can you disentangle the effects of bad airports vs. bad carriers? Why/why not? (Hint: think about flights %>% group_by(carrier, dest) %>% summarise(n()))
     # ANSWER: The carrier with the worst delays is UA. If you also group_by origin and summarize dep_delay times, you should be able to disintangle those effects.
     
   # What does the sort argument to count() do. When might you use it?
     # ANSWER: It would sort based on the total count of a given variable. Use it when you want to get a rough idea of volume or to ensure
     # that your data sets do not include outliers
     
# Chapter 5.7.1
     
     # Refer back to the lists of useful mutate and filtering functions. Describe how each operation changes when you combine it with grouping.
     #ANSWER: These functions change by being applied to the group as a whole and are referred to as window functions.
     
     # Which plane (tailnum) has the worst on-time record?
     (worst_record <- data %>% group_by(tailnum) %>% filter(abs(arr_time - sched_arr_time) > 2398))
     # ANSWER: N258JB has the worst on-time record.
       
       # What time of day should you fly if you want to avoid delays as much as possible?
       data$total_delay <- (abs(data$dep_delay - data$sched_dep_time) + abs(data$arr_delay - data$sched_arr_time)) * -1
       ( arrange(data, desc(data$total_delay)) )
       
       time_to_fly <- data %>% na.omit() %>% group_by(hour) %>% summarize(mean(total_delay))
       best_time <- ( arrange(time_to_fly) )
       
       # 4AM is the best time to fly
       
       # For each destination, compute the total minutes of delay. For each flight, compute the proportion of the total delay for its destination.
       destination_delay <- data %>% na.omit() %>% group_by(dest) %>% summarize(delay = sum(total_delay))
       flight_delay <- data %>% na.omit() %>% group_by(tailnum) %>% summarize(ratio = sum(total_delay)) # How do you dynamically pull a specific flights total delay based on the calc above?
     
     # Delays are typically temporally correlated: even once the problem that caused the initial delay has been resolved, later flights are delayed to allow earlier flights to leave. Using lag(), explore how the delay of a flight is related to the delay of the immediately preceding flight.
       # How do we target a specific flight for it's specific delay?
     
     # Look at each destination. Can you find flights that are suspiciously fast? (i.e. flights that represent a potential data entry error). Compute the air time a flight relative to the shortest flight to that destination. Which flights were most delayed in the air?
       
       # Find all destinations that are flown by at least two carriers. Use that information to rank the carriers.
     
     # For each plane, count the number of flights before the first delay of greater than 1 hour.
     
# Chapter 19.3.1
     # Read the source code for each of the following three functions, puzzle out what they do, and then brainstorm better names.
     
     is_prefix <- function(string, prefix) {
       substr(string, 1, nchar(prefix)) == prefix
     }
     has_length <- function(x) {
       if (length(x) <= 1) return(NULL)
       x[-length(x)]
     }
     cut_value <- function(x, y) {
       rep(y, length.out = length(x))
     }

     # Take a function that you’ve written recently and spend 5 minutes brainstorming a better name for it and its arguments.
       # Yup...did that.
     
     # Compare and contrast rnorm() and MASS::mvrnorm(). How could you make them more consistent?
        # Both calculate variances, however, rnorm uses univariate while mvrnorm uses multivariate draws
       
       # Make a case for why norm_r(), norm_d() etc would be better than rnorm(), dnorm(). Make a case for the opposite.
        # Better because norm_d indicates the function performs normal distribution (first) before describing the type
        # It is extra characters to type out
     
# Chapter 19.4.4
     # What’s the difference between if and ifelse()? Carefully read the help and construct three examples that illustrate the key differences.
     # ANSWER: Use if for variables of length of 1 and use ifelse for vectors with a length > 1
     if(add_suffix("Hello"))
     ifelse(add_suffix(c("Hello", "Hi There")), "Yes", "No")
     if (add_suffix("hello")) {
       print("hi")
     } else {
       print("Bye")
     }
     # Write a greeting function that says “good morning”, “good afternoon”, or “good evening”, depending on the time of day. (Hint: use a time argument that defaults to lubridate::now(). That will make it easier to test your function.)
     greeting_by_time <- function() {
       current_time <- lubridate::now()
       if (current_time < "2018-11-13 9:00:00 EST") { print("good morning") }
       else if (current_time >= "2018-11-13 9:00:01 EST" | current_time <= "2018-11-13 15:00:00 EST") { print("good afternoon") }
       else if (current_time > "2018-11-13 15:00:00 EST") { print("good evening") }
       else (print("Error!"))
       }
     
     # Implement a fizzbuzz function. It takes a single number as input. If the number is divisible by three, it returns “fizz”. If it’s divisible by five it returns “buzz”. If it’s divisible by three and five, it returns “fizzbuzz”. Otherwise, it returns the number. Make sure you first write working code before you create the function.
     fizzbuzz <- function(x) {
       for (i in 1:100) {
       if (i %% 3 == 0 & i %% 5 == 0) {print("FizzBuzz")}
       else if (i %% 3 == 0) {print("Fizz")}
       else if (i %% 5 == 0) {print("Buzz")}
       else print(i)
       }
     }
     
     # How could you use cut() to simplify this set of nested if-else statements?
       if (temp <= 0) {
         "freezing"
       } else if (temp <= 10) {
         "cold"
       } else if (temp <= 20) {
         "cool"
       } else if (temp <= 30) {
         "warm"
       } else {
         "hot"
       }
     # ANSWER:
     cut(temp, break = c(10, 20, 30))
     # How would you change the call to cut() if I’d used < instead of <=? What is the other chief advantage of cut() for this problem? (Hint: what happens if you have many values in temp?)
     cut(temp, break = c(10, 20, 30), right=TRUE)
     # What happens if you use switch() with numeric values?
       # ANSWER: The following argument would be evaluated
     
       # What does this switch() call do? What happens if x is “e”?
       
       switch(x, 
              a = ,
              b = "ab",
              c = ,
              d = "cd"
       )
     # ANSWER: Chooses the numeric value returned by the value of x being passed in.
     # 'e' would return the last, or default, case which is "cd"