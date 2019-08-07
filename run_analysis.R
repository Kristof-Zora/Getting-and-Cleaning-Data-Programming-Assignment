run_analysis <-function(){
        subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt",
                                  sep=" ", fill=TRUE,
                                  col.names=c("id"))
        #print("dim(subject_train):")
        #print(dim(subject_train))
        activity_train<-read.table("./UCI HAR Dataset/train/y_train.txt",
                                   sep=" ", fill=TRUE,
                                   col.names=c("Activity_label"))
        #print("dim(activity_train):")
        #print(dim(activity_train))
        X_train<-read_file("./UCI HAR Dataset/train/X_train.txt")
        X_train<-gsub("  "," ",X_train)
        write_file(X_train,"./UCI HAR Dataset/train/X_train_withOneSpace.txt")
        X_train<-read.table("./UCI HAR Dataset/train/X_train_withOneSpace.txt",
                            sep=" ", fill=TRUE) %>%
                select(-1)
        #print("dim(X_train):")
        #print(dim(X_train))
        
        
        
        
        
        subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",
                                  sep=" ", fill=TRUE,
                                  col.names=c("id"))
        #print("dim(subject_test):")
        #print(dim(subject_test))
        activity_test<-read.table("./UCI HAR Dataset/test/y_test.txt",
                                   sep=" ", fill=TRUE,
                                   col.names=c("Activity_label"))
        #print("dim(activity_test):")
        #print(dim(activity_test))
        
        X_test<-read_file("./UCI HAR Dataset/test/X_test.txt")
        X_test<-gsub("  "," ",X_test)
        write_file(X_test,"./UCI HAR Dataset/test/X_test_withOneSpace.txt")
        X_test<-read.table("./UCI HAR Dataset/test/X_test_withOneSpace.txt",
                            sep=" ", fill=TRUE, ) %>%
                select(-1)
        #print("dim(X_test):")
        #print(dim(X_test))
        
        for (i in 1:ncol(X_train)){
                colnames(X_train)[i]<-paste("Measurement_",i,sep="")
                colnames(X_test)[i]<-paste("Measurement_",i,sep="")
        }
        data<-rbind(X_train,X_test)
        #print("dim(data)")
        #print(dim(data))
        #print(data[1:4,1:10])
        
        
        activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt",
                                    sep=" ", fill=TRUE,
                                    col.names=c("label","Activity"))
        #print("dim(activity_labels):")
        #print(dim(activity_labels))
        
        
        
        
        result_mean<-sapply(data,mean)
        result_std<-sapply(data,sd)
        result<-rbind(result_mean,result_std)
        #print("dim(result)")
        #print(dim(result))
        print("The mean and standard deviation of the first five measurements:")
        print(result[,1:5])
        
        
        
        
        
        
        merged_train_act<-merge(activity_train,activity_labels,
                                by.x="Activity_label",by.y="label",all=TRUE)
        #print("dim(merged_train_act)")
        #print(dim(merged_train_act))
        #print("colnames(merged_train_act)")
        #print(colnames(merged_train_act))
        merged_train<-cbind(subject_train,merged_train_act,X_train) %>%
                      select(-Activity_label)
        #print("dim(merged_train)")
        #print(dim(merged_train))
        #print(colnames(merged_train))       
        
        
        merged_test_act<-merge(activity_test,activity_labels,
                               by.x="Activity_label",by.y="label",all=TRUE)
        #print("dim(merged_test_act)")
        #print(dim(merged_test_act))
        #print("colnames(merged_test_act)")
        #print(colnames(merged_test_act))
        merged_test<-cbind(subject_test,merged_test_act,X_test) %>%
                     select(-Activity_label)
        #print("dim(merged_test)")
        #print(dim(merged_test))
        #print("merged_test:")
        #print(merged_test[1:2,1:6])
        #print(merged_test[1:2,560:563])
                
        
        
        data2<-rbind(merged_train,merged_test) %>%
              gather("col","Accelerate",-id,-Activity) %>%
              select(-col) %>%
              group_by(Activity,id)
        #print("dim(data2)")
        #print(dim(data2))
        #print("conames(data2)")
        #print(colnames(data2))
        #print(data)
        
        result2<-summarise(data2, mean=mean(Accelerate)) %>%
                 arrange(Activity,id)
        print(result2,n=Inf)
        
        write.table(result2,file="result_dataset_of_5th_task.txt",row.name=FALSE)
        
        #print("dim(data)")
        #print(dim(data))
        #print(data[1:20,])
        
        
        
}
