# Getting and Cleaning Data Course Project
# Data Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# 1 : Merges the training and the test sets to create one data set.

library(tidyr)
library(plyr)

df1 <- read.table("HAR/train/X_train.txt")
df2 <- read.table("HAR/test/X_test.txt")
xdata <- rbind(df1, df2)

df1 <- read.table("HAR/train/subject_train.txt")
df2 <- read.table("HAR/test/subject_test.txt")
sdata <- rbind(df1, df2)

df1 <- read.table("HAR/train/y_train.txt")
df2 <- read.table("HAR/test/y_test.txt")
ydata <- rbind(df1, df2)

# 2 : Extracts only the measurements on the mean and standard deviation for each measurement

features <- read.table("HAR/features.txt")
index_req_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
xdata <- xdata[, index_req_features]
names(xdata)<-features[index_req_features,2]
names(xdata) <- gsub("\\(|\\)", "", names(xdata))
names(xdata) <- tolower(names(xdata))

# 3 : Uses descriptive activity names to name the activities in the data set

activity <- read.table("HAR/activity_labels.txt")
activity[, 2] = tolower(as.character(activity[, 2]))
ydata[,1] = activity[ydata[,1], 2]
names(ydata)<-"activity"

# 4 : Appropriately labels the data set with descriptive variable names. 

names(sdata) <- "subject"
final_dataset<- cbind(sdata, ydata, xdata)

# 5 : From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

clean_final_dataset<-gather(final_dataset , stats_attribute, stats_value, -subject, -activity)
average_final_dataset <- ddply(clean_final_dataset,c("subject","activity"),summarise,avg=mean(stats_value ))
write.table(average_final_dataset, "average_final_dataset.txt", row.name=FALSE, sep = ',', quote=FALSE)

