## Regression with binary outcomes
## ═════════════════════════════════

## Logistic regression
## ───────────────────────

##   This far we have used the `lm' function to fit our regression models.
##   `lm' is great, but limited–in particular it only fits models for
##   continuous dependent variables. For categorical dependent variables we
##   can use the `glm()' function.

##   For these models we will use a different dataset, drawn from the
##   National Health Interview Survey. From the [CDC website]:

##         The National Health Interview Survey (NHIS) has monitored
##         the health of the nation since 1957. NHIS data on a broad
##         range of health topics are collected through personal
##         household interviews. For over 50 years, the U.S. Census
##         Bureau has been the data collection agent for the National
##         Health Interview Survey. Survey results have been
##         instrumental in providing data to track health status,
##         health care access, and progress toward achieving national
##         health objectives.

##   Load the National Health Interview Survey data:

NH11 <- readRDS("dataSets/NatHealth2011.rds")
labs <- attributes(NH11)$labels

##   [CDC website] http://www.cdc.gov/nchs/nhis.htm

## Logistic regression example
## ───────────────────────────────

##   Let's predict the probability of being diagnosed with hypertension
##   based on age, sex, sleep, and bmi

str(NH11$hypev) # check stucture of hypev
levels(NH11$hypev) # check levels of hypev
# collapse all missing values to NA
NH11$hypev <- factor(NH11$hypev, levels=c("2 No", "1 Yes"))
# run our regression model
hyp.out <- glm(hypev~age_p+sex+sleep+bmi,
              data=NH11, family="binomial")
coef(summary(hyp.out))

## Logistic regression coefficients
## ────────────────────────────────────

##   Generalized linear models use link functions, so raw coefficients are
##   difficult to interpret. For example, the age coefficient of .06 in the
##   previous model tells us that for every one unit increase in age, the
##   log odds of hypertension diagnosis increases by 0.06. Since most of us
##   are not used to thinking in log odds this is not too helpful!

##   One solution is to transform the coefficients to make them easier to
##   interpret

hyp.out.tab <- coef(summary(hyp.out))
hyp.out.tab[, "Estimate"] <- exp(coef(hyp.out))
hyp.out.tab

## Generating predicted values
## ───────────────────────────────

##   In addition to transforming the log-odds produced by `glm' to odds, we
##   can use the `predict()' function to make direct statements about the
##   predictors in our model. For example, we can ask "How much more likely
##   is a 63 year old female to have hypertension compared to a 33 year old
##   female?".

# Create a dataset with predictors set at desired levels
predDat <- with(NH11,
                expand.grid(age_p = c(33, 63),
                            sex = "2 Female",
                            bmi = mean(bmi, na.rm = TRUE),
                            sleep = mean(sleep, na.rm = TRUE)))
# predict hypertension at those levels
cbind(predDat, predict(hyp.out, type = "response",
                       se.fit = TRUE, interval="confidence",
                       newdata = predDat))

##   This tells us that a 33 year old female has a 13% probability of
##   having been diagnosed with hypertension, while and 63 year old female
##   has a 48% probability of having been diagnosed.

## Packages for  computing and graphing predicted values
## ─────────────────────────────────────────────────────────

##   Instead of doing all this ourselves, we can use the effects package to
##   compute quantities of interest for us (cf. the Zelig package).

library(effects)
plot(allEffects(hyp.out))

## Exercise: logistic regression
## ───────────────────────────────────

##   Use the NH11 data set that we loaded earlier.

##   1. Use glm to conduct a logistic regression to predict ever worked
##      (everwrk) using age (age_p) and marital status (r_maritl).
##   2. Predict the probability of working for each level of marital
##      status.

##   Note that the data is not perfectly clean and ready to be modeled. You
##   will need to clean up at least some of the variables before fitting
##   the model.
new.data <-subset(NH11, select = c("everwrk","age_p", "r_maritl"))
everworked <- new.data$everwrk

for (i in 1:33014) { 
  if (is.na(new.data$everwrk[i]) == TRUE) {
  new.data$everwrk[i] <- "8 Not ascertained"
  }
    }
##clean up everwork
everworked.model <- glm(everwrk~age_p+r_maritl,
                                        data=new.data, family="binomial")

library(tidyr)

##Coefficients:
##(Intercept)                                        age_p  
## 3.25232                                     -0.05077  
##r_maritl2 Married - spouse not in household                            r_maritl4 Widowed  
##-0.07845                                     -0.54348  
##r_maritl5 Divorced                          r_maritl6 Separated  
##-0.07436                                     -0.29332  
##r_maritl7 Never married                r_maritl8 Living with partner  
##-0.43318                                     -0.23673  
##r_maritl9 Unknown marital status  
##-0.11062  

##Degrees of Freedom: 33013 Total (i.e. Null);  33005 Residual
##Null Deviance:	    43440 
##Residual Deviance: 37710 	AIC: 37730
## coef(summary(everworked.model))
##                                           Estimate   Std. Error     z value     Pr(>|z|)
# (Intercept)                                  3.25232483 0.0506331817  64.2330724 0.000000e+00
## age_p                                       -0.05077185 0.0008856309 -57.3284554 0.000000e+00
## r_maritl2 Married - spouse not in household -0.07844915 0.0998736146  -0.7854843 4.321697e-01
## r_maritl4 Widowed                           -0.54348189 0.0486842367 -11.1634059 6.158607e-29
## r_maritl5 Divorced                          -0.07436428 0.0371683878  -2.0007401 4.542040e-02
## r_maritl6 Separated                         -0.29331727 0.0679369434  -4.3174929 1.578115e-05
## r_maritl7 Never married                     -0.43318442 0.0357569647 -12.1146866 8.830099e-34
## r_maritl8 Living with partner               -0.23672537 0.0577291870  -4.1006184 4.120475e-05
## r_maritl9 Unknown marital status            -0.11062054 0.2529561855  -0.4373111 6.618858e-01
