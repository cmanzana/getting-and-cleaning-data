if (!require("reshape2")) {
  install.packages("reshape2")
}

require("reshape2")

# Reading activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Reading feature names
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Filter mean and std feature names
mean_std_features <- grepl("mean\\(|std", features)

# Reading test data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Assign column names to feature names
names(X_test) <- features

# Extract mean and std features
X_test <- X_test[,mean_std_features]

# Adding activity labels
y_test[,2] <- activity_labels[y_test[,1]]
names(y_test) <- c("activity_id", "activity_label")

# Naming subject data
names(subject_test) <- "subject"

# Combine columns into single table
test_data <- cbind(subject_test, y_test, X_test)

# Reading train data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Assign column names to feature names
names(X_train) <- features

# Extract mean and std features
X_train <- X_train[,mean_std_features]

# Adding activity labels
y_train[,2] <- activity_labels[y_train[,1]]
names(y_train) <- c("activity_id", "activity_label")

# Naming subject data
names(subject_train) <- "subject"

# Combine columns into single table
train_data <- cbind(subject_train, y_train, X_train)

# Merge test and training data sets
data <- rbind(test_data, train_data)

# Melting the data in order to create averages per subject and per activity
melt_data <- melt(data, id = c("subject", "activity_id", "activity_label"))

# tidy_data: averages per subject and per activity
tidy_data <- dcast(melt_data, subject + activity_label ~ variable, mean)

write.table(tidy_data, file="./tidy_data.txt", row.name=FALSE)
