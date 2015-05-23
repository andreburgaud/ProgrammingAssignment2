# =============================================================================
# Implementation and usage of a cacheable matrix. Cachable matrix
# caches its inverse upon first computation.
# Example:
# m <- makeCacheMatrix(matrix(rnorm(4.9e+05), nrow=700, ncol=700))
# i <- cacheSolve(m)
# =============================================================================


# Constructs a cachable matrix.
# Arg:
#   x: Matrix object, default to empty matrix if no argument.
# Return:
#   Cacheable matrix
makeCacheMatrix <- function(x = matrix()) {
    s <- NULL
    set <- function(y) {
        x <<- y
        s <<- NULL
    }
    get <- function() x
    setinverse <- function(solve) s <<- solve
    getinverse <- function() s
    list(set = set, get = get,
        setinverse = setinverse,
        getinverse = getinverse)
}

# Computes inverse of a matrix.
# Args:
#     x: Cacheable matrix (built with makeCacheMatrix)
#     ...: Extra arguments passed to 'solve' function
# Return:
#     Matrix that is the inverse of 'x'
cacheSolve <- function(x, ...) {
    s <- x$getinverse()
    if (!is.null(s)) {
        message("Getting cached inverse")
        return(s)
    }
    data <- x$get()
    s <- solve(data, ...)
    x$setinverse(s)
}
