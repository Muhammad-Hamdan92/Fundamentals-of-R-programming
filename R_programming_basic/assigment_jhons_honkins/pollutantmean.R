source("pollutant.R")
pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  all_values <- c()                                    # empty vector to store values
  
  for (i in id) {
    filepath <- file.path(directory, sprintf("%03d.csv", i))  # build file path
    data <- read.csv(filepath)                         # read the file
    all_values <- c(all_values, data[[pollutant]])     # collect pollutant values
  }
  
  mean(all_values, na.rm = TRUE)                       # return mean, ignoring NAs
}

# Examples
pollutantmean("specdata/specdata", "sulfate", 1:10)
pollutantmean("specdata/specdata", "nitrate", 70:72)
pollutantmean("specdata/specdata", "sulfate", 34)
pollutantmean("specdata/specdata", "nitrate")

