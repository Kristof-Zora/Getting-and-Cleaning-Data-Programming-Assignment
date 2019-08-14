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
