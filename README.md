##Getting and Cleaning Data Course Project

###Overview
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

A full description can be obtained below: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The project data can be downloaded below: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

###Operation of run_analysis.R
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Working Step
1. Download and unzip the data source to your local computer.
2. Place run_analysis.R in the working directory of "UCI HAR Dataset" folder. 
3. Set the working directory using setwd() function in RStudio.
4. Run source("run_analysis.R") to generate a new file tiny_data.txt in the working directory.
