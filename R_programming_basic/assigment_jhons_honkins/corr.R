source("corr.R")        # load corr function from corr.R
source("complete.R")    # load complete function from complete.R

corr <- function(directory, threshold = 0) {
  
  file_list    <- list.files(directory, full.names = TRUE)  # get all CSV file paths
  correlations <- numeric()                                  # empty vector for results
  
  for (file in file_list) {
    data           <- read.csv(file)                        # read each file
    complete_cases <- data[complete.cases(data), ]          # keep only rows with no NAs
    
    if (nrow(complete_cases) > threshold) {                 # skip if below threshold
      cor_val      <- cor(complete_cases$sulfate, complete_cases$nitrate)  # calc correlation
      correlations <- c(correlations, cor_val)              # append result
    }
  }
  
  return(correlations)                                      # return all correlations
}

# ── Test 1 ──────────────────────────────────────────────────
RNGversion("3.5.1")          # use R 3.5.1 random number generator for reproducibility
set.seed(42)                 # fix random seed so sample() gives same result every time
cc  <- complete("specdata/specdata", 332:1)   # get complete cases for all monitors (reversed)
use <- sample(332, 10)                        # randomly pick 10 monitor indices
print(cc[use, "nobs"])                        # print their complete case counts

# ── Test 2 ──────────────────────────────────────────────────
cr  <- corr("specdata/specdata")              # get correlations with no threshold
cr  <- sort(cr)                               # sort correlations ascending
RNGversion("3.5.1")
set.seed(868)
out <- round(cr[sample(length(cr), 5)], 4)   # pick 5 random correlations, round to 4 decimals
print(out)

# ── Test 3 ──────────────────────────────────────────────────
cr  <- corr("specdata/specdata", 129)         # only monitors with >129 complete cases
cr  <- sort(cr)
n   <- length(cr)                             # count how many passed the threshold
RNGversion("3.5.1")
set.seed(197)
out <- c(n, round(cr[sample(n, 5)], 4))      # combine count + 5 random correlations
print(out)

# ── Test 4 ──────────────────────────────────────────────────
cr  <- corr("specdata/specdata", 2000)        # threshold=2000 (very few monitors qualify)
n   <- length(cr)                             # count results (likely 0)
cr  <- corr("specdata/specdata", 1000)        # threshold=1000 (more monitors qualify)
cr  <- sort(cr)
print(c(n, round(cr, 4)))                     # print count from 2000 + sorted results from 1000

