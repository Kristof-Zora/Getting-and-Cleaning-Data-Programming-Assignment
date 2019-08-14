# CodeBook of run_analysis()

### There exist the required directories and txt files in the working directory.

### data frames:
* activity_labels: 2 columns and 6 rows.
* features: 1 column and 561 rows.
* subject_train: 1 column and 7352 rows.
* activity_train: 1 column and 7352 rows.
* X_train: 561 columns and 7352 rows.
* subject_test: 1 column and 2947 rows.
* activity_test: 1 column and 2947 rows.
* X_test: 561 columns and 2947 rows.
* merged_X: 561 columns and 10 299 rows.
* merged_activity: 1 column and 10 299 rows.
* merged_subject: 1 column and 10 299 rows.
* matched_activity: 1 column and 10 299 rows.
* mean_and_std: 86 columns and 10 299 rows.
* data: 88 columns and 35 rows (after grouping and summarizing).


### Describes of the variables:
**activity_labels:** Column names: "label" (can be 1...6) and "Activity" (can be WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING).
**features:** inclueded data from features.txt.
**subject_train:** Column "id" is the column of identifiers of the subjects from the train group.
**activity_train:** Column "Activity_label" is the column of activity labels for the train group. It can be 1..6. From activity_labels.txt it is known that 1 means WALKING, 2 means WALKING_UPSTAIRS, ..., 6 means LAYING.
**X_train:** Measurements of different types of accelerates for the train group. Column names are the entries of "features".
**subject_test:** Column "id" is the column of identifiers of the subjects from the test group.
**activity_test:** Column "Activity_label" is the column of activity labels for the test group. It can be 1..6. From activity_labels.txt it is known that 1 means WALKING, 2 means WALKING_UPSTAIRS, ..., 6 means LAYING.
**X_test:** Measurements of different types of accelerates for the test group. Column names are the entries of "features".
**merged_X:** Merged data of X_train and X_test. Column names are the entries of "features".
**merged_activity:** Merged data of activity_train and activity_test. The rows can be 1,...,6 (the code of the activity).
**merged_subject:** Merged data of subject_train and subject_test. The rows can be 1,...,30 (identifiers of the subject).
**matched_activity:** I "change" the entires of merged_activity to its meaning (1=WALKING, 2=WALKING_UPSTAIRS,...).
**mean_and_std:** I select the columns of merged_X, which contains "mean" or "std". This is a data set with 86 columns and 10 299 rows.
**data:** Firstly, I adapt the columns "merged_subject" and "matched_activity" to the data frame mean_and_std and I store this data frame in "data". It has 88 columns and 10 299 rows. After grouped this data frame by id and Activity I summarize the mean of the groups and I store this in data. Then data has 88 columns and 35 rows.

