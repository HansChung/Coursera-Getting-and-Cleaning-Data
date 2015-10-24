The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Variables

1. From the downloaded files, we read data and set up the variables as x_train, y_train, x_test, y_test, subtrain and subtest
2. We use x_all, y_all and suball merge the previous datasets to further analysis.
3. Variable, "all", merges x_all, y_all and suball in a big dataset.
4. newCols contains the correct names.
5. smallframe contains the data including mean values for each subject-activity pair
5. Finally, tidyData contains the average of each variable for each activity and each subject which will be later stored in a .txt file.
