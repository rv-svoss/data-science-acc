# Using the mtcars dataset (this is already installed automatically with R) complete a script that
# assigns values to the following 5 variables.
# The following is a data dictionary to help explain the variables contained in the mtcars dataset:
# http://rstudio-pubs-static.s3.amazonaws.com/61800_faea93548c6b49cc91cd0c5ef5059894.html

# Stephen Voss - Data Science Accelerator Assignment 1 

# Create a variable called myName with a character string containing your name.
myName <- 'Stephen Voss'
myName

# Create a variable called mtcarsColumns that contains a character vector of the column names from `mtcars`.
mtcarsColumns <- c('#', 'Var', 'Description', 'Comments')
mtcarsColumns

# Create a variable called mtcarsSummary that contains a summary table of the dataset mtcars
mtcarsSummary <- summary(mtcars)
mtcarsSummary

# Create a variable called dratValue that contains the decimal value of the drat(Rear axle ratio)
# column for the only car that has 6 cylinders and greater than 21 mpg.
dratValue <- subset(mtcars, cyl==6 & mpg > 21, select=c(name, drat))
dratValue

# Create a variable called topQsec that orders the mtcars dataframe by Qsec in descending order
# and then grab the top 6 rows from that data frame. topQsec should be of type data frame with 
# 6 rows and 11 columns.
topQsec <- order(-mtcars$qsec)
mtcars[topQsec, ]
