# The function returns a character vector with the name of the hospital that has the ranking specified by the num argument.
# Take three arguments: the 2-character abbreviated name of a state (state), an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).
rankhospital <- function(state, outcome, num = "best") {
  
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
  
  # Return hospital name in that state with the rank provided
  hospitals <- hospitals[hospitals$State == state, ]
  outcomes <- outcomes[outcomes[["Provider.Number"]] %in% hospitals[["Provider.Number"]], ]
  orderedNames = c()
  orderedRanks = c()
  
  for(i in 1:nrow(outcomes)){
    row <- outcomes[i,]
    rowValue = as.numeric(row[[key]])
    
    if(is.na(rowValue)){
      next
    }
    else{
      
      if(length(orderedRanks) == 0){
        orderedRanks = c(rowValue)
        orderedNames = c(row[["Hospital.Name"]])
      }
      else{
        
        valueInserted = FALSE
        for(j in 1:length(orderedRanks)){
          
          if(orderedRanks[j] > rowValue){
            
            if(j == 0){
              orderedRanks = c(rowValue, orderedRanks)
              orderedNames = c(row[["Hospital.Name"]], orderedNames)
              valueInserted = TRUE
              break
            }
            else{
              orderedRanks = append(orderedRanks, rowValue, after=j-1)
              orderedNames = append(orderedNames, row[["Hospital.Name"]], after=j-1)
              valueInserted = TRUE
              break
            }
          }
          else if(orderedRanks[j] == rowValue){
            
            if(j == 0 && row[["Hospital.Name"]] < orderedNames[j]){
              orderedRanks = c(rowValue, orderedRanks)
              orderedNames = c(row[["Hospital.Name"]], orderedNames)
              valueInserted = TRUE
              break
            }
            else{
              
              if(row[["Hospital.Name"]] < orderedNames[j]){
                orderedRanks = append(orderedRanks, rowValue, after=j-1)
                orderedNames = append(orderedNames, row[["Hospital.Name"]], after=j-1)
                valueInserted = TRUE
                break
              }
              else{
                orderedRanks = append(orderedRanks, rowValue, after=j)
                orderedNames = append(orderedNames, row[["Hospital.Name"]], after=j)
                valueInserted = TRUE
                break
              }
            }
          }
        }
        
        if(valueInserted == FALSE){
          orderedRanks = c(orderedRanks, rowValue)
          orderedNames = c(orderedNames, row[["Hospital.Name"]])
        }
      }
    }
  }

  if(num == "best"){
    orderedNames[1]
  }
  else if(num == "worst"){
    orderedNames[length(orderedNames)]
  }
  else{
    orderedNames[num]
  }
}