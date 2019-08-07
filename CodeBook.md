# CodeBook of run_analysis()

## Required packeges: dplyr, plyr, tidyr, stringr, readr.

### There exist the directory "UCI HAR Dataset" in the working directory with the required directories and txt files.

### data frames:
* subject_train: 1 column and 7352 rows.
* activity_train: 1 column and 7352 rows.
* X_train: 561 columns and 7352 rows.
* subject_test: 1 column and 2947 rows.
* activity_test: 1 column and 2947 rows.
* X_test: 561 columns and 2947 rows.
* data: 561 columns and 10 299 rows.
* activity_labels: 2 columns and 6 rows.
* result_mean: 561 columns and 1 row.
* result_std: 561 columns and 1 row. 
* result: 561 columns and 2 rows.
* merged_train_act: 2 columns and 7352 rows.
* merged_train: 563 columns and 7352 rows.
* merged_test_act: 2 columns and 2947 rows.
* merged_test: 563 columns and 2947 rows.
* data2: 3 columns and 5 777 739 rows.
* result2: 3 columns and 40 rows.


### Describes of the variables:
**subject_train:** Column "id" is the column of identifiers of the subjects from the train group.
**activity_train:** Column "Activity_label" is the column of activity labels for the train group. It can be 1..6. From activity_labels.txt it is known that 1 means WALKING, 2 means WALKING_UPSTAIRS, ..., 6 means LAYING.
**X_train:** Measurements of different types of accelerates for the train group. Column names: "Measuremet_1", ..., "Measurement_561".
**subject_test:** Column "id" is the column of identifiers of the subjects from the test group.
**activity_test:** Column "Activity_label" is the column of activity labels for the test group. It can be 1..6. From activity_labels.txt it is known that 1 means WALKING, 2 means WALKING_UPSTAIRS, ..., 6 means LAYING.
**X_test:** Measurements of different types of accelerates for the test group. Column names: "Measuremet_1", ..., "Measurement_561".
**data:** Merged dataset of X_train and X_test.
**activity_labels:** Column names: "label" (can be 1...6) and "Activity" (can be WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING).
**result_mean:** The vector of mean of the Measurements of the data frame data.
**result_std:** The vector of standard deviation of the Measurements of the data frame data.
**result:** The merged data frame of result_mean and result_std.
**merged_train_act:** Column names: "Activity_label" (can be 1...6), "Activity" (can be "WALKING", "WALKING_UPSTAIRS",...). Matched the Activity label with the corresponding Activity in the train group.
**merged_train:** Columns names: "id", "Activity", "Measurement_1", ..., "Measurement_561". Merging of the data frames subject_train, merged_train and X_train.
**merged_test_act:** Column names: "Activity_label" (can be 1...6), "Activity" (can be "WALKING", "WALKING_UPSTAIRS",...). Matched the Activity label with the corresponding Activity in the test group.
**merged_test:** Columns names: "id", "Activity", "Measurement_1", ..., "Measurement_561". Merging of the data frames subject_train, merged_train and X_train.
**data2:** Column names: "id", "Activity", "Accelerate". Gathered version of the merged data of merged_train and merged_test. It shows the accelerate of the subject with code "id" during the activity "Activity".
**result2:** Column names: "Activity", "id", "mean". The mean of the accelerate of the subject with code "id" during the activity "Activity".

