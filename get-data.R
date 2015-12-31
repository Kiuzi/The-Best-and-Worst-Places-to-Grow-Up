### get data for Best and Worst Places to Grow Up ###
library (xlsx)
library(dplyr)

# Two methods for reading data: 1.from the original xlsx dataset and produce a csv file
# 2. from the manually manipulated dataset in csv form.

### First method, from the xlsx file ###
data<-read.xlsx2("Estimates_for_All_Counties.xlsx",  sheetIndex=1, startRow=5, colIndex=1:4, stringsAsFactors=FALSE, header=TRUE)
name_temp<-read.xlsx2("Estimates_for_All_Counties.xlsx",  sheetIndex=1,  endRow=1,  colIndex=1,
                      stringsAsFactors=FALSE, header=FALSE) # Extracting the Excel file title to name a column
names(data)[c(1,4)]<- c("Rank",name_temp)
data[,1]<- as.numeric(data[,1])
data[,4]<- as.numeric(data[,4])*100 # multiplied by 100 for the sake of % scale
write.csv(data, file = "Household_Income.csv", row.names = FALSE)
data<- read.csv("Household_Income.csv", header=TRUE, stringsAsFactors=FALSE)

### Second method, from the csv file ###
data<- read.csv("Estimates_for_All_Counties.csv", header=TRUE, stringsAsFactors=FALSE)
data[,4]<- as.numeric(gsub("%","",data[,4])) # Remove the "%" from the response column and make it numeric
