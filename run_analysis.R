# Getting and Cleaning Data: Course Project, Derek Funk
# first download zipped folder, extract the "UCI HAR Dataset" folder, and set working directory here
# make sure to have "dplyr" package installed

# import data
test_data <- read.table("test/X_test.txt")
train_data <- read.table("train/X_train.txt")

# merge data
full_data <- rbind(test_data, train_data)

# import column names
features <- read.table("features.txt")
# mean column names have string "mean()"; standard deviation column names have string "std()"
mean_cols <- grep("mean()", features[, 2], fixed = TRUE)
std_cols <- grep("std()", features[, 2], fixed = TRUE)
keep_cols <- sort(c(mean_cols, std_cols))
keep_cols_names <- features[keep_cols, 2]

# extract just mean and std columns from data set and provide column names
full_data <- full_data[, keep_cols]
names(full_data) <- keep_cols_names

# import subject and activity type labels, and combine into full label sets
test_subjects <- read.table("test/subject_test.txt")
train_subjects <- read.table("train/subject_train.txt")
full_subjects <- rbind(test_subjects, train_subjects)

test_activity <- read.table("test/y_test.txt")
train_activity <- read.table("train/y_train.txt")
full_activity <- rbind(test_activity, train_activity)

# add subjects and activity types to full data set
full_data <- cbind(full_subjects, full_activity, full_data)
names(full_data)[1:2] <- c("subject", "activity")

# find average of each of the 66 mean/std variables by subject/activity combination
full_data2 <- full_data
full_data_2 <-aggregate(full_data_2[, 3:68], by = list(full_data_2$subject, full_data_2$activity), 
                        FUN = mean)
names(full_data_2)[1:2] <- c("subject", "activity")

# write file out as csv
write.csv(full_data_2, "tidy data set.csv")
