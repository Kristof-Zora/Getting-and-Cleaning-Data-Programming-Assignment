# Getting-and-Cleaning-Data-Programming-Assignment

# README of run_analysis()

## Required packeges: dplyr, plyr, tidyr, stringr, readr.

### There exist the directory "UCI HAR Dataset" in the working directory with the required directories and txt files.


run_analysis <-function(){
        
	subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt",
                                  sep=" ", fill=TRUE,
                                  col.names=c("id"))
        activity_train<-read.table("./UCI HAR Dataset/train/y_train.txt",
                                   sep=" ", fill=TRUE,
                                   col.names=c("Activity_label"))
        X_train<-read_file("./UCI HAR Dataset/train/X_train.txt")
        X_train<-gsub("  "," ",X_train)
        write_file(X_train,"./UCI HAR Dataset/train/X_train_withOneSpace.txt")
        X_train<-read.table("./UCI HAR Dataset/train/X_train_withOneSpace.txt",
                            sep=" ", fill=TRUE) %>%
                select(-1)
        
        
        
        
        subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",
                                  sep=" ", fill=TRUE,
                                  col.names=c("id"))
        activity_test<-read.table("./UCI HAR Dataset/test/y_test.txt",
                                   sep=" ", fill=TRUE,
                                   col.names=c("Activity_label"))
        X_test<-read_file("./UCI HAR Dataset/test/X_test.txt")
        X_test<-gsub("  "," ",X_test)
        write_file(X_test,"./UCI HAR Dataset/test/X_test_withOneSpace.txt")
        X_test<-read.table("./UCI HAR Dataset/test/X_test_withOneSpace.txt",
                            sep=" ", fill=TRUE, ) %>%
                select(-1)
		
		
        for (i in 1:ncol(X_train)){
                colnames(X_train)[i]<-paste("Measurement_",i,sep="")
                colnames(X_test)[i]<-paste("Measurement_",i,sep="")
        }
        data<-rbind(X_train,X_test)
        
        
        activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt",
                                    sep=" ", fill=TRUE,
                                    col.names=c("label","Activity"))
        
        
        
        result_mean<-sapply(data,mean)
        result_std<-sapply(data,sd)
        result<-rbind(result_mean,result_std)
        
        print("The mean and standard deviation of the first five measurements:")
        print(result[,1:5])
        
        
        
        
        
        
        merged_train_act<-merge(activity_train,activity_labels,
                                by.x="Activity_label",by.y="label",all=TRUE)
        
        merged_train<-cbind(subject_train,merged_train_act,X_train) %>%
                      select(-Activity_label)
        
        
        merged_test_act<-merge(activity_test,activity_labels,
                               by.x="Activity_label",by.y="label",all=TRUE)
        
        merged_test<-cbind(subject_test,merged_test_act,X_test) %>%
                     select(-Activity_label)
        
        
        
        data2<-rbind(merged_train,merged_test) %>%
              gather("col","Accelerate",-id,-Activity) %>%
              select(-col) %>%
              group_by(Activity,id)
        
        
        result2<-summarise(data2, mean=mean(Accelerate)) %>%
                 arrange(Activity,id)
        print(result2,n=Inf)
        
        write.table(result2,file="result_dataset_of_5th_task.txt",row.name=FALSE)
        
        
        
}





Variables:
* subject_train: This variable has a class of data frame. It has one column: "id". The codes of the subjects were stored in this variable, who are in the train group.
* activity_train: This variable has a class of data frame. It has one column: "Activity_label". The codes of the activity labels from y_train.txt were stored in this variable.
* X_train: Firstly, this variable is a (very long) character. Since there are one and two white spaces between the entires, I used the gsub function to change all of the two white space in the text to one white spces. After that there are only one white spaces between the numbers. This character has been written in the file X_train_withOneSpace.txt using the write_file function. After that the data frame was stored in the variable X_train by the read.table function. In the original X_train.txt, each line starts at least one white space, therefore, in the X_train_withOneSpace.txt file, every lines start with one white space. This means, that the first column of the data frame X_train contains only NULL element. Hence I omitted this column by the select command.
* subject_test: same as subject_train.
* activity_test: same as activity_train.
* X_test: same as X_train.
* activity_labels: data frame with two columns: "label" and "Activity". The variable label can be 1 to 6. The variable Activity can be WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING.


The first exercise was to merge the training and test data sets: "Merges the training and the test sets to create one data set." The training data set is included in X_train.txt, which was stored in the variable X_train. The test data set is included in X_test.txt, which was stored in X_test. X_train and X_test have 561 columns, therefore they can be merged by the rbind command. This merged data frame is stored in the data variable. So data has 561 columns and 10 299 rows.


The second task was: "Extracts only the measurements on the mean and standard deviation for each measurement." From the original README file and from other documentation of the data set, it has not come to light, what are the columns of X_train.txt and X_test.txt exactly. I think, each column can be interpreted as a special accelerate. For example accelerate of the body along the x-axis, or the accelerate of the body along the y-axis, etc. Therefore I have denominated the columns as "Measurement_1", "Measurement_2", etc. The mean and the standard deviation of the measurements were computed and stored in the variables result_mean and result_std. Using rbind, I got a matrix with 2 rows and 561 columns. The jth column of the vector result_mean contains the mean of the jth column of data (Mesurement_j). Similarly, the jth column of the vector result_std contains the standard deviation of the jth column of data (Measurement_j).


The third task: "Uses descriptive activity names to name the activities in the data set". To this, I merged the variables activity_train and activity_labels by the "Activity_label" of activity_train and the "label" of activity_labels in the variable merged_train_act. It has 2 columns: "Actvity_label" and "Activity" and 7352 rows. Activity label was the code (it can be 1..6) of the Activity, which can be WALKING, WALKING_UPSTAIRS, etc.


I can merge the data frames: subject_train, merged_train_act and X_train. This data frame is named as merged_train and it has 564 columns (1 from subject_train, 2 from merged_train_act and 561 from X_train) and 7352 rows. The variable "Activity_label" is unnecessary, therefore I omitted from this by the command select(-Activity).


I take the same with the data frame activity_test and activity_labels and I get merged_test_act and merged_test. After omitting the "Activity_label" column, merged_train and merged_test have 563 columns, therefore I can merge them using rbind. Stored in the data frame data2, it has now 563 columns and 10 299 rows. Its columns are "id", "Activity", "Measurement_1", "Measurement_2", ..., "Measurement_561". So, data2 satisfies the require of task 3.


The fourth exercise: "Appropriately labels the data set with descriptive variable names." The data frame data2 satisfies this require, as well.


The fifth task: "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject." The columns "Measurement_1", ..., "Measurement_561" contain some accelerate information. I computed the mean of the accelerates to each Activity and each subject. To this, I have gathered the data frame data2 and grouped by "Ativity" and "id". Then I summarised in result2 the mean of "Accelerate" of data2. After arranging we have that the mean accelerate of the Activity "LAYING" by the subject with code 20 is -0.464, the mean accelerate of the Activity "LAYING" by the subject with code 24 is -0.533, ..., the mean accelerate of the Activity "WALKING_UPSTAIRS" by the subject with code 14 is -0.642.
