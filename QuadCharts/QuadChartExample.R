# Loads the required packages
library(tidyverse)
library(BBmisc) # A package that contains a function that enables us to normalize our data
library(readxl) # A tidyverse package that enables you to read Excel data

# Iterates through each sheet from 2010 to 2017 and combines the data
# into one data set called "combine.data". Below is an example of what 
# is called a "workflow". We are able to use the "%>%" operator from 
# magritr package that is part of tidyverse along with the readxl package
# to create the workflow. Take a note of how succint and readable the code
# is! 
for (i in 2010:2017) {
	combine.data.year <-
	    # Gets the combine data for the given year based
		# on the value of i
		read_excel(
			path = "./Data/CombineData.xlsx",
			sheet = as.character(i)
		) %>%
	    # Use the "normalize" function from the "BBmisc" package to put the
		# 40 yard dash times and benchpress reps on the same scale
		mutate(
			 Scaled.40YD =
				round(
					normalize(
						 `40YD` * -1
						, method = "range"
						, range = c(-10, 10)
					)
				, 1)
			, Scaled.BenchReps =
				round(
					normalize(
						`BenchReps`
						, method = "range"
						, range = c(-10, 10)
					)
				, 1)
		)
	# Puts the dataframe created above into one master dataframe named
	# "combine.data". If "i" equals 2010 we know that we are on our first
	# worksheet so we create the "combine.data" dataframe based on that
	# dataframe. For the subsequent sheets we combine each year's dataframe
	# with the "combine.data" dataframe.
	ifelse(
			i == 2010
		, combine.data <- combine.data.year
		, combine.data <- rbind(combine.data, combine.data.year)
	)

}