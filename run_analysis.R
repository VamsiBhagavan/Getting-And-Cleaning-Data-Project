# Reading test and training set files and adding them into file
X_test <- read.table("X_test.txt")
X_train <- read.table("X_train.txt")
X <- rbind(X_test,X_train)
# Changing the column names as per the nomenclature in features
col_names <- read.table("features.txt")
col_names$V2 <- as.character(col_names$V2)
colnames(X) <- col_names$V2
# Subset only the measurements that has mean and std deviation
colnames(X) <- gsub("\\(|\\)", "",names(X))
X1 <- X[,grepl("mean|std",names(X))]
# Reading activities and concatinating the files 
y_test <- read.table("y_test.txt")
y_train <- read.table("y_train.txt")
y <- rbind(y_test,y_train)
activity_labels <- read.table("activity_labels.txt")
y[,1] <- activity_labels[y[,1],2]
colnames(y)[1] <- "activity_labels"
# Reading subject and concatinating the files 
subject_test <- read.table("subject_test.txt",col.names ="Subject")
subject_train <- read.table("subject_train.txt",col.names ="Subject")
subject <- rbind(subject_test,subject_train)
# Adding subject and activity columns to the main data set
X1 <- cbind(X1,y$activity_labels)
colnames(X1)[80] <- "activity_labels"
X1 <- cbind(X1,subject)
X1$Subject <- as.factor(X1$Subject)
# Calculating the average and then exporting the dataset to text file
tidy <- aggregate(X1,by= list(X1$activity_labels,X1$Subject),FUN="mean")
write.table(tidy,file ="tidy.txt",sep = ",",eol="\n", row.names = F)