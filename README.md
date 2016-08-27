# Getting and Cleaning Data

## Goal
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Usage
1. Create a directory (folder) on your local system.
2. Download the Dataset in this directory.
3. Copy the script ```run_analysis.R``` in this directory.
4. In RStudio use the command ```setwd``` to point at this directory.
5. Finally run the command ```source("run_analysis.R")```.
6. A file called ```dataset_means.txt``` should be created in the same directory.

## Dependencies
The script ```run_analysis.R``` depends on the libraries ```reshape2``` and ```data.table```. Automatically it will try to install those libraries if required.
