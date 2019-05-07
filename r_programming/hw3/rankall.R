# The function returns a 2-column data frame containing the hospital in each state that has the ranking specified in num.
#  Takes two arguments: an outcome name (outcome) and a hospital ranking (num).
rankall <- function(outcome, num = "best") {
    
  # Read outcome data
  outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Read hospital data
  hospitals <- read.csv("hospital-data.csv")
  
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
  
  # Create a vector of states
  states <- sort(unique(hospitals$State))
  
  # Return hospital name in that state with the rank provided
  allOrderedNames = list()
  allOrderedRanks = list()
  i= 0
  for(state in states){
    allOrderedNames <- append(allOrderedNames, list(vector()))
    allOrderedRanks <- append(allOrderedRanks, list(vector()))
    i = i + 1
  }
  names(allOrderedRanks) <- states
  names(allOrderedNames) <- states
  
  for(i in 1:nrow(outcomes)){
    
    row <- outcomes[i,]
    rowValue = as.numeric(row[[key]])
    
    hospitalRow = hospitals[hospitals[["Provider.Number"]] == row[["Provider.Number"]], ]
    hospitalState = toString(hospitalRow[["State"]])

    orderedNames = allOrderedNames[[hospitalState]]
    orderedRanks = allOrderedRanks[[hospitalState]]

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

    allOrderedNames[[hospitalState]] = orderedNames
    allOrderedRanks[[hospitalState]] = orderedRanks
  }

  stateHospitals = vector()
  for(state in states){

    thisState = allOrderedNames[[state]]
    
    index = num
    if(num == "best"){
      index = 1
    }
    else if(num == "worst"){
      index = length(thisState)
    }
    
    stateHospitals = c(stateHospitals, toString(thisState[index]))
  }
  
  result = data.frame(stateHospitals, states)
  dimnames(result) <- list(states, c("hospital", "state"))
  
  result
}