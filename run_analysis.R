run_analysis <-function(){
        
        subject_train<-read.table("./train/subject_train.txt",
                                  sep=" ", fill=TRUE,
                                  col.names=c("id"))
        activity_train<-read.table("./train/y_train.txt",
                                   sep=" ", fill=TRUE,
                                   col.names=c("Activity_label"))
        X_train<-read_file("./train/X_train.txt")
        X_train<-gsub("  "," ",X_train)
        write_file(X_train,"./train/X_train_withOneSpace.txt")
        X_train<-read.table("./train/X_train_withOneSpace.txt",
                            sep=" ", fill=TRUE) %>%
                select(-1)
        
        
        
        
        
        subject_test<-read.table("./test/subject_test.txt",
                                  sep=" ", fill=TRUE,
                                  col.names=c("id"))
        activity_test<-read.table("./test/y_test.txt",
                                   sep=" ", fill=TRUE,
                                   col.names=c("Activity_label"))
        X_test<-read_file("./test/X_test.txt")
        X_test<-gsub("  "," ",X_test)
        write_file(X_test,"./test/X_test_withOneSpace.txt")
        X_test<-read.table("./test/X_test_withOneSpace.txt",
                            sep=" ", fill=TRUE, ) %>%
                select(-1)
        
        
        for (i in 1:ncol(X_train)){
                colnames(X_train)[i]<-paste("Measurement_",i,sep="")
                colnames(X_test)[i]<-paste("Measurement_",i,sep="")
        }
        data<-rbind(X_train,X_test)
        
        
        
        activity_labels<-read.table("./activity_labels.txt",
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
