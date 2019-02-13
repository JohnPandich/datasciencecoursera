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

makeCacheMatrix <- function(x = numeric()) {
  
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