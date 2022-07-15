##The first function, makeCacheMatrix creates a special "matrix", 
##which is really a list containing a function to:




makeCacheMatrix <- function(x = matrix()) {
  i <- NULL
  ## 1. set the value of the matrix
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  ## 2. get the value of the matrix
  get <- function() x
  
  ## 3. set the value of the inverse
  setinverse <- function(inverse) i <<- inverse
  
  ## 4. get the value of the inverse
  getinverse <- function() i
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## This function computes the inverse of the special "matrix" returned 
## by makeCacheMatrix above. If the inverse has already been calculated 
## (and the matrix has not changed), then the cachesolve should retrieve 
## the inverse from the cache.

cacheSolve <- function(x, ...) {
    
  ## Return a matrix that is the inverse of 'x'
    i <- x$getinverse()
    if(!is.null(i)) {
      message("getting cached data")
      return(i)
    }
    data <- x$get()
    i <- solve(data, ...)
    x$setinverse(i)
    i
}
