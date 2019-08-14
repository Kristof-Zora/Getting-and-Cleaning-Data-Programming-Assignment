# README of run_analysis()

### There exist the required directories and txt files in the working directory.


run_analysis <-function(){
        #including dplyr package
        library(dplyr)
        
        #Reading txt file
        activity_labels<-read.csv2("./activity_labels.txt", sep="",
                                   header=FALSE,
                                   col.names=c("label","Activity")) %>%
                         tbl_df
        
        #Reading txt file
        features<-read.csv2("./features.txt", sep="", header=FALSE,
                            col.names=c("Number","Feature")) %>%
                tbl_df
        
        #Changing the name the begin of the columns from tBody... to
        # timeBody and from fBody... to frequencyBody
        features$Feature<-gsub("^t","time",features$Feature)
        features$Feature<-gsub("^f","frequency",features$Feature)
        
        #Omitting the paranthesis from function names
        features$Feature<-gsub("\\(\\)", "", features$Feature)
        
        #Changing the special character "," to the special character "/"
        features$Feature<-gsub("\\,", "/", features$Feature)
        
        #There are some same featurename in the "Feature" variable,
        #therefore I paste to columns "Number" and "Features".
        #After that, every feature has a unique name.
        features<-paste(features$Number,features$Feature, sep = "_")
        
        #Reading txt files 
        subject_train<-read.csv2("./train/subject_train.txt",
                                 sep="", header=FALSE,
                                 col.names=c("id")) %>% tbl_df
        activity_train<-read.csv2("./train/y_train.txt",
                                  sep="", header=FALSE,
                                  col.names=c("Activity_label")) %>%
                        tbl_df
        X_train<-read.csv2("./train/X_train.txt", sep="", header=FALSE,
                           stringsAsFactors=FALSE) %>%
                 tbl_df
        #The columns of X_train are the features (the measurements)
        colnames(X_train)<-features
        
        #Reading txt files
        subject_test<-read.csv2("./test/subject_test.txt",
                                 sep="", header=FALSE,
                                 col.names=c("id")) %>% tbl_df
        activity_test<-read.csv2("./test/y_test.txt",
                                  sep="", header=FALSE,
                                  col.names=c("Activity_label")) %>%
                       tbl_df
        X_test<-read.csv2("./test/X_test.txt", sep="", header=FALSE,
                           stringsAsFactors=FALSE) %>%
                tbl_df
        #The columns of X_test are the features (the measurements)
        colnames(X_test)<-features
        
        

        #Merging train and test data sets
        merged_X<-rbind(X_train,X_test) %>%
                  sapply(as.numeric) %>%
                  tbl_df
        merged_activity<-rbind(activity_train,activity_test)
        merged_subject<-rbind(subject_train,subject_test)
        
        #After matching, I have a column with observations of the
        #labels of the activities (WALKING, WALKING_UPSTAIRS,...)
        matched_activity<-merge(merged_activity,activity_labels,
                                by.x="Activity_label",by.y="label",all=TRUE) %>%
                          select(Activity) %>%
                          tbl_df
        
        #The columns of measurments, which contains mean or std
        mean_and_std<-select(merged_X, contains("mean"),
                             contains("std"))
        
        #After summarize, I have the mean of the measurements with
        #mean or std grouped by the subject identities and activities.
        data<-cbind(merged_subject,matched_activity,mean_and_std) %>%
              group_by(id,Activity) %>%
              summarize_all(mean)
        
        #Writing txt file
        write.table(data,file="MeanBySubjAndActivity.txt",row.name=FALSE)
}


Variables:
* activity_labels: data frame with two columns: "label" and "Activity". The variable label can be 1 to 6. The variable Activity can be WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING.
* features: data frame with 1 column and 561 rows. The rows of features will be the names of the measurements (the column names of X_train and X_test).
* subject_train: This variable has a class of data frame (tbl_df). It has one column: "id". The codes of the subjects were stored in this variable, who are in the train group.
* activity_train: This variable has a class of data frame (tbl_df). It has one column: "Activity_label". The codes of the activity labels from y_train.txt were stored in this variable.
* X_train: data frame with 561 columns and 7352 rows. The columns are the measurements of features.
* subject_test: same as subject_train.
* activity_test: same as activity_train.
* X_test: data frame with 561 columns and 2947 rows. Same as X_train.
* merged_X: data frames with 561 columns and 10 299 rows. This data frame is the merged version of X_train and X_test.
* merged_activity: data frame with 1 column and 10 299 rows. This is the merging of activity _train and activity_test.
* merged_subject: data frame with 1 column and 10 299 rows. This is the merging of subject_train and subject_test.
* matched_activity: After matching, it has 1 column and 10 299 rows. The kth row of matched_activity is the activity of the kth person (WALKING, WALKING_UPSTAIRS, ...).
* mean_and_std: data_frame with 86 columns and 10 299 rows. I have selected the columns of merged_X, which contains "mean" or "std" (measurements with mean or std).
* data: data frame with 88 columns and 10 299 rows. Merged version of merged_subject, matched_activity, and mean_and_std. The columns are the "id" of the subject, the "Activity" of the subject (it can be WALKING, WALKING_UPSTAIRS,...) and the columns of mean_and_std. After that it has benn grouped by the "id" and "Activity". Summarized this data set computing by the mean of all columns I get a data frame with 88 columns and 35 rows.

