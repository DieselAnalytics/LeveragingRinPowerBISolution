# Loads required packages
library(tidyverse)

# Reads in Model and data
model <- readRDS("./Model/Model.rds")
dataset <- read_csv("./Data/testing_rawdata.csv")

# The following variables will be used by the "cut" function to define 
# the income categories
breaks <- c(0, 50000, 100000, 170001)
labels <- c("[0 - 50000)", "[50000 - 100000)", "[100000 - 170001)")

# Feature engineering and scoring. R code is relatively very human readable 
# compared to many other programming languages so the feature engineering below 
# are self-describable
ScoredData <-
	dataset %>%
	transmute(
			key = CustomerKey
		  , MaritalStatus
		  , HS_Grad = ifelse(Education == "Partial High School", "N", "Y")
		  , HouseOwnerFlag = as.character(HouseOwnerFlag)
		  , income_ranges = cut(YearlyIncome, breaks, labels = labels)
		  , HasKids = ifelse(NumberChildrenAtHome == 0, "N", "Y")
		  , OwnMultipleCars = ifelse(NumberCarsOwned > 1, "Y", "N")
		  , CommuteDistance =
			 ifelse(CommuteDistance %in% c("0-1 Miles", "1-2 Miles", "2-5 Miles"), "0-5 Miles",
					CommuteDistance)
		  , BikeBuyer
	) %>%
    # The qualitative variables needs to be of the factor data type. All of our
    # qualitative variables have a "character" data type so the "mutate_if" 
    # function loops through all of the columns in the dataframe and converts 
	# them to a factor.
	mutate_if(is.character, as.factor) %>%
	mutate(pred = predict(model, newdata = ., type = 'response'))