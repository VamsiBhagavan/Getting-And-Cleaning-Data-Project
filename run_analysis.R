X_test <- read.table("X_test.txt")
X_train <- read.table("X_train.txt")
X <- rbind(X_test,X_train)

col_names <- read.table("features.txt")
col_names$V2 <- as.character(col_names$V2)
colnames(X) <- col_names$V2

colnames(X) <- gsub("\\(|\\)", "",names(X))
X1 <- X[,grepl("mean|std",names(X))]

y_test <- read.table("y_test.txt")
y_train <- read.table("y_train.txt")
y <- rbind(y_test,y_train)
activity_labels <- read.table("activity_labels.txt")
y <- merge(y,activity_labels,by = "V1",sort= FALSE)
colnames(y)[2] <- "activity_labels"

subject_test <- read.table("subject_test.txt",col.names ="Subject")
subject_train <- read.table("subject_train.txt",col.names ="Subject")
subject <- rbind(subject_test,subject_train)

X1 <- cbind(X1,y$activity_labels)
colnames(X1)[80] <- "activity_labels"
X1 <- cbind(X1,subject)

t <- aggregate(X1,by= list(X1$activity_labels,X1$Subject),FUN="mean")
write.table(t,file ="output.txt",sep = ",",eol="\n", row.names = F)