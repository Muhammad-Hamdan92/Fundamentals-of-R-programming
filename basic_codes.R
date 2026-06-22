# =============================================================
#  R Basics: Objects, Data Types, and Subsetting
#  Author  : [Muhammad Hamdan]
#  Purpose : A reproducible reference script covering core R
#            concepts — ideal for beginners and quick revision.
# =============================================================


# ---- 0. WORKSPACE SETUP -------------------------------------

getwd()       # Returns the current working directory path — always verify before starting a project

dir()         # Lists all files present in the current working directory


# ---- 1. VARIABLES & BASIC CLASSES ---------------------------

# Use <- for assignment instead of = to avoid confusion with function argument syntax
x <- 1:5
print(x)      # Explicitly prints the value of x to the console

x             # Typing a variable name alone also prints it (same as print())

# R has 5 core atomic classes — check any object's class with class()
x <- c(2, 4, 5);     class(x)   # numeric  — decimal numbers
x <- c("a", "b");    class(x)   # character — text strings (quotes force this)
xy <- c("1", "2");   class(xy)  # character — numbers inside quotes become character
x <- 1:17;           class(x)   # integer  — sequences and values suffixed with L (e.g. 1L) are integer
x <- c(T, F);        class(x)   # logical  — TRUE / FALSE values
x <- c(1+0i, 2+0i); class(x)   # complex  — real + imaginary numbers

ls()   # Lists all objects (variables, functions, etc.) currently saved in the workspace


# ---- 2. DATA TYPES ------------------------------------------

# --- 2a. Vectors ---
# Vectors are 1-dimensional collections of elements of the SAME class.
# Create them with c() (combine) or vector().

x <- c(3, 8)           # numeric vector
x <- c(TRUE, FALSE)    # logical vector — spelled out
x <- c(T, F)           # logical vector — shorthand (T = TRUE, F = FALSE)
x <- c("a", "b", "c") # character vector
x <- 9:20              # integer sequence from 9 to 20
x <- c(6+0i, 2+0i)    # complex vector

x <- vector("numeric", 7)   # Pre-allocates a numeric vector of length 7, filled with 0s by default
x

# Implicit coercion — R silently converts to the most flexible class when types are mixed
x <- c(1, "a")      # numeric + character → all become character
class(x)
x <- c(TRUE, 3)     # logical + numeric  → TRUE becomes 1, all become numeric
class(x)
x <- c(TRUE, 0)     # logical + numeric  → TRUE = 1, FALSE = 0, result is numeric
class(x)

# Explicit coercion — manually convert between classes using as.*() functions
x <- 0:9
class(x)
as.numeric(x)       # Converts integer sequence to numeric (decimals allowed)
as.logical(x)       # 0 → FALSE, any non-zero → TRUE
as.character(x)     # Each number becomes a quoted string: "0", "1", ...

# DANGER 1: Coercion fails silently — non-convertible values become NA
x <- c("1", "2", "apple")
as.numeric(x)       # "apple" cannot be numeric → returns NA with a warning

# DANGER 2: Factor-to-numeric trap — converts factor levels (internal integers), NOT the labels
weights <- factor(c("70", "85", "90", "70", "60", "30"))
as.double(weights)  # Returns 1, 2, 3... (level indices), NOT 70, 85, 90 — this is a common bug!

# SOLUTION: Convert factor → character → numeric to get the actual values
x <- as.character(weights)
as.numeric(x)       # Now correctly returns 70, 85, 90, 70, 60, 30

attributes(x)       # Shows metadata attached to an object (e.g. names, dim, class); NULL if none


# --- 2b. Lists ---
# Lists are 1-dimensional but can hold elements of DIFFERENT classes.

l <- list(1, "a", TRUE, 1+0i)    # A single list containing numeric, character, logical, complex
l

names(l) <- c("numeric", "character", "logical", "complex")  # Assign names to list elements
l

l <- vector("list", length = 7)   # Creates an empty list of 7 NULL elements
l

# Named list with vectors of different types as elements
l <- list(
  character = c("a", "b", "c", "d"),
  numeric   = c(1, 2, 3, 4),
  logical   = c(T, F)
)
l

attributes(l)   # Returns the names attribute of the list


# --- 2c. Matrices ---
# Matrices are 2-dimensional arrays where ALL elements must be of the SAME class.
# Elements are filled column-by-column by default.

m <- matrix(nrow = 2, ncol = 3)          # Creates a 2×3 matrix filled with NA (no data provided)
m

m <- matrix(1:8, nrow = 2, ncol = 4)    # Fills 8 values column-by-column into a 2×4 matrix
m

m <- matrix(1:8, byrow = TRUE, nrow = 4) # byrow = TRUE fills values row-by-row instead
m

# Binding vectors into a matrix using cbind() and rbind()
x <- 2:7
y <- 3:8
m <- cbind(x, y)    # cbind() joins vectors as columns; rbind() would join them as rows
m

