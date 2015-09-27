#reading features
trainX <- read.table("./UCI HAR Dataset/train/X_train.txt", dec=".")
testX <- read.table("./UCI HAR Dataset/test/X_test.txt", dec=".")
X <- rbind(trainX, testX)

#reading labels
trainY <- read.table("./UCI HAR Dataset/train/y_train.txt")
testY <- read.table("./UCI HAR Dataset/test/y_test.txt")
y <- rbind(trainY, testY)

#reading subjects
trainSubj <- read.table("./UCI HAR Dataset/train/subject_train.txt")
testSubj <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(trainSubj, testSubj)

#creating dataset
dataset <- cbind(X, y, subject)

#getting subset of features that contains mean and standart deviation values
mean_std <- subset(features, grepl("mean\\(\\)", features$name)|grepl("std\\(\\)", features$name))
#getting the set of their indexes
indexes <- mean_std[,1]
#extracting values names
names <- mean_std[,2]
#giving the descriptive names
setDescriptiveNames <- function(vect){
    output <- gsub("^t", "time", vect)
    output <- gsub("^f", "frequency", output)
    output <- gsub("Acc", "Accelerometer", output)
    output <- gsub("Gyro", "Gyroscope", output)
    output <- gsub("-mean\\(\\)", "MeanValue", output)
    output <- gsub("-std\\(\\)", "StandartDeviation", output)
    output <- gsub("BodyBody", "Body", output)
    output
}
descNames <- setDescriptiveNames(names)

#extracting columns with mean and standart deviation values from initial dataset
tidyData <- dataset[,c(indexes, 562, 563)]
names(tidyData) <- c(descNames, "activityLabel", "subject")

#replacing activity id with label
tidyData$activityLabel[tidyData$activityLabel == 1] <- "WALKING"
tidyData$activityLabel[tidyData$activityLabel == 2] <- "WALKING_UPSTAIRS"
tidyData$activityLabel[tidyData$activityLabel == 3] <- "WALKING_DOWNSTAIRS"
tidyData$activityLabel[tidyData$activityLabel == 4] <- "SITTING"
tidyData$activityLabel[tidyData$activityLabel == 5] <- "STANDING"
tidyData$activityLabel[tidyData$activityLabel == 6] <- "LAYING"    

#creating new dataset with the average of each variable 
#for each activity and each subject.
newDataset <- aggregate(. ~ subject+activityLabel, data=tidyData, FUN = mean)

write.table(newDataset, "./newTidyDataset.txt", row.name=FALSE)
