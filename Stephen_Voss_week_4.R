# Stephen Voss - Data Science Accelerator Week 2
# R for Data Science, Chapters 4 and 5.1-5.4 - http://r4ds.had.co.nz/

# Chapter 20.3.5
     # Describe the difference between is.finite(x) and !is.infinite(x).
     # ANSWER: THEY RETURN THE SAME VALUE
     
     # Read the source code for dplyr::near() (Hint: to see the source code, drop the ()). How does it work?
      # ANSWER: It takes in to vectors to compare and checks to see if they equate to within a similar range. If so, then it returns that they are equal
       
       # A logical vector can take 3 possible values. How many possible values can an integer vector take? How many possible values can a double take? Use google to do some research.
       # ANSWER: Integer Vector = +/-2*10^9; double vector = 2e-308 to 2e+308
     
     # Brainstorm at least four functions that allow you to convert a double to an integer. How do they differ? Be precise.
     #ANSWER: 
     
# Chapter 20.4.6
  # What does mean(is.na(x)) tell you about a vector x? What about sum(!is.finite(x))?
    # Tells you if any NAs exist.
    # Similar to integrate()

  # Carefully read the documentation of is.vector(). What does it actually test for? Why does is.atomic() not agree with the definition of atomic vectors above?
    # tests if it a vector at all (not concerned with type). is.atomic does not treat lists as a vector
  
  # Compare and contrast setNames() with purrr::set_names().
    # Both set names of vector data
    # The purrr library, however, does not necessarily require a vector of names and can accept predefined variables as well as determine undefined names using the vector itself

  # Create functions that take a vector as input and returns:
  
    # The last value. Should you use [ or [[?

    function(x) {
      x[end(x)[1]]
    }
      
    # The elements at even numbered positions.
    
    function(x) {
      x[seq(1,length(x),2)]
    }
    
    # Every element except the last value.
    function(x) {
      head(x,-1)
      return (x)
    }
    
    # Only even numbers (and no missing values).
    function(x) {
      x[x %% 2 == 0]
    }
    
    # Why is x[-which(x > 0)] not the same as x[x <= 0]?
    # ASNWER: which will only accept logical values as arguments
                                          
    # What happens when you subset with a positive integer that’s bigger than the length of the vector? What happens when you subset with a name that doesn’t exist?
    # ANSWER: it returns a vector with missing values
    # An NA is returned
     
# Chapter 20.5.4
    # Draw the following lists as nested sets:
    list(a, b, list(c, d), list(e, f))
    
    list(list(list(list(list(list(a))))))
    
    #What happens if you subset a tibble as if you’re subsetting a list? What are the key differences between a list and a tibble?
     # ANSWER: tibbles are lists
    
# Chapter 21.2.1
    # Compute the mean of every column in mtcars.
      for (x in mtcars) {
        avg <- mean(mtcars)
      }
    # Determine the type of each column in nycflights13::flights.
    for (x in nycflights13$flights) {
      var_type <- typeof(x)
    }
    # Compute the number of unique values in each column of iris.
    t=test[1,1]
    count=1
    for(i in iris)
    {
      if(test[i,1]!=t)
      {
        count=count+1
        t=test[i,1]
      }
    }
     
# Chapter 21.3.5
    # Imagine you have a directory full of CSV files that you want to read in. You have their paths in a vector, files <- dir("data/", pattern = "\\.csv$", full.names = TRUE), and now want to read each one with read_csv(). Write the for loop that will load them into a single data frame.
    for (x in files) {
      all.the.data <- lapply(x,  read.csv, header=TRUE)
      DATA <- do.call("rbind", all.the.data)
    }
    # What happens if you use for (nm in names(x)) and x has no names? What if only some of the elements are named? What if the names are not unique?
    # ANSWER: it will return NA. some will return NA. they will be overridden
      
    # Write a function that prints the mean of each numeric column in a data frame, along with its name. For example, show_mean(iris) would print:
    function (x) {
      map_dbl(x, mean)
    }
# Chapter 21.5.3
    # Write code that uses one of the map functions to:
      # Compute the mean of every column in mtcars.
        map_dbl(df, mean)
      # Determine the type of each column in nycflights13::flights.
        df <- nycflights13::flights
        Map(`[`, list(names(df)), split(col(df)[df != 0],
                                        row(df)[df != 0]))
      # Compute the number of unique values in each column of iris.
        # I have no clue how to do this.
     