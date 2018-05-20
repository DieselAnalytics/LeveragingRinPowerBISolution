# Loads the required packages
library(tidyverse)

# Loads the data 
dataset <- read_csv("./Data/NYCTaxiCabTrips.csv")

# Custom function that calculates distance between to geographical points using
# the Haversine formula
ComputeDist <-
  function(pickup_long, pickup_lat, dropoff_long, dropoff_lat) {

	R <- 6371 / 1.609344 #radius in mile
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
