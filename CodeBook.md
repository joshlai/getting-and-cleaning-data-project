###Code Book
This is a code book that describes the variables, the data, and work performed that are required to get and clean the data set.

##Data source
- Project data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Download project data, if project data is not available in working directory.
- Unzip project data, if project data "UCI HAR Dataset" folder is not available in working directory.


##1. Merge the training and the test sets to create one data set.
- Read and create test data in memory. Test data includes the following files:
1) 'test/X_test.txt': Test set
2) 'test/y_test.txt': Test labels
3) 'test/subject_test.txt': Subjects

# Read and create training data in memory. Training data includes the following files:
1) 'test/X_train.txt': Test set
2) 'test/y_train.txt': Test labels
3) 'test/subject_train.txt': Subjects

- Merge test and training data
- Give proper column names to merged data

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
- Only extract column names with mean() or std().
- Data that contains columns with mean() and std(), andd activitiesID and subjectID

## 3. Uses descriptive activity names to name the activities in the data set
- Read and create activitiesLabel from '/activity_labels.txt'
- Assign column names to activitiesLabel
- Finalize data set by merging meanStdData and activitiesLabel together

## 4. Appropriately labels the data set with descriptive variable names. 
- Use gsub function to change the column names

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- Prepare tidyData by dropping subjectID, activitiesID and activities
- Create tidy data set with the average of each variable for each activity and each subject 
- Write tidyData into 'tidyData.txt'
