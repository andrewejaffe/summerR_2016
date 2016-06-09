## 140.886: Intro to R
## Homework 2
## Assigned Date: 1/4/2016
## Due Date: 1/6/2016

# Instructions: 
# 1)	Get the dataset: http://www.aejaffe.com/winterR_2016/data/kaggleCarAuction.zip
# 2)	Read the "dictionary": http://www.aejaffe.com/winterR_2016/data/Carvana_Data_Dictionary.txt
# This is a dataset from the "Kaggle" website, which hosts competitions for prediction and machine learning. 
# More details on this dataset are here: 
# http://www.kaggle.com/c/DontGetKicked/details/Background


# Questions 
# 1)	Read in the dataset itself, naming the R object "cars" into R (as separate objects). 
### Save them together in an ".rda" file so you can access the data offline. 
cars = read.csv("../data/kaggleCarAuction.csv",header=TRUE,as.is=TRUE)

library(stringr)
library(dplyr)
key = read.delim("http://www.aejaffe.com/winterR_2016/data/Carvana_Data_Dictionary.txt",
	as.is=TRUE, strip.white=TRUE)
save(cars,key,file="kaggle.rda")

# 2)	How many cars are in the dataset? How many variables are recorded for each car?
dim(cars)

# 3)	What is the range of the manufacturer's years of the vehicles? How many cars were from before 2004, and what percent/proportion of the cars are these older models?
range(cars$VehYear)
sum(cars$VehYear < 2004)
mean(cars$VehYear < 2004)

# 4)	Drop any vehicles that cost less than $1000 - how many vehicles were removed, and how much were they? The rest of the questions expect answers based on this reduced dataset.
cars = filter(cars, VehBCost > 1000)
dim(cars)

# 5)	How many different vehicle a) manufacturers/makes b) models and c) sizes are there?
length(unique(cars$Make)) # a
length(table(cars$Make))
length(unique(cars$Model)) # b
length(unique(cars$Size)) # c

# 6)	Which vehicle a) make, b) model and c) color had the highest average acquisition cost paid for the vehicle at time of purchase, and what was this cost?
makeTab = tapply(cars$VehBCost, cars$Make, mean)
makeTab[which.max(makeTab)] # a

modelTab = tapply(cars$VehBCost, cars$Model, mean)
modelTab[which.max(modelTab)] # b

colorTab = tapply(cars$VehBCost, cars$Color, mean)
colorTab[which.max(colorTab)] # c

# 7)	Which vehicle a) make, b) model and c) color had the highest variability in acquisition cost paid for the vehicle at time of purchase?
makeTab2 = tapply(cars$VehBCost, cars$Make, sd)
makeTab2[which.max(makeTab2)] # a

modelTab2 = tapply(cars$VehBCost, cars$Model, sd)
modelTab2[which.max(modelTab2)] # b

colorTab2 = tapply(cars$VehBCost, cars$Color, sd)
colorTab2[which.max(colorTab2)] # c

# 8)	Display the relationship between acquisition cost and mileage, and describe this relationship
plot(VehBCost ~ VehOdo, data=cars)
plot(log2(VehBCost) ~ VehOdo, data=cars)
smoothScatter(cars$VehOdo, log2(cars$VehBCost))

# 9)	Which variables of cost, odometer reading, and/or warranty (if any) visually appear to associate with a car being a "lemon"/bad purchase?
boxplot(VehBCost ~ cars$IsBadBuy, data=cars,ylab="Cost")
boxplot(VehOdo ~ cars$IsBadBuy, data=cars, ylab= "Odometer")
boxplot(WarrantyCost ~ cars$IsBadBuy, data=cars, ylab="Warranty")

# 10)	 How many vehicles:
# a.	Were red and have fewer than 50,000 miles?
sum(cars$Color == "RED" & cars$VehOdo < 50000)

# b.	Are made by GMC and were purchased in Florida? 
sum(cars$Make == "GMC" & cars$VNST == "FL")

# c.	Are green or white?
sum(cars$Color == "GREEN" | cars$Color == "WHITE" )
sum(cars$Color %in% c("GREEN","WHITE"))

# d.	Are made by Mazda or Nissan and are black or silver? 
sum((cars$Make == "MAZDA" | cars$Make=="NISSAN") & (cars$Color == "GREEN" | cars$Color == "WHITE" ))
sum(cars$Make %in% c("MAZDA","NISSAN") & 
	cars$Color %in% c("BLACK","SILVER" ))

# e.	Are automatic, blue, Pontiac cars with under 60,000 miles? 
sum(cars$Transmission == "AUTO" & cars$Color=="BLUE" & 
	cars$Make == "PONTIAC" & cars$VehOdo < 60000)
sum(cars$Transmission == "AUTO" & cars$Color=="BLUE" & 
	cars$Make == "PONTIAC" & cars$VehOdo < 60000)

	