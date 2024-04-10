#!/bin/R
# Load data 
df <- read.csv("db/dbCategories.csv")

# Convert empty strings to NA
df[df==""] <- NA
cols <- c()

# Convert each column into a list
for (i in 1:ncol(df)){
	# Populate the `colnames` list with each column name
	cols <- append(cols, names(df)[i])
	# For each column name, create a list with the contents of that column
	assign(names(df)[i], df[,i])
}

# Remove NA values from each list
for (i in 1:length(cols)){
	tmp <- get(cols[i])
	tmp <- tmp[!is.na(tmp)]
	assign(cols[i], tmp)
}

# Generate a data frame called `variables` containing variables randomly
# assigned from one of the 5 categories each.
n = 200 # Generate 200 combinations

# Empty data frame "list"
varLists <- c()

for (i in 1:length(cols)){
	# Populate each list `var_i` with n random entries from each category
	assign(paste0("var_",i), # name the column
	       sample(get(cols[i]), n, replace=TRUE)
	)
	# Create a "list-of-lists" to generate a data frame
	varLists[[i]] <- get(paste0("var_",i))
}

# Combine into data frame
variables <- do.call("cbind", varLists)
variables <- as.data.frame(variables) # make type data frame
# Rename columns
names(variables) = cols
