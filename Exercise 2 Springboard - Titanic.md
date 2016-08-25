# data-science
# Exercise 2 - Titanic-
## "0: Load the data in RStudio"
## load dplyr and import data + check structure 

library(dplyr)
library(tidyr)
library(ggplot2)
titanic <- read.csv("titanic_original.csv")
str(titanic)
View(titanic)

embarked <- titanic$embarked
embarked

## levels of details C Q S and Blank and most have embarked data

str(embarked)

ggplot(titanic, aes(x= embarked))+geom_bar()

missing_embarked <- grep("^$",embarked)
embarked[missing_embarked] = "S"
summary(embarked)

> titanic$embarked <- embarked
## 3. AGE

titanic_mean <- mean(titanic$age, na.rm = TRUE)

age <- titanic$age

age <- replace(age,is.na(age), titanic_mean)
titanic$age <- age
## Lifeboat

lifeboat <- titanic$boat
blank_lifeboat <- grep("^$",lifeboat)
lifeboat[blank_lifeboat] = NA
titanic$boat <- lifeboat

## Cabin seems to me a person with a cabin # survived as they can report it as they survived --or have proof it was their cabin--

titanic["has_cabin_number"]= "1"
has_cabin_number <- titanic$has_cabin_number
cabin <- titanic$cabin

cabin_missing_blank <- grep("^$",cabin)
cabin_missing_NA <- grep(NA,cabin)

has_cabin_number[cabin_missing_NA] = "0"
has_cabin_number[cabin_missing_blank] = "0"

titanic$has_cabin_number <- has_cabin_number

## if you compare the graphs of survived VS has cabin # they seem to be related
ggplot(titanic, aes( x = survived)) +geom_bar()
ggplot(titanic, aes( x = has_cabin_number)) +geom_bar()

write.csv(titanic, file = "clean_titanic.csv")

## saved cleaned up file