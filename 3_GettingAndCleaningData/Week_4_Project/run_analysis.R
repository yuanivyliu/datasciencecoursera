#1. Merges the training and the test sets to create one data set.
#1.1 download the dataset.
library(dplyr)
library(tidyr)

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/dataset.zip", mode = "wb")
unzip("dataset.zip")

#1.2 read the dataset files
feature <- read.table("~/Desktop/UCI HAR Dataset/features.txt", col.names = c("n", "features"))
act_label <- read.table("~/Desktop/UCI HAR Dataset/activity_labels.txt")

x_train <- read.table("~/Desktop/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("~/Desktop/UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("~/Desktop/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("~/Desktop/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("~/Desktop/UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("~/Desktop/UCI HAR Dataset/test/subject_test.txt")

#1.3 merge the trainning and test dataset with appropriate variable names
merge_train <- cbind(sub_train, y_train, x_train)
merge_test <- cbind(sub_test, y_test, x_test)
merge_data <- rbind(merge_train, merge_test)

colnames(merge_data) <- c("subject_id", "activity_id", feature$features)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 

tidy_data <- merge_data %>% 
    select(subject_id, activity_id, contains("mean"), contains("std"))

#3. Uses descriptive activity names to name the activities in the data set

tidy_data$activity_id <- act_label[tidy_data$activity_id, 2]    

#4. Appropriately labels the data set with descriptive variable names.

names(tidy_data)[2] = "activity"
names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("^f", "Frequency", names(tidy_data))
names(tidy_data) <- gsub("meanFreq", "meanFrequency", names(tidy_data))
names(tidy_data) <- gsub("angle", "Angle", names(tidy_data))
names(tidy_data) <- gsub("tBody", "TimeBody", names(tidy_data))

#5. From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

tidy_data2 <- tidy_data %>% 
    group_by(subject_id, activity) %>% 
    summarise_all(.funs = mean)
#write the tidy_data2 to a txt file
write.table(tidy_data2, file = "tidy_data.txt", row.names = FALSE)




