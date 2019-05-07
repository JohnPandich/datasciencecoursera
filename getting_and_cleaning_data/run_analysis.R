# Set labels to be used later
activityLabels = read.table("./activity_labels.txt")[,2]
variableLabels = read.table("./features.txt")[,2]


# Read test data
testData <- read.table("./test/X_test.txt")
# Set descriptive variable names
colnames(testData) <- variableLabels
# Keep only mean and std
testData = testData[,grepl(".*((mean)|(std)).*", colnames(testData))]

testY <- read.table("./test/y_test.txt")
# Set descriptive variable name
colnames(testY)[1] <- c("activity")
testData <- cbind(testData, testY)
remove(testY)

testSubject <- read.table("./test/subject_test.txt")
# Set descriptive variable name
colnames(testSubject)[1] <- c("subject")
testData <- cbind(testData, testSubject)
remove(testSubject)


# Read train data
trainData <- read.table("./train/X_train.txt")
# Set descriptive variable names
colnames(trainData) <- variableLabels
# Keep only mean and std
trainData = trainData[,grepl(".*((mean)|(std)).*", colnames(trainData))]

trainY <- read.table("./train/y_train.txt")
# Set descriptive variable name
colnames(trainY)[1] <- c("activity")
trainData <- cbind(trainData, trainY)
remove(trainY)

trainSubject <- read.table("./train/subject_train.txt")
# Set descriptive variable name
colnames(trainSubject)[1] <- c("subject")
trainData <- cbind(trainData, trainSubject)
remove(trainSubject)


# Combine data test and train
data <- rbind(testData, trainData)
remove(testData)
remove(trainData)


# Use descriptive activity names
data$activity = activityLabels[data$activity]


# Create a tidy data set that averages variables for each activity, subject
tidyData <- data.frame(matrix(ncol = ncol(data), nrow = 0))
# Reinitialize descriptive variable names
colnames(tidyData) <- colnames(data)
# Add rows, using the average of each subject, activity combination
i = 0
for(activity in activityLabels){
  for(subject in unique(data$subject)){
    tidyRow <- colMeans(data[(data$activity==activity & data$subject==subject),(colnames(data) != "activity" & colnames(data) != "subject")])
    tidyRow$activity = activity
    tidyRow$subject = subject
    tidyData[i,] <- tidyRow
    i = i + 1
  }
}

# save our tidy data
write.table(tidyData, "./tidyData.txt", row.name=FALSE)