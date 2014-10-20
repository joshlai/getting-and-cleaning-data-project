#Download project data, if project data is not available in working directory
if(!file.exists("project.zip")) 
    download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "project.zip")

#Unzip project data, , if project data folder is not available in working directory
if(!file.exists("UCI HAR Dataset"))
    unzip("project.zip")

# 1. Merge the training and the test sets to create one data set.
xTestData <- read.table("UCI HAR Dataset/test/X_test.txt")
yTestData <- read.table("UCI HAR Dataset/test/y_test.txt")
subjectTestData <- read.table("UCI HAR Dataset/test/subject_test.txt")

xTrainData <- read.table("UCI HAR Dataset/train/X_train.txt")
yTrainData <- read.table("UCI HAR Dataset/train//y_train.txt")
subjectTrainData <- read.table("UCI HAR Dataset/train/subject_train.txt")

dataMerge <- rbind(cbind(yTestData,subjectTestData,xTestData), cbind(yTrainData,subjectTrainData,xTrainData))

colnames(dataMerge) <- c("activitiesID","subjectID",as.vector(read.table("UCI HAR Dataset/features.txt")[,2]))

meanStd <- grep("(mean|std)\\(\\)", names(dataMerge))

meanStdData <- cbind(dataMerge[, c("activitiesID","subjectID")], dataMerge[,meanStd])

activitiesLabel <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activitiesLabel) <- c("activitiesID","activities")
finalData <- merge(x=meanStdData, y=activitiesLabel, by="activitiesID", all.x=TRUE)


colnames(finalData) <- gsub("^t", "time", colnames(finalData))
colnames(finalData) <- gsub("^f", "frequency", colnames(finalData))
colnames(finalData) <- gsub("-mean\\(\\)", "Mean", colnames(finalData))
colnames(finalData) <- gsub("-std\\(\\)", "StdDev", colnames(finalData))
colnames(finalData) <- gsub("-", "", colnames(finalData))
colnames(finalData) <- gsub("BodyBody", "Body", colnames(finalData))

finalDataFeature <- finalData[,!(colnames(finalData) %in% c("subjectID","activitiesID","activities"))]

tidyData <- aggregate(finalDataFeature, by=list(activities = finalData$activities, subject = finalData$subjectID),mean);

write.table(tidyData, "tidyData.txt", row.name=FALSE)
