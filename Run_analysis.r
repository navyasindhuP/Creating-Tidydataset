
#####Step 1: Downlaod the zip file
## define a variable url and assign the source data url
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## define a variable dest for destination file 
dest <- "DATASET.zip"
## Downalod the zip file into our local workpsace TIP: it is always a good pratice to check if the file exxist or not beofre deownloading the actual file

if (!file.exists(dest)){
  download.file(url, destfile = dest, mode='wb')
}

## unzip the dataset, For more Information about unzip function see help(unzip) in R
  unzip(dest)
## Set the working directory to the extarcted file location to check if the working directory is st correctly or not use getwd()
setwd("./UCI HAR DATASET")
## Merges the training and the test sets to create one data set.
features <- read.table('./features.txt',header=FALSE);
activityLabels <- read.table('./activity_labels.txt',header=FALSE); 
SubjectTrain <- read.table('./train/subject_train.txt',header=FALSE);
xTrain <- read.table('./train/x_train.txt',header=FALSE);
yTrain <- read.table('./train/y_train.txt',header=FALSE);

## Assign column names to training dataset

colnames(activityLabels) <- c("activityId","activityType");
colnames(SubjectTrain) <- "subjectId";
colnames(xTrain) <- features[,2];
colnames(yTrain) <- "activityId";

## combine the training data set
 trainingdataset <- cbind(yTrain,SubjectTrain,xTrain);
## Merge the test data set
subjectTest <- read.table('./test/subject_test.txt',header=FALSE);
xTest <- read.table('./test/x_test.txt',header=FALSE);
yTest <- read.table('./test/y_test.txt',header=FALSE);
## Assign the column names to test dataset
colnames(subjectTest) <- "subjectId";
colnames(xTest) <- features[,2];
colnames(yTest) <- "activityId";
## Merge the test data set
testdataset = cbind(yTest,subjectTest,xTest);
# Merge the both training and test data sets
Mergeddataset = rbind(trainingdataset,testdataset);
columns <- colnames(MergedDataSet);
###Extracts only the measurements on the mean and standard deviation for each measurement.

extract_features <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
extracted_data <- MergedDataSet [,extract_features]
##Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
names(MergedDataSet)<-gsub("^t", "time", names(MergedDataSet))
names(MergedDataSet)<-gsub("^f", "frequency", names(MergedDataSet))
names(MergedDataSet)<-gsub("Acc", "Accelerometer", names(MergedDataSet))
names(MergedDataSet)<-gsub("Gyro", "Gyroscope", names(MergedDataSet))
names(MergedDataSet)<-gsub("Mag", "Magnitude", names(MergedDataSet))
names(MergedDataSet)<-gsub("BodyBody", "Body", names(MergedDataSet))
write.table(MergedDataSet, file = "tidydata.txt",row.name=FALSE)




