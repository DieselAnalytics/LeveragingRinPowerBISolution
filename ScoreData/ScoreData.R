# Loads required packages
library(tidyverse)

# Reads in Model and data
model <- readRDS("./Model/Model.rds")
dataset <- read_csv("./Data/testing_rawdata.csv")

# Define income categories
breaks <- c(0, 50000, 100000, 170001)
labels <- c("[0 - 50000)", "[50000 - 100000)", "[100000 - 170001)")

# Feature engineering and scoring
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
	mutate_if(is.character, as.factor) %>%
	mutate(pred = predict(model, newdata = ., type = 'response'))