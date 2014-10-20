#Download project data, if project data is not available in working directory
if(!file.exists("project.zip")) 
    download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "project.zip")

#Unzip project data, , if project data folder is not available in working directory
if(!file.exists("UCI HAR Dataset"))
    unzip("project.zip")

# 1. Merge the training and the test sets to create one data set.

# Read and create test data in memory
xTestData <- read.table("UCI HAR Dataset/test/X_test.txt")
yTestData <- read.table("UCI HAR Dataset/test/y_test.txt")
subjectTestData <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Read and create training data in memory
xTrainData <- read.table("UCI HAR Dataset/train/X_train.txt")
yTrainData <- read.table("UCI HAR Dataset/train//y_train.txt")
subjectTrainData <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Merge test and training data
dataMerge <- rbind(cbind(yTestData,subjectTestData,xTestData), cbind(yTrainData,subjectTrainData,xTrainData))

#Give proper column names to merged data
colnames(dataMerge) <- c("activitiesID","subjectID",as.vector(read.table("UCI HAR Dataset/features.txt")[,2]))

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

#Only extract column names with mean() or std().
meanStd <- grep("(mean|std)\\(\\)", names(dataMerge))

#Data that contains columns with mean() and std(), andd activitiesID and subjectID
meanStdData <- cbind(dataMerge[, c("activitiesID","subjectID")], dataMerge[,meanStd])

# 3. Uses descriptive activity names to name the activities in the data set

# Read and create activitiesLabel
activitiesLabel <- read.table("UCI HAR Dataset/activity_labels.txt")

# Assign column names to activitiesLabel
colnames(activitiesLabel) <- c("activitiesID","activities")

# Finalize data set by merging meanStdData and activitiesLabel together
finalData <- merge(x=meanStdData, y=activitiesLabel, by="activitiesID", all.x=TRUE)

# 4. Appropriately labels the data set with descriptive variable names. 
colnames(finalData) <- gsub("^t", "time", colnames(finalData))
colnames(finalData) <- gsub("^f", "frequency", colnames(finalData))
colnames(finalData) <- gsub("-mean\\(\\)", "Mean", colnames(finalData))
colnames(finalData) <- gsub("-std\\(\\)", "StdDev", colnames(finalData))
colnames(finalData) <- gsub("-", "", colnames(finalData))
colnames(finalData) <- gsub("BodyBody", "Body", colnames(finalData))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Prepare tidyData by dropping subjectID, activitiesID and activities
finalDataFeature <- finalData[,!(colnames(finalData) %in% c("subjectID","activitiesID","activities"))]

# Create tidy data set with the average of each variable for each activity and each subject 
tidyData <- aggregate(finalDataFeature, by=list(activities = finalData$activities, subject = finalData$subjectID),mean);

# Write tidyData into tidyData.txt
write.table(tidyData, "tidyData.txt", row.name=FALSE)
