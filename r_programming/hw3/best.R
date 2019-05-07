# The function returns a character vector with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome in that state.
# Take two arguments: the 2-character abbreviated name of a state and an outcome name.  The outcomes can be one of “heart attack”, “heart failure”, or “pneumonia”.
best <- function(state, outcome){
  
  # Read outcome data
  outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Read hospital data
  hospitals <- read.csv("hospital-data.csv")
  
  # Check that state is valid
  if( !(state %in% hospitals$State) ){
    stop("invalid state")
  }
  
  # Convert the outcome to the data column name
  key = "Hospital.30.Day.Death..Mortality..Rates.from."
  if(outcome == "pneumonia"){
    key = paste(key, "Pneumonia", sep="")
  }
  else if(outcome == "heart failure"){
    key = paste(key, "Heart.Failure", sep="")    
  }
  else if(outcome == "heart attack"){
    key = paste(key, "Heart.Attack", sep=""); 
  }
  else{
    stop("invalid outcome") 
  }
  
  # Return hospital name in that state with lowest 30-day death rate
  hospitals <- hospitals[hospitals$State == state, ]
  outcomes <- outcomes[outcomes[["Provider.Number"]] %in% hospitals[["Provider.Number"]], ]
  best = NULL

  for(i in 1:nrow(outcomes)) {
    row <- outcomes[i,]
    rowValue = as.numeric(row[[key]])

    if(is.na(rowValue)){
      next
    }
    else if(is.null(best) || rowValue < as.numeric(best[[key]])){
      best = row
    }
    else if(rowValue == as.numeric(best[[key]]) && row[["Hospital.Name"]] < best[["Hospital.Name"]]){
      best = row
    }
  }
  
  best[["Hospital.Name"]]
}