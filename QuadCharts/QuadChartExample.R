# Loads the required packages
library(tidyverse)
library(BBmisc)
library(readxl)

# 
for (i in 2010:2017) {
	combine.data.year <-
		read_excel(
			path = "./Data/CombineData.xlsx",
			sheet = as.character(i)
		) %>%
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

	ifelse(
		 i == 2010
		, combine.data <- combine.data.year
		, combine.data <- rbind(combine.data, combine.data.year)
	)
}