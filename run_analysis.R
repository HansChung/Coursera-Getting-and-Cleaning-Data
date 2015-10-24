#download file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#unzip file and rename the folder to UCIHAR
# 1. Read the data files:
library(reshape2)
setwd("C:/R") # set up file folder
xtest <- read.table("./UCIHAR/test/X_test.txt")
ytest <- read.table("./UCIHAR/test/Y_test.txt")
subtest <- read.table("./UCIHAR/test/subject_test.txt")

xtrain <- read.table("./UCIHAR/train/X_train.txt")
ytrain <- read.table("./UCIHAR/train/Y_train.txt")
subtrain <- read.table("./UCIHAR/train/subject_train.txt")

features <- read.table("./UCIHAR/features.txt")
activities <- read.table("./UCIHAR/activity_labels.txt")

# 2. Merge all data
xall <- rbind(xtrain, xtest)
yall <- rbind(ytrain, ytest)
suball <- rbind(subtrain, subtest)
all <- cbind(suball, yall, xall)

rm(xtest,ytest,xtrain,ytrain,subtrain,subtest,xall,yall,suball)  # cleaning data

# 3. Name the measurement columns
featureNames <- as.character(features[,2])
newCols <- c("subject", "activity", featureNames)
newCols <- gsub('[-()]', '', newCols) # cleaning colnames
colnames(all) <- newCols

# 4. Create a new data frame

ShowMeans <- grep("mean()", colnames(all))
ShowStDevs <- grep("std()", colnames(all))
Columns1 <- c(ShowMeans, ShowStDevs)
revisedColumns <- sort(Columns1) 
newFrame <- all[, c(1,2,revisedColumns)]
latestFrame <- newFrame[, !grepl("Freq", colnames(newFrame))]

# 5. Trim the rows to show mean values for each subject-activity pair
smallframe <- data.frame()
for (i in 1:30) {
  subj<- subset(latestFrame,subject==i)
  for (j in 1:6){
    actv<- subset(subj, activity==j)
    mydata<-as.vector(apply(actv,2,mean))
    smallframe<-rbind(smallframe,mydata) 
  }
  
}

# 6. Rename and write the data into "tindyData.txt"
colnames(smallframe)<-colnames(latestFrame) #rename the columns again
levels(smallframe[,2])<-c('walk','upstairswalk','downstairswalk', 'sit','stand', 'lay') # from activities_lables
write.table(smallframe, "tidyData.txt", row.names = FALSE, quote = FALSE)

