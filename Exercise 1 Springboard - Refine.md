# data-science
#--Refine Exercise 1--
## "0: Load the data in RStudio"
## load dplyr and import data + check structure 

> library(dplyr)
> library(tidyr)
> db <- read.csv("refine.csv")
> str(db)

## lets see what company has! 
## cleaned.refined will hold the cleaned up data

cleaned.refined <- db
company <- db$company
View(company)

## "1: Clean up brand names"
##seems there are misspellings of company names 
##philips, akzo, van houten and unilever
## seems we can do a few expression matches to correct them to the company ##object we created  

> akzo <- grep("ak",company)
> company[akzo] = "akzo"

> van.houten <- grep("van",company)
> company[van.houten] = "van houten"

> unilever <- grep("uni",company)
> company[unilever] = "unilever"
 
> philiphs <- grep("ph",company)
> company[philiphs] = "philips 

> philiphs.2 <- grep("f",company)
company[philiphs.2] = "philiphs"
 
> cleaned.refined$company <- company

## "2: Separate product code and number""
##separate Product.code...number column into 2 columns "product_code" and ##"product_number"
 
> cleaned.refined <- db %>% separate (Product.code...number, c("product_code","product_number"),"\\-")

View(cleaned.refined)
## looks good so far but needs to fix the naming codes to
## p = Smartphone
## v = TV
## x = Laptop
## q = Tablet

> product_code <- cleaned.refined$product_code

> smartphone <- grep("p",product_code)
> product_code[smartphone] = "Smartphone"

> tv <- grep("v",product_code)
> product_code[tv] = "TV"

> laptop <- grep("x",product_code)
> product_code[laptop] = "Laptop"

> tablet <- grep("q",product_code)
> product_code[tablet] = "Tablet"

## brings cleaned up product_code data to the cleaned refine data set

> cleaned.refined$product_code <- product_code

## 4: Add full address for geocoding
## setting up variable strings to get full address
 
> address <- db$address
> city <- db$city
> country <- db$country
 
## Combine address info to full_address
 
> full_address <-paste(address,city,country, sep =", ", collapse = NULL)
 
> cleaned.refined["full_address"] = NA
> cleaned.refined$full_address <- full_address
> View(cleaned.refined)

## 5: Create dummy variables for company and product category
## lets create the dummy variables
## company_philips, company_akzo, company_van_houten and company_unilever
## product_smartphone, product_tv, product_laptop and product_tablet


##create the new columns needed

> cleaned.refined["company_philips"] = 0
> cleaned.refined["company_akzo"] = 0
> cleaned.refined["company_van_houten"] = 0
> cleaned.refined["company_unilever"] = 0

> company_philips <- cleaned.refined$company_philiphs
> company_akzo <- cleaned.refined$company_akzo
> company_van_houten <- cleaned.refined$van_houten
> company_unilever <- cleaned.refined$unilever

> company_philiphs[philiphs] = "1"
> company_philiphs[philiphs.2] = "1"
> company_akzo[akzo] ="1"
> company_van_houten[van.houten] = "1"
> company_unilever[unilever] ="1"

> cleaned.refined$company_philiphs <- company_philips
> cleaned.refined$company_akzo <- company_akzo
> cleaned.refined$company_van_houten <- company_van_houten
> cleaned.refined$company_unilever<- company_unilever

## set up same with last 4 categories

cleaned.refined["product_smartphone"] = 0
cleaned.refined["product_tv"] = 0
cleaned.refined["product_laptop"] = 0
cleaned.refined["product_tablet"] = 0

product_smartphone <- cleaned.refined$product_smartphone
product_tv <- cleaned.refined$product_tv
product_laptop <- cleaned.refined$product_laptop
product_tablet <- cleaned.refined$product_tablet

product_smartphone[smartphone] <- "1" 
product_tv[tv] <- "1"
product_laptop[laptop] <- "1"
product_tablet[tablet] <- "1"

cleaned.refined$product_smartphone <- product_smartphone
cleaned.refined$product_tv <- product_tv
cleaned.refined$product_laptop <- product_laptop
cleaned.refined$product_tablet <- product_tablet

View(cleaned.refined)

write.csv(cleaned.refined, file = "refine_clean.csv")