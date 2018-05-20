# Loads required packages
library(data.table)
library(tidyverse)

#Get a list of files in the BLS folder
bls_files <- list.files(path = "./Data/")

# We use "negative lookaheads" in the reqular expression below because it allows us to  
# match a string that is not followed by a string that we do not want.
grep("la\\.data\\.\\d+\\.(?!((Current.*)|(All.*)|(Region.*)|(County)|(Micro)|(City)|(Combined)|(Metro)|(Division)))", bls_files, value = T, perl = T)

#Stores the files in a character vector and concatenates the beginning part of the file path to each file 
bls_files <- grep("la\\.data\\.\\d+\\.(?!((Current.*)|(All.*)|(Region.*)|(County)|(Micro)|(City)|(Combined)|(Metro)|(Division)))", bls_files, value = T, perl = T)

#Combines all of the files that represents a state into a list 
cc <- c("character", "character", "character", "character", "character")
bls_data <- map(file.path("./Data/", bls_files), fread, colClasses = cc) %>%
	rbindlist() %>%
	as_tibble()