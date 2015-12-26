# GettingAndCleaningDataProject
This repository contains my submission for the course project of the getting and cleaning data course.

## Files contained in this repository
* README.md --> This file.
* CodeBook.md --> A description of the code and its outputs.
* run_analysis.R --> R script for doing the data analysis.
* final_data.txt --> The output of the R script.

The broad goal of this assignment was to read large data sets from multiple files into R, merge these data frames into a single data set, subset this data appropriately, and create a smaller data set which summarizes this data.

With the assignment came a .zip archive, containing a large dataset. When unzipped, this creates a directory called "UCI HAR Dataset/". The script "run_analysis.R" was designed to be run from the directory which contains the "UCI HAR Dataset/" directory, i.e. its parent directory.