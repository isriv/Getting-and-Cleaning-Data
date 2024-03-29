# Step 1 - Merges the training and the test sets to create one data set. 
setwd("h:\\datasciencecoursera") 
trainData <- read.table("data\train\X_train.txt")
dim(trainData)
head(trainData)
trainLabel <- read.table("data\train\y_train.txt")
table(trainLabel)
trainSubject <- read.table("data\train\subject_train.txt")
testData <- read.table("data\test\X_test.txt")
dim(testData)
testLabel <- read.table("data\test\y_test.txt")
table(testLabel)
testSubject <- read.table("data\test\subject_test.txt")
joinData <- rbind(trainData, testData)
dim(joinData)
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel)
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject)

# Step 2 - Extract only the measurements on the mean and standard deviations for each measurement. 
features <- read.table("data\features.txt")
dim(features)
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices)
joinData <- joinData[, meanStdIndices]
dim(joinData)
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2])
names(joinData) <- gsub("mean", "Mean", names(joinData))
names(joinData) <- gsub("-", "", names(joinData))

# Step 3 - Use descriptive activity names to name the activities in the data set. 
activity <- read.table("data\activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

# Step 4 - Appropriately label the data set with descriptive activity names. 
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanedData)
write.table(cleanedData, "merged_data.txt")

# Step 5 - Create second independent tidy data set with the average of each varibale for each activity and each subject. 
subjectLen <- length(table(joinSubject))
activityLen <- dim(activity)[1]
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow = subjectLen * activityLen, ncol = columnLen)
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleanedData$subject
    bool2 <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}
head(result)
write.table(result, "data_with_means.txt")

# data <- read.table("h:\\datasciencecoursera\data_with_means.txt)
# data[1:12, 1:3]