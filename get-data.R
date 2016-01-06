### get data for Best and Worst Places to Grow Up ###
library (xlsx)
library(dplyr)

# Two methods for reading data: 1.from the original xlsx dataset and produce a csv file
# 2. from the manually manipulated dataset in csv form.

### First method, from the xlsx file ###
Places_Data<-read.xlsx2("data/Estimates_for_All_Counties.xlsx",  sheetIndex=1, startRow=5, colIndex=1:4, stringsAsFactors=FALSE, header=TRUE)
name_temp<-read.xlsx2("data/Estimates_for_All_Counties.xlsx",  sheetIndex=1,  endRow=1,  colIndex=1,
stringsAsFactors=FALSE, header=FALSE) # Extracting the Excel file title to name a column
names(Places_Data)[c(1,4)]<- c("Rank",name_temp)
Places_Data[,1]<- as.numeric(Places_Data[,1])
Places_Data[,4]<- as.numeric(Places_Data[,4])*100 # multiplied by 100 for the sake of % scale
write.csv(Places_Data, file = "data/Household_Income.csv", row.names = FALSE)
data<- read.csv("data/Household_Income.csv", header=TRUE, stringsAsFactors=FALSE)

### Second method, from the csv file ###
Places_Data<- read.csv("data/Estimates_Counties.csv", header=TRUE, stringsAsFactors=FALSE)
Places_Data[,4]<- as.numeric(gsub("%","",Places_Data[,4])) # Remove the "%" from the response column and make it numeric
write.csv(Places_Data, file = "data/Household_Income.csv", row.names = FALSE)
data<- read.csv("data/Household_Income.csv", header=TRUE, stringsAsFactors=FALSE)
