#setwd("~/Code/data-cleaning/data/UCI HAR Dataset") # My local directory
library(dplyr)
#activities names (in order)
activities <- c("WALKING",
                "WALKING_UPSTAIRS",
                "WALKING_DOWNSTAIRS",
                "SITTING",
                "STANDING",
                "LAYING")
#this gets features names
feature_names <- read.table("./features.txt")
#This function abstracts the functionality of data gathering
#so as to only change the name of the directory with a parameter
get_dataset <- function(dir = "test"){
        #build general path
        nm <- paste0("./", dir) 
        #get files with full path
        files <- list.files(path = nm, pattern = "\\.txt")
        files <- paste(nm, files, sep="/")
        #load subject data
        subject <- read.table(files[1], col.names = "subject")
        #Get the bulk of the date and naming in with feature_names
        X <- read.table(files[2], col.names = feature_names[,2])
        #select only mean & std
        X <- X[,grepl("(mean|std)[^Freq]", names(X))] 
        #load results without proper label
        y <- read.table(files[3], col.names = "y")
        #set proper label (activities names)
        for(j in 1:6){
                y[y==j] <- activities[j]
        }
        #paste the data together
        cbind(subject, X, y)
}
#get test data
test <- get_dataset()
#get train data
train <- get_dataset(dir = "train")
#paste the data together
dataset <- rbind(test, train)
#group and average features, grouped by activity
dataset_2 <- aggregate(dataset[,2:67], list(dataset$y), mean)

write.table(dataset_2, file = "./dataset_step5.txt", row.names = FALSE)
