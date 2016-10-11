Lending Club Slide Deck Presentation
========================================================
author: Minh Truong
date: 10/5/2016
autosize: true

1) Lending Club's Recent Problem
========================================================
Lending Club is a new Peer2Peer Platform that connects lenders with borrowers or  Kickstarter for personal loans!

Problem: http://www.bloomberg.com/news/features/2016-08-18/how-lending-club-s-biggest-fanboy-uncovered-shady-loans
- Questionable shady loans uncovered that may undermine the system
- Stock Price Dropped $15 to $5 overnight
- CEO Laplanche Resigns
- Are there Other hidden or unknown risks?
2) The Danger of Bad Loans 11x more than Good Loans
========================================================

```r
# average_good_loan_prof
#[1] 1100.512
# 
# average_bad_loan_prof <- (sum(bad_loans_data$total_pymnt)- sum(bad_loans_data$loan_amnt))/nrow(bad_loans_data)
#  
# average_bad_loan_prof
#[1] -11907.74
#
# -11907.74/1100.512
#[1] -10.82018
```
-Can potentially wipe out any gains! Will need 12 good loans for every 1 bad to break even on principal. Thats not counting the opportunity cost lost and any time/efforts lost. Without lenders who can invest the platform will be quickly be worthless!

Good News is we have a Model to Predict Bad Loans
========================================================
LC_filtered_log9 = glm(bad_loans ~ total_pymnt + collections_12_mths_ex_med + revol_bal + open_acc + term + sub_grade, data = LC_filtered_Train, family = binomial)
- It tells us an interesting picture on why people fail to pay and ways for Lending Club to mitigate this risk. It may unlucky people or liars!

Recommendations
===========================================================
It seems what seems to be "safe" loans may be riskier.

- Add gentle ways to encourage earlier payments with fee discounts or other incentives
- Take a closer look at the Grade A-B loans that seem to be safe may actually a higher tier but not uncovered yet.
- External Macroeconomic factors like the current low interest environment may not stay low forever, this may attrract borrowers who normally wouldn't borrow but has incentives to.
