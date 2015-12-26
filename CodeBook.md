# Codebook for "Getting and Cleaning Data" Course Project Submission

## Description of input

There is only one piece of code (run_analysis.R) and one input (the "UCI HAR Dataset/" directory), so this is largely self-explanatory.

## Description of code

The code reads the data from the UCI HAR dataset (provided by the assignment) and merges the test and training sets into a single dataset.

From here, the code ignores all but a small subset of the data collumns, specifically those which are *means* or *standard devations* of measurements. These data are organized by Subject Number (1-30) and Activity (1-6).

The code then determines a mean for each of these observables for each Subject-Activity combination (i.e. a total of 180 mean values for each observable).

This data is then written out to the file "final_data.txt"

## Description of output

The output file is a space-separated text file output by the write.table() R function. The first three column names are:
* 1) A description of the activity.
* 2) The activity ID (1-6) (I left this in for easy use as a numeric factor - it's completely redundant with Column 1)
* 3) The subject ID (1-30)
The remaining 66 columns represent the average Mean and Standard Deviation of 33 observables for each Subject-Activity combination. The column titles ought to be somewhat self-explanatory here, and end with "Mean" or "Std" appropriately, for example "FBodyBodyGyroJerkMagMean" and "FBodyBodyGyroJerkMagStd".