library(reshape2)
library(plyr)


# 1 Merges the training and the test sets to create one data set. The y's and subject will 
#   be incorporated later.

# 1.1 Read the training X's

Xtrain <- read.table("train/X_train.txt", header=FALSE, sep="", stringsAsFactors=FALSE);

# 1.2 Read the test X's

Xtest <- read.table("test/X_test.txt", header=FALSE, sep="", stringsAsFactors=FALSE);

# 1.3 Merge vertically both  sets

Xtotal <- rbind(Xtrain,Xtest)


# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 

# 2.1 Read the feature.txt file to obtain the id of features that are a mean and/or std
#     I assume that those features are the ones that include the string "mean()" or
#     the string "std()" in their names

features <- read.table("features.txt", header=FALSE, sep="", stringsAsFactors=FALSE);
selectedFeaturesIds <- grep("mean\\(\\)|std\\(\\)",features[,2])

# 2.2 The total dataset is subset with the column numbers corresponding to the avg and std variables

AvgStdMeasures <- Xtotal[,selectedFeaturesIds]

 
# 2.3 The "subject" column is built  merging vertically the subject colum in the train set
#     and subject column in the test set in that specific order.

subjectTrain <- read.table("train/subject_train.txt", header=FALSE, sep="", stringsAsFactors=FALSE)
subjectTest <- read.table("test/subject_test.txt", header=FALSE, sep="", stringsAsFactors=FALSE)
subjectTotal <- rbind(subjectTrain,subjectTest)[,1]


# 2.4 The Avg and Std data set is augmented with the "subject" column. 

AvgStdMeasures$subject <- subjectTotal


# 3 Uses descriptive activity names to name the activities in the data set

# 3.1 The "y" column is built merging vertically the "yTrain" and "yTest". Besided, the column 
#     is renamed to "activity_id" for the join operation

yTrain <- read.table("train/y_train.txt", header=FALSE, sep="", stringsAsFactors=FALSE)
yTest <- read.table("test/y_test.txt", header=FALSE, sep="", stringsAsFactors=FALSE)
yTotal <- rbind(yTrain,yTest)
colnames(yTotal) <- "activity_id"


# 3.2 Read the activity id and the activity name from the activity_labels.txt file 
activityLabels <- read.table("activity_labels.txt", header=FALSE, sep="", stringsAsFactors=FALSE);
colnames(activityLabels) <- c("activity_id", "activity")


# 3.3 Join the yTotal and the activityLabels by the activity_id 

yLabeled <- join(yTotal,activityLabels,by="activity_id",type="left")

# 3.4 The Avg and Std data set is augmented with the "activity" name column

AvgStdMeasures$activity <- yLabeled$activity

# 4 Appropriately labels the data set with descriptive variable names. The names of the variables
# of the data set are replaced by the name of the selected features plus the "subject" and "activity"

colnames(AvgStdMeasures) <- c(features[selectedFeaturesIds,2],"subject","activity")


# 5 From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject

# 5.1 The data set is melted by the "activity" and "subject" fields.

AvgStdMeasuresMelt <- melt(AvgStdMeasures,id=c("activity","subject"))

# 5.2 The molten data is dcast'ed by "activity" and "subject" field so we will have
# the unique combinations of both fields.

resultDataSet <- dcast(AvgStdMeasuresMelt,activity+subject ~ variable, mean)

# 5.3 The name of the columens that refers to variables are changed to the add the
# the prefix "Mean-of-" indicating that the are mean fo the original variables.
newColumnNames <- colnames(resultDataSet)
newColumnNames[3:length(newColumnNames)] <- paste('Avg-of-',newColumnNames[3:length(newColumnNames)],sep='')
colnames(resultDataSet) <- newColumnNames

write.table(resultDataSet, file = "resultDataSet.txt", sep = ",", row.names=FALSE)



