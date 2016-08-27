if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")

loadCsvFile <- function(filename, col_names) {
  read.csv(filename, col.names = col_names, sep ="", header=FALSE)
}

mergeDataset <- function(X, y, subject, required_features, activity_labels) {
  X <- X[,required_features]
  m <- merge(activity_labels,y,by.x="Activity_Id",by.y="y_id")
  cbind(subject,m, X)
}

activity_labels <- loadCsvFile("./UCI HAR Dataset/activity_labels.txt", c("Activity_Id", "Activity_Label"))
features <- loadCsvFile("./UCI HAR Dataset/features.txt",c("features_id", "features_label"))[,2]

# Extracts only the measurements on the mean and standard deviation for each measurement.
required_features <- grepl("mean|std", features)

# Merges the training and the test sets to create one data set.
# Uses descriptive activity names to name the activities in the data set.
data_test <- mergeDataset(
  X = loadCsvFile("./UCI HAR Dataset/test/X_test.txt", features), 
  y = loadCsvFile("./UCI HAR Dataset/test/y_test.txt", c("y_id")),
  subject = loadCsvFile("./UCI HAR Dataset/test/subject_test.txt", c("Subject")),
  required_features = required_features, 
  activity_labels = activity_labels)

data_train <- mergeDataset(
  X = loadCsvFile("./UCI HAR Dataset/train/X_train.txt", features), 
  y = loadCsvFile("./UCI HAR Dataset/train/y_train.txt", c("y_id")),
  subject = loadCsvFile("./UCI HAR Dataset/train/subject_train.txt", c("Subject")),
  required_features = required_features, 
  activity_labels = activity_labels)

merged_data = rbind(data_test, data_train)

# extract means by key Subject/Activity_Label
group_labels <- c("Subject", "Activity_Id","Activity_Label")
data_labels <- setdiff(colnames(merged_data), group_labels)
melt_data <- melt(merged_data, id = group_labels, measure.vars = data_labels)
tidy_data = dcast(melt_data, Activity_Label + Subject ~ variable, mean)

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
write.table(tidy_data, file = "./tidy_data.txt")