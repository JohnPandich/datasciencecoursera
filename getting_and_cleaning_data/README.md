# How the script works

Execute the code in the top level directory of the folder.

* The script will save arrays for activity labels and features

*  For test and train sets the script will:
1. Read test variable data, setting features as column names
2. Use Regex to keep only mean and std
3. Read Y values, setting the column name as "activity"
4. Read subject values, setting the column name as "subject"

* The script wil then combine the datasets

* The script will then convert activity numbers into label values using the activity array

* The script will then create a tidy data set that loops over activities and subjects subject, taking the means for all values that share a common activity and subject.
    - Note we have to ignore "activity" as we can not take a mean of text but we re add it in the loop. We do this for the subject too to mantain column order

* The script will then save the tidy data

# Codebook

activityLabels = read.table("./activity_labels.txt")[,2]
variableLabels = read.table("./features.txt")[,2]


# Read test data
* testData Used to store X_test.txt data for grooming and is then aggrigated with testY and testSubject
* testY - Used to store y_test.txt data for grooming
* testSubject - Used to store subject_test.txt data for grooming
* trainData Used to store X_train.txt data for grooming and is then aggrigated with trainY and trainSubject
* trainY - Used to store y_train.txt data for grooming
* trainSubject - Used to store subject_train.txt data for grooming)
* data - The combination of testData and trainData rows
* tidyData - Used to store the mean data as we find the mean of rows sharing a common activity and subject
* tidyRow - Used to build rows for the tidy data. This houses the intermediate row of a single activity and subject before it is added to tidyData
