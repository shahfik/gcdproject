#Sets the working directory. You may want to set the working directory to
#something specific to your environment.
setwd("~/Learning/Coursera/03 Getting and Cleaning Data/Project")

#Check if the data to be used for the project is available by checking for the
#directory
if(!file.exists("./UCI HAR Dataset")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="./dataset.zip", mode="wb")
  unzip("./dataset.zip")
}

#load necessary libraries
library(data.table)

#Load features file and set the column names.
features <- fread("./UCI HAR Dataset/features.txt")
setnames(features,c("featureId","featureName"))

#To make the column names easier to use, we tidy the names
#1. Remove brackets
features$featureName2 = gsub("\\(|\\)","",features$featureName)
#2. Dashes replaced with underscores
features$featureName2 = gsub("\\-|\\,","_",features$featureName2)

#Load the activity definitions file and set the column names
activities <- fread("./UCI HAR Dataset/activity_labels.txt")
setnames(activities,c("activityID","activityName"))

#Load the x_test file and set the column names to the feature names. Next, merge
#the data from subject and activity. fread does not work here.
xTest <- as.data.table(
  read.table("./UCI HAR Dataset/test/x_test.txt", col.names=features$featureName2))
xTest[,c("subjectID","activityID"):=c(
  fread("./UCI HAR Dataset/test/subject_test.txt"),
  fread("./UCI HAR Dataset/test/y_test.txt"))]

#Same as above but now for the training set
xTrain <- as.data.table(
  read.table("./UCI HAR Dataset/train/x_train.txt", col.names=features$featureName2))
xTrain[,c("subjectID","activityID"):=c(
  fread("./UCI HAR Dataset/train/subject_train.txt"),
  fread("./UCI HAR Dataset/train/y_train.txt"))]

#We use regex to filter out the column names containing the mean and standard
#deviation. SubjectID and activityID are also required
cols <- c("subjectID","activityID",
          features[featureName2 %like% ".*(mean_|std|mean$).*",featureName2]) 


# The following performs the following:
# ITEM 1: Merges the training and the test sets to create one data set, and 
# ITEM 2: Extracts only the measurements on the mean and standard deviation 
#         for each measurement.
# ITEM 4: Appropriately labels the data set with descriptive variable names.

#Merge the xTrain and xTest datasets and keep only the required columns
merged <- rbindlist(list(xTest,xTrain))[,cols,with=FALSE]


# ITEM 3: Uses descriptive activity names to name the activities in the data set

#Do the Excel-equivalent of a vlookup to provide descriptive activity names
setkey(merged,activityID,subjectID)
setkey(activities,activityID)
HARdataset <- merged[activities,]
HARdataset <- subset(HARdataset, select=-activityID)

# STEP 5: Creates a second, independent tidy data set with the average of each
# variable for each activity and each subject.
avgHARdataset = copy(HARdataset[,lapply(.SD,mean),by="subjectID,activityName"])

write.table(avgHARdataset, file="./avgHARdataset.txt", row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)