# Converting a vector into a matrix by setting its dim attribute
m <- 1:16
dim(m) <- c(4, 4)   # Assigns 4 rows and 4 columns; R fills values column-by-column
m

# Naming rows and columns individually
rownames(m) <- c("a", "b", "c", "d")   # Assigns labels to each row
colnames(m) <- c("e", "f", "g", "h")   # Assigns labels to each column
m

# Naming rows and columns together using dimnames() with a list
dimnames(m) <- list(
  c("e", "f", "g", "h"),   # Row names (first element of list)
  c("a", "b", "c", "d")    # Column names (second element of list)
)
m

attributes(m)   # Shows dim, dimnames (row & column names) of the matrix


# --- 2d. Factors ---
# Factors represent categorical data and store values as integer codes with labels (levels).
# Levels are sorted alphabetically by default.

f <- factor(c("Male", "Female"))
f <- factor(c("yes", "yes", "no", "yes", "no"))

levels(f)    # Shows the unique categories, sorted alphabetically by default
nlevels(f)   # Returns the total number of distinct levels
table(f)     # Counts occurrences of each level — useful for quick frequency checks

# Specify level order explicitly to override alphabetical default
f <- factor(c("yes", "yes", "no", "yes", "no"), levels = c("yes", "no"))
f

attributes(f)   # Shows levels and class ("factor") of the object


# --- 2e. Data Frames ---
# Data frames are 2-dimensional and can hold columns of DIFFERENT classes —
# the most common structure for real-world tabular data.

df <- data.frame(
  gene1 = c(1, 2, 3, 4),
  gene2 = c(7, 9, 7, 6),
  gene3 = c(12, 34, 13, 14)
)
df

# Data frames can mix numeric, character, and logical columns
df <- data.frame(
  gene1 = c(1, 2, 3, 4),
  gene2 = c("very low", "low", "high", "very high"),
  gene3 = c(T, F, T, T)
)
df

nrow(df)                              # Returns the number of rows in the data frame
rownames(df) <- c("r1", "r2", "r3", "r4")  # Assigns custom row names
attributes(df)                        # Shows names, class, and row.names of the data frame

# Converting between matrix and data frame
dfm <- as.data.frame(m)   # Converts a matrix to a data frame (columns become character/numeric)
class(dfm)

m <- data.matrix(dfm)     # Converts a data frame back to a numeric matrix (coerces all columns)
class(m)
m


# --- 2f. Missing Values ---
# R uses NA for general missing values and NaN for undefined mathematical results (e.g. 0/0).

x <- c(1, 2, 8, NA, 3)
is.na(x)    # Returns TRUE at positions where value is NA (or NaN); FALSE elsewhere
is.nan(x)   # Returns TRUE ONLY at positions where value is NaN (not plain NA)

x <- c(1, NaN, 7, NA, 8)
is.na(x)    # TRUE for both NaN and NA — NaN is considered a special type of NA
is.nan(x)   # TRUE only for NaN — plain NA is not NaN


# ---- 3. SUBSETTING ------------------------------------------
# R provides three operators for subsetting: [], [[]], and $

# --- 3a. Subsetting Lists ---

x <- list(pie = 1:4, chart = 0:6)

x[1]      # [] returns a LIST containing the first element — the wrapper is preserved
x[[1]]    # [[]] returns the actual CONTENT of the first element (a bare vector)

x <- list(pie = 1:4, chart = 0:8, well = "hello")
x[c(1, 3)]   # [] with multiple indices returns a sub-list of selected elements

x$chart      # $ extracts an element by name — returns the content directly (like [[]])

x <- list(added = 1:5)
x$a          # $ supports partial matching — "a" matches "added" and returns its value

# Key difference: $ uses partial matching; [[]] requires the exact name


# --- 3b. Subsetting Vectors ---

x <- c("a", "b", "c", "c", "d", "a")

x[1]          # Returns the first element using a positional (integer) index
x[c(1, 3, 4)] # Returns elements at positions 1, 3, and 4
x[1:4]        # Returns elements at positions 1 through 4 (a range)
x[x > "a"]   # Logical subsetting — returns only elements that satisfy the condition


# --- 3c. Subsetting Matrices ---
# Syntax: matrix[row, column] — leave row or column blank to select all

x <- matrix(1:6, 2, 3)
x

x[1, 2]   # Returns the single value at row 1, column 2
x[2, ]    # Returns all values in row 2 (result is a vector by default)
x[, 3]    # Returns all values in column 3 (result is a vector by default)

# drop = FALSE preserves the matrix structure instead of simplifying to a vector
x[1, , drop = FALSE]   # Returns row 1 as a 1×3 matrix, not a plain vector
# Critical in functions where downstream code expects a matrix

class(x[1, ])              # "numeric" — R drops the matrix structure by default
class(x[1, , drop = FALSE]) # "matrix" / "array" — structure is kept with drop = FALSE

