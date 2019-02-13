pollutantmean <- function(directory, pollutant, id = 1:332){
  
  # Read the data
  data = NA
  for(num in id){
    fileName = paste(num , ".csv", sep = "")
    while(nchar(fileName) < 7) fileName = paste("0", fileName, sep = "")
    fileData = read.csv(paste(getwd(), "/", directory, "/", fileName, sep = ""))

    if(is.data.frame(data) == FALSE){
      data = fileData
    }
    else{
      data = rbind(data, fileData)
    }
  }
  
  pVec = data[pollutant]
  vecNAs = is.na(pVec)
  pVec = pVec[!vecNAs]

  mean(pVec)
}


complete <- function(directory, id = 1:332){
  
  # Read the data
  data = vector()
  for(num in id){
    fileName = paste(num , ".csv", sep = "")
    while(nchar(fileName) < 7) fileName = paste("0", fileName, sep = "")
    fileData = read.csv(paste(getwd(), "/", directory, "/", fileName, sep = ""))
    
    compRows = complete.cases(fileData)
    compRows = compRows[compRows == TRUE]
    
    fileData = c(fileName, length(compRows))
    
    data = rbind(data, fileData)
  }
  data = data.frame(data)
  colnames(data) <- c("id", "nobs")
  data
}


corr <- function(directory, threshold = 0){
  
  # Read the data
  allFiles <- list.files(directory, full.names = TRUE)
  data = vector()
  
  for(file in allFiles){
    fileData = read.csv(file)
    compRows = complete.cases(fileData)
    fileData = fileData[compRows, ]

    if(nrow(fileData) > threshold){
      data = c(data, cor(fileData["sulfate"], fileData["nitrate"]))
    }
  }
  
  data
}
