Getting and cleaning data course project
========================================
# CodeBook.md
This project contains one code book: CodeBook.md

# run_analysis.R
This project contains one script: run_analysis.R
The script requires reshape2 library
This script performs the following actions:
* Reads the feature labels and activity labels data
* Filters the feature labels to those containing "mean(" and "std" text
* Reads the test data
  + Names properly the test data columns
  + Filters the test data with the above filtered feature labels
  + Adds the activity labels and subject data to the test data
* Reads the train data
  + Names properly the train data columns
  + Filters the train data with the above filtered feature labels
  + Adds the activity labels and subject data to the train data
* Combines the test and train data
* Melts the combined data in preparation for generation of aggregates
* Creates a tiny_data variable that contains the average per subject and activity
* Writes the tiny_data into a tiny_data.txt file in your working directory

To run the script execute:
```{r}
source("<dir>/run_analysis.R")
```
