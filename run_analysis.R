#-------------------------------------------------------------------
# SUMMARY
#   Create a clean data set from data collected from the accelerometers from the Samsung Galaxy S 
#   smartphone, and generating a tidied up data file "tidy_data.txt" as output.
#   README.md for more details.
#------------------------------------------------------------------

library(dplyr)

#------------------------------------------------------------------
# STEP 0I - Get data
#------------------------------------------------------------------

# download zip file containing data if it hasn't already been downloaded
inputzipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
inputzipFile <- "UCI HAR Dataset.zip"

if (!file.exists(inputzipFile)) {
  download.file(inputzipUrl, inputzipFile, mode = "wb")
}

# unzip zip file containing data if data directory doesn't already exist
dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)) {
  unzip(inputzipFile)
}


#-----------------------------------------------------------------
# STEP 0II - Read data
#-----------------------------------------------------------------

# read training data
Subjects_training <- read.table(file.path(dataPath, "train", "subject_train.txt"))
Values_training <- read.table(file.path(dataPath, "train", "X_train.txt"))
Activity_training <- read.table(file.path(dataPath, "train", "y_train.txt"))

# read test data
Subjects_test <- read.table(file.path(dataPath, "test", "subject_test.txt"))
Values_test <- read.table(file.path(dataPath, "test", "X_test.txt"))
Activity_test <- read.table(file.path(dataPath, "test", "y_test.txt"))

# read features, don't convert text labels to factors
features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)
  ## note: feature names (in features[, 2]) are not unique
  ##       e.g. fBodyAcc-bandsEnergy()-1,8

# read activity labels
activities <- read.table(file.path(dataPath, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")


#-----------------------------------------------------------------
# Step 1 - Merge the training and the test sets to create one data set
#-----------------------------------------------------------------

# concatenate individual data tables to make single data table
humanActivity <- rbind(
  cbind(Subjects_training, Values_training, Activity_training),
  cbind(Subjects_test, Values_test, Activity_test)
)

# remove individual data tables to save memory
rm(Subjects_training, Values_training, Activity_training, 
   Subjects_test, Values_test, Activity_test)

# assign column names
colnames(humanActivity) <- c("subject", features[, 2], "activity")

#-----------------------------------------------------------------
# Step 2 - Extract only the measurements on the mean and standard deviation for each measurement
#-----------------------------------------------------------------

# determine columns of data set to keep based on column name...
columnsToKeep <- grepl("subject|activity|mean|std", colnames(humanActivity))

# ... and keep data in these columns only
humanActivity <- humanActivity[, columnsToKeep]

#-----------------------------------------------------------------
# Step 3 - Use descriptive activity names to name the activities in the data set
#-----------------------------------------------------------------

# replace activity values with named factor levels
humanActivity$activity <- factor(humanActivity$activity, 
  levels = activities[, 1], labels = activities[, 2])


#-----------------------------------------------------------------
# Step 4 - Appropriately label the data set with descriptive variable names
#-----------------------------------------------------------------

# get column names
humanActivityCols <- colnames(humanActivity)

# remove special characters
humanActivityCols <- gsub("[\\(\\)-]", "", humanActivityCols)

# expand abbreviations and clean up names
humanActivityCols <- gsub("^f", "frequency", humanActivityCols)
humanActivityCols <- gsub("^t", "time", humanActivityCols)
humanActivityCols <- gsub("Acc", "Accelerometer", humanActivityCols)
humanActivityCols <- gsub("Gyro", "Gyroscope", humanActivityCols)
humanActivityCols <- gsub("Mag", "Magnitude", humanActivityCols)
humanActivityCols <- gsub("Freq", "Frequency", humanActivityCols)
humanActivityCols <- gsub("mean", "Mean", humanActivityCols)
humanActivityCols <- gsub("std", "StandardDev", humanActivityCols)

# correct typo
humanActivityCols <- gsub("BodyBody", "Body", humanActivityCols)

# use new labels as column names
colnames(humanActivity) <- humanActivityCols

#---------------------------------------------------------------
# Step 5 - Create a second, independent tidy set with the average of each
#          variable for each activity and each subject
#---------------------------------------------------------------

# group by subject and activity and summarise using mean
humanActivityMeans <- humanActivity %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

# output to file "tidy_data.txt"
write.table(humanActivityMeans, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)
