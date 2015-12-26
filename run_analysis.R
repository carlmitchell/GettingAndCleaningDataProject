# Load the training X data (features)
train_x <- read.table('UCI HAR Dataset/train/X_train.txt')
# Load the test X data (features)
test_x <- read.table('UCI HAR Dataset/test/X_test.txt')
# Combine the two into a single dataset
data_x <- rbind(train_x, test_x)

# Load the training y data (activities)
train_y <- read.table('UCI HAR Dataset/train/y_train.txt')
# Load the test y data (activities)
test_y <- read.table('UCI HAR Dataset/test/y_test.txt')
# Combine the two into a single dataset
data_y <- rbind(train_y, test_y)

# Load the training y data (activities)
train_sub <- read.table('UCI HAR Dataset/train/subject_train.txt')
# Load the test y data (activities)
test_sub <- read.table('UCI HAR Dataset/test/subject_test.txt')
# Combine the two into a single dataset
data_sub <- rbind(train_sub, test_sub)

# Give the activities descriptive names
data_y$activity <- 'temp'
data_y$activity[data_y$V1==1] <- 'Walking'
data_y$activity[data_y$V1==2] <- 'Walking_Upstairs'
data_y$activity[data_y$V1==3] <- 'Walking_Downstairs'
data_y$activity[data_y$V1==4] <- 'Sitting'
data_y$activity[data_y$V1==5] <- 'Standing'
data_y$activity[data_y$V1==6] <- 'Laying'

# Create a new data frame starting from this activity column
new_data <- data.frame(data_y$activity)
colnames(new_data) <- c("Activity")
new_data$Activity <- as.character(new_data$Activity) #Not a factor
new_data$ActivityID <- data_y$V1
new_data$Subject <- data_sub$V1

# Start assigning the mean and std values from the X data
# frame to this new frame (with good column names)
new_data$TBodyAccXMean <- data_x$V1
new_data$TBodyAccXStd <- data_x$V4
new_data$TBodyAccYMean <- data_x$V2
new_data$TBodyAccYStd <- data_x$V5
new_data$TBodyAccZMean <- data_x$V3
new_data$TBodyAccZStd <- data_x$V6

new_data$TGravityAccXMean <- data_x$V41
new_data$TGravityAccXStd <- data_x$V44
new_data$TGravityAccYMean <- data_x$V42
new_data$TGravityAccYStd <- data_x$V45
new_data$TGravityAccZMean <- data_x$V43
new_data$TGravityAccZstd <- data_x$V46

new_data$TBodyAccJerkXMean <- data_x$V81
new_data$TBodyAccJerkXStd <- data_x$V84
new_data$TBodyAccJerkYMean <- data_x$V82
new_data$TBodyAccJerkYStd <- data_x$V85
new_data$TBodyAccJerkZMean <- data_x$V83
new_data$TBodyAccJerkZStd <- data_x$V86

new_data$TBodyGyroXMean <- data_x$V121
new_data$TBodyGyroXStd <- data_x$V124
new_data$TBodyGyroYMean <- data_x$V122
new_data$TBodyGyroYStd <- data_x$V125
new_data$TBodyGyroZMean <- data_x$V123
new_data$TBodyGyroZStd <- data_x$V126

new_data$TBodyGyroJerkXMean <- data_x$V161
new_data$TBodyGyroJerkXStd <- data_x$V164
new_data$TBodyGyroJerkYMean <- data_x$V162
new_data$TBodyGyroJerkYStd <- data_x$V165
new_data$TBodyGyroJerkZMean <- data_x$V163
new_data$TBodyGyroJerkZStd <- data_x$V166

new_data$TBodyAccMagMean <- data_x$V201
new_data$TBodyAccMagStd <- data_x$V202
new_data$TGravityAccMagMean <- data_x$V214
new_data$TGravityAccMagStd <- data_x$V215
new_data$TBodyAccJerkMagMean <- data_x$V227
new_data$TBodyAccJerkMagStd <- data_x$V228
new_data$TBodyGyroMagMean <- data_x$V240
new_data$TBodyGyroMagStd <- data_x$V241
new_data$TBodyGyroJerkMagMean <- data_x$V253
new_data$TBodyGyroJerkMagStd <- data_x$V254

new_data$FBodyAccXMean <- data_x$V266
new_data$FBodyAccXStd <- data_x$V269
new_data$FBodyAccYMean <- data_x$V267
new_data$FBodyAccYStd <- data_x$V270
new_data$FBodyAccZMean <- data_x$V268
new_data$FBodyAccZStd <- data_x$V271

new_data$FBodyAccJerkXMean <- data_x$V345
new_data$FBodyAccJerkXStd <- data_x$V348
new_data$FBodyAccJerkYMean <- data_x$V346
new_data$FBodyAccJerkYStd <- data_x$V349
new_data$FBodyAccJerkZMean <- data_x$V347
new_data$FBodyAccJerkZStd <- data_x$V350

new_data$FBodyGyroXMean <- data_x$V424
new_data$FBodyGyroXStd <- data_x$V427
new_data$FBodyGyroYMean <- data_x$V425
new_data$FBodyGyroYStd <- data_x$V428
new_data$FBodyGyroZMean <- data_x$V426
new_data$FBodyGyroZStd <- data_x$V429

new_data$FBodyAccMagMean <- data_x$V503
new_data$FBodyAccMagStd <- data_x$V504
new_data$FBodyBodyAccJerkMagMean <- data_x$V516
new_data$FBodyBodyAccJerkMagStd <- data_x$V517
new_data$FBodyBodyGyroMagMean <- data_x$V529
new_data$FBodyBodyGyroMagStd <- data_x$V530
new_data$FBodyBodyGyroJerkMagMean <- data_x$V542
new_data$FBodyBodyGyroJerkMagStd <- data_x$V543

# Now we want to take the average mean and std for each
# variable for each subject and each activity. We create
# a blank data frame to do this, then fill it row-by-row.
final_data <- data.frame(matrix(0,180,69))
colnames(final_data) <- colnames(new_data)
class(final_data$Activity) <- "character"
# Now we generate each row of the new data frame
for(Sub_Number in 1:30){
    for(Activity_Number in 1:6){
        # Silly way of finding the right row number
        row_number <- Activity_Number+(Sub_Number-1)*6
        # The subset of data which will contribute to the row
        row_data <- new_data[new_data$Subject == Sub_Number & new_data$ActivityID == Activity_Number,]
        #print(class(row_data[1,1]))
        #print(row_data[1,1])
        final_data[row_number,4:69] <- colMeans(row_data[,4:69])
        # Can't take means of non-numeric data
        final_data[row_number,1:3] <- row_data[1,1:3]
    }
}

# Write the data
write.table(final_data, 'final_data.txt', row.names = FALSE)