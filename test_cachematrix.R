# Basic cachematrix tests
# To execute: Rscript test_cachematrix.R

source("cachematrix.R")

# =============================================================================
message("Data preparation")
set.seed(1)
l = list()
n = 5
for(i in 1:n) {
    l[[i]] <- makeCacheMatrix(matrix(rnorm(4.9e+05), nrow=700, ncol=700))
}

# =============================================================================
message("Initial matrix inverse computation")
for(i in 1:n) {
    print(system.time(cacheSolve(l[[i]])))
}

# =============================================================================
message("Validate performance with caching")
for(i in 1:n) {
    print(system.time(cacheSolve(l[[i]])))
}

# =============================================================================
message("Test usage of set")
m <- matrix(rnorm(4.9e+05), nrow=700, ncol=700)
cm <- makeCacheMatrix(m)
i <- cacheSolve(cm) # Computes inverse
i <- cacheSolve(cm) # Gets inverse from cache

# Reset internal matrix of cacheable matrix (exercise 'set' function)
cm$set(matrix(rnorm(4.9e+05), nrow=700, ncol=700))
i <- cacheSolve(cm) # Computes inverse
i <- cacheSolve(cm) # Gets inverse from cache

# =============================================================================
message("Validate correctness")
# Fails if caching of regular matrix different than cached matrix)
m <- matrix(rnorm(4.9e+05), nrow=700, ncol=700)
cm <- makeCacheMatrix(m)
stopifnot(all(head(solve(m)) == head(cacheSolve(cm))))
