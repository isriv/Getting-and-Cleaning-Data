datasciencecoursera
===================
## Coursera Getting & Cleaning Data Course Project. 

### This file describes the working of "run_analysis.R" script. 

* Unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename th folder as "data". 

* Make sure the directory "data" & the "run_analysis.R" script are both in the current working directory. 

* Use source("run_analysis.R") command in RStudio. 

* You will find two output files generated in the current working directory : 
      * merged_data.txt (7.9 MB) - It contains the data frame cleanedData with 10299*68 dimensions.
      * data_with_means.txt (220 KB) - It contains the data frame result with 180*68 dimensions. 

* Use the data <- read.table("data_with_means.txt") command in RStudio to read the file. Since we are required to get the average of each variable for each activity and each subject, and there are 6 activities and 30 subjects in total, we have 180 rows with all the combinations for each of the 66 features. 
 
© Ishan 2014 All Rights reserved.