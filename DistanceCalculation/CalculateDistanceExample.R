# Loads the required packages
library(tidyverse)

# Loads the data using the read_csv package from tidyverse. Make sure you
# have your working directory set to the "DistnaceCalculation" project. You
# can do so using the following steps: select the project in the Solution Explorer >
# right click > select "Set Working Directory Here"
dataset <- read_csv("./Data/NYCTaxiCabTrips.csv")

# Custom function that calculates distance between to geographical points using
# the Haversine formula. Take a moment to think about how complicated the 
# code would be do implement this function in Power Query. Also consider the
# performance of R. Many functions in R are vectorized. In layman's terms that
# basically means that it acts on all of the data at once instead of looping
# over it in an iterative process like what is done in Power Query. Performance
# is normally better when your calculations are vectorized as is our "ComputeDist"
# function is below when applied to our "TaxiData" dataframe.
ComputeDist <-
  function(pickup_long, pickup_lat, dropoff_long, dropoff_lat) {

	R <- 6371 / 1.609344 #radius of the earth in mile
	delta_lat <- dropoff_lat - pickup_lat
	delta_long <- dropoff_long - pickup_long
	degrees_to_radians = pi / 180.0
	a1 <- sin(delta_lat / 2 * degrees_to_radians)
	a2 <- as.numeric(a1) ^ 2
	a3 <- cos(pickup_lat * degrees_to_radians)
	a4 <- cos(dropoff_lat * degrees_to_radians)
	a5 <- sin(delta_long / 2 * degrees_to_radians)
	a6 <- as.numeric(a5) ^ 2
	a <- a2 + a3 * a4 * a6
	c <- 2 * atan2(sqrt(a), sqrt(1 - a))
	d <- R * c
	return(d)
  }

# Adds a calculated column that contains the distances in miles of each trip
# using the "ComputeDist" function and the mutate verb from dplyr. The mutate
# verb enables you to project or add calculated columns to your dataframe.
TaxiData <- dataset %>%
	mutate(
			 `Trip Distance` =
				round(
					ComputeDist(
						pickup_long,
						pickup_lat,
						dropoff_long,
						dropoff_lat
					)
				, 1)
	)
