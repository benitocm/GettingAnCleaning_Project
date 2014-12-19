---
title: "Getting & Cleaning Data Course Project"
---

### 1. Dataset description.

This goal of this project is take an originial dataset described in file README.txt and generate a new file, resultDataSet.txt, using the data contained in the originial dataset.
This new file  has been generated processing the other files according to the process explained in the next section. It contains the average of the each variable that refers to a mean or standard desviation for each activity and each subject.


### 2. Process to generate the resultDataSet.txt file

1. Merges the training and the test sets to create one data set. 

* Read the training X's

* Read the test X's

* Merge vertically both  sets

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

*  Read the feature.txt file to obtain the id of features that are a mean and/or std I assume that those features are the ones that include the string "mean()" or the string "std()" in their names


* The total dataset is subset with the column numbers corresponding to the avg and std variables generating the Avg and Std data set.

* The "subject" column is built  merging vertically the subject colum in the train and test sets

* The Avg and Std data set is augmented with the "subject" column. 


3. Uses descriptive activity names to name the activities in the data set

* The "y" column is built merging vertically the "y" column of the train and test sets and "yTest". Besides, it is renamed to "activity_id"

*  Read the activity id and the activity name from the activity_labels.txt file 

*  Join operation for replacing to obtain the "activity_name" for "each activity_id"" in the data set 

* The Avg and Std data set is augmented with the "activity name" column


4. Appropriately labels the data set with descriptive variable names. 

* The names of the variables of the data set are replaced by the name of the selected features (just those ones that are mean or std) plus the "subject" and "activity" columns.


5. From the data set in step 4, creates a second, independent tidy data set with the average 
of each variable for each activity and each subject

* The data set is melted by the "activity" and "subject" fields 

* The molten data is dcast'ed by "activity" and "subject" field so we will have  the unique combinations of both fields. In addition, the average of the each column is calculated so we will have a column for each  measurement considered that will contain the average of that measurement for a particular combination of "activity" and "subject".


* The name of the columns that refers to variables are changed to the add the prefix "Avg-of-" indicating that the are mean fo the original variables.

* The result data set is written to a file called "resultDataSet.txt" including the column names but not the row names.

### 3. Code Book

The result data set contains the following fields:

* activity.  A value indicating the activity that subject was doing when the measurements were done. The possible values are: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

* subject. The id of the subject under test. The possible values are an integer between 1 and 30 (both included)

Next there is a list of fields that refers to the average obtained for each unique pair of "activity" and "subject" for some original measures. The name of these fields follows a pattern, they have a prefix "Avg-of-" indicating that they are an average and that prefix is followed by the name of the original variable.
The list of the fields is the following:

* "Avg-of-tBodyAcc-mean()-X"
* "Avg-of-tBodyAcc-mean()-Y"
* "Avg-of-tBodyAcc-mean()-Z"
* "Avg-of-tBodyAcc-std()-X",
* "Avg-of-tBodyAcc-std()-Y",
* "Avg-of-tBodyAcc-std()-Z"
* "Avg-of-tGravityAcc-mean()-X"
* "Avg-of-tGravityAcc-mean()-Y"
* "Avg-of-tGravityAcc-mean()-Z"
* "Avg-of-tGravityAcc-std()-X"
* "Avg-of-tGravityAcc-std()-Y"
* "Avg-of-tGravityAcc-std()-Z"
* "Avg-of-tBodyAccJerk-mean()-X"
* "Avg-of-tBodyAccJerk-mean()-Y"
* "Avg-of-tBodyAccJerk-mean()-Z"
* "Avg-of-tBodyAccJerk-std()-X"
* "Avg-of-tBodyAccJerk-std()-Y"
* "Avg-of-tBodyAccJerk-std()-Z"
* "Avg-of-tBodyGyro-mean()-X"
* "Avg-of-tBodyGyro-mean()-Y"
* "Avg-of-tBodyGyro-mean()-Z"
* "Avg-of-tBodyGyro-std()-X"
* "Avg-of-tBodyGyro-std()-Y"
* "Avg-of-tBodyGyro-std()-Z"
* "Avg-of-tBodyGyroJerk-mean()-X"
* "Avg-of-tBodyGyroJerk-mean()-Y"
* "Avg-of-tBodyGyroJerk-mean()-Z"
* "Avg-of-tBodyGyroJerk-std()-X"
* "Avg-of-tBodyGyroJerk-std()-Y"
* "Avg-of-tBodyGyroJerk-std()-Z"
* "Avg-of-tBodyAccMag-mean()"
* "Avg-of-tBodyAccMag-std()"
* "Avg-of-tGravityAccMag-mean()"
* "Avg-of-tGravityAccMag-std()"
* "Avg-of-tBodyAccJerkMag-mean()"
* "Avg-of-tBodyAccJerkMag-std()"
* "Avg-of-tBodyGyroMag-mean()"
* "Avg-of-tBodyGyroMag-std()"
* "Avg-of-tBodyGyroJerkMag-mean()"
* "Avg-of-tBodyGyroJerkMag-std()"
* "Avg-of-fBodyAcc-mean()-X"
* "Avg-of-fBodyAcc-mean()-Y"
* "Avg-of-fBodyAcc-mean()-Z"
* "Avg-of-fBodyAcc-std()-X"
* "Avg-of-fBodyAcc-std()-Y"
* "Avg-of-fBodyAcc-std()-Z"
* "Avg-of-fBodyAccJerk-mean()-X"
* "Avg-of-fBodyAccJerk-mean()-Y"
* "Avg-of-fBodyAccJerk-mean()-Z"
* "Avg-of-fBodyAccJerk-std()-X"
* "Avg-of-fBodyAccJerk-std()-Y"
* "Avg-of-fBodyAccJerk-std()-Z"
* "Avg-of-fBodyGyro-mean()-X"
* "Avg-of-fBodyGyro-mean()-Y"
* "Avg-of-fBodyGyro-mean()-Z"
* "Avg-of-fBodyGyro-std()-X"
* "Avg-of-fBodyGyro-std()-Y"
* "Avg-of-fBodyGyro-std()-Z"
* "Avg-of-fBodyAccMag-mean()"
* "Avg-of-fBodyAccMag-std()"
* "Avg-of-fBodyBodyAccJerkMag-mean()"
* "Avg-of-fBodyBodyAccJerkMag-std()"
* "Avg-of-fBodyBodyGyroMag-mean()"
* "Avg-of-fBodyBodyGyroMag-std()"
* "Avg-of-fBodyBodyGyroJerkMag-mean()"
* "Avg-of-fBodyBodyGyroJerkMag-std()"

