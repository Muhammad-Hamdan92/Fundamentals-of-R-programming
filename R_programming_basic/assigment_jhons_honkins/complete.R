complete <- function(directory, id = 1:332) {
  ids  <- c()         ##creating the empty vector to store the results.....
  nobs <- c()
  
  for (i in id) {
    filepath <- file.path(directory, sprintf("%03d.csv", i))  # build file path
    data     <- read.csv(filepath)                            # read the file
    
    ids  <- c(ids, i)                                        # store monitor id
    nobs <- c(nobs, sum(complete.cases(data)))               # count complete rows
  }
  
  data.frame(id = ids, nobs = nobs)                          # return as dataframe
}

# complete cases for selected monitors
cc <- complete("specdata/specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

# complete cases for monitor 54
cc <- complete("specdata/specdata", 54)
print(cc$nobs)

