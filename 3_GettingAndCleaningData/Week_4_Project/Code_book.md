

# Getting and Cleaning Data Course Project

a code book that describes the variables, the data, and any
transformations or work that you performed to clean up the data called
Code_book.md

## 1. Data information

This is a course project that related the experiments that have been
carried out with a group of 30 volunteers within an age bracket of 19-48
years. Each person performed six activities (WALKING, WALKING_UPSTAIRS,
WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone
(Samsung Galaxy S II) on the waist. Using its embedded accelerometer and
gyroscope, we captured 3-axial linear acceleration and 3-axial angular
velocity at a constant rate of 50Hz. The experiments have been
video-recorded to label the data manually. The obtained dataset has been
randomly partitioned into two sets, where 70% of the volunteers was
selected for generating the training data and 30% the test data.

## 2. Data source

The data source is from the course website represent data collected from
the accelerometers from the Samsung Galaxy S smartphone. A full
description is available at the site where the data was obtained:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
Here are the data for the project:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

## 3. R.script

The file in the repo named "run_analysis.R" performs the process of
cleaning the data. Below information specifies the 5 steps required in
this project.

1.  Merges the training and the test sets to create one data set.

    1.1 download the dataset.

    1.2 read the dataset files.

    1.3 merge the trainning and test dataset with appropriate variable
    names.

    **feature** \<- features.txt: The features selected for this
    database come from the accelerometer and gyroscope 3-axial raw
    signals tAcc-XYZ and tGyro-XYZ.

    **activities_id** \<- activity_labels.txt :List of activities performed
    when the corresponding measurements were taken and its codes
    (labels)

    **sub_test** \<- test/subject_test.txt :contains test data of
    9/30 volunteer test subjects being observed

    **x_test** \<- test/X_test.txt :contains recorded features test data

    **y_test** \<- test/y_test.txt :contains test data of
    activities'code labels

    **sub_train** \<- test/subject_train.txt : contains train data
    of 21/30 volunteer subjects being observed

    **x_train** \<- test/X_train.txt :contains recorded features train
    data

    **y_train** \<- test/y_train.txt :contains train data of
    activities'code labels

2.  Extracts only the measurements on the mean and standard deviation
    for each measurement.

3.  Uses descriptive activity names to name the activities in the data
    set.

4.  Useing gsub() to appropriately labels the data set with descriptive
    variable names.

5.  From the data set in step 4, creates a second, independent tidy data
    set with the average of each variable for each activity and each
    subject. Export the final tidy data into a txt file.
