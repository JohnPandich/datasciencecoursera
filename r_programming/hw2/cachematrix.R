# This function creates a special "vector" object that can cache its inverse.
makeVector <- function(x = numeric()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)
}


# This function computes the mean of the special "vector" returned by makeVector above. 
# If the mean has already been calculated (and the vactor has not changed), then the cachemean should retrieve the mean from the cache.
cachemean <- function(x, ...) {
  m <- x$getmean()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- mean(data, ...)
  x$setmean(m)
  m
}


# This function creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
  
  s <- NULL
  
  set <- function(y) {
    x <<- y
    s <<- NULL
  }
  get <- function() x
  
  setsolve <- function(solve) s <<- solve
  getsolve <- function() solve
  
  list(set = set, get = get,
       setsolve = setsolve,
       getsolve = getsolve)
}


# This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
# If the inverse has already been calculated (and the matrix has not changed), then the cachesolve should retrieve the inverse from the cache.
cacheSolve <- function(x, ...) {
  
  s <- x$getsolve()
  
  if(!is.null(s)) {
    message("getting cached data")
    return(s)
  }
  
  data <- x$get()
  s <-solve(data, ...)
  x$setsolve(s)
  
  s
}