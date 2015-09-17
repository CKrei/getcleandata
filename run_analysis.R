#Getting and Cleaning Data - Programming Assignment
rm(list=ls())

require(downloader)
require(dplyr)

#Please change the path-variable to the one where you want to 
# setwd("")
path <- getwd()

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(url, dest="dataset.zip", mode="wb") 
unzip("dataset.zip")

setwd("./dataset/UCI HAR Dataset")

list.files()

#Labels
varNames <- read.table("features.txt")

#Read data from training data
xTrain <- read.table("./train/X_train.txt")
names(xTrain) <- varNames[,2]
yTrain <- read.table("./train/y_train.txt")
names(yTrain) <- "Outcome"
subTrain <- read.table("./train/subject_train.txt")
names(subTrain) <- "Subject"
train <- cbind(subTrain, yTrain, xTrain)

#Read data from test data
xTest <- read.table("./test/X_test.txt")
names(xTest) <- varNames[,2]
yTest <- read.table("./test/y_test.txt")
names(yTest) <- "Outcome"
subTest <- read.table("./test/subject_test.txt")
names(subTest) <- "Subject"
test <- cbind(subTest, yTest, xTest)

#Merged data
data <- rbind(train, test)
data <- data[,-which(duplicated(names(data)))[1:(length(which(duplicated(names(data))))/2)]]

#Extract mean and standard deviation data
indMean <- grep("mean()", names(data))
indSub <- grep("Subject", names(data))
indOut <- grep("Outcome", names(data))
indSd <- grep("std()", names(data))
ind <- c(indSub, indOut, indMean, indSd)

data <- data[, ind]

data$Outcome[data$Outcome==1] <- "WALKING"
data$Outcome[data$Outcome==2] <- "WALKING_UPSTAIRS"
data$Outcome[data$Outcome==3] <- "WALKING_DOWNSTAIRS"
data$Outcome[data$Outcome==4] <- "SITTING"
data$Outcome[data$Outcome==5] <- "STANDING"
data$Outcome[data$Outcome==6] <- "LAYING"

###
groupData <- data %>%
  group_by(Outcome, Subject) %>%
  summarize_each(funs(mean))

View(groupData)

###
#Please change the working directory to the one where you want to 
setwd("C:/Users/AV01TR2/Documents/getcleandata")
write.csv(groupData, "resultData.csv")

