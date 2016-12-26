# Resuls interpretation

In order to understand the results, we need to present and compute some basic parameters of this analysis:

* Total number of subjects: 3.333
* Total number of failures (churning customers): 483
* Number of fails (churns): 14.49% (percentage of churn customers with regard to a total number of customers observed)
* Time to risk (sum of all periods in a 'time' variable): 336.849
* Incidence rate: 0.14% (number of churns in respect to the total time, or time to risk)
* Hazard rate (probability of the event to churn or not to churn)

1. Kaplan-Meier analysis

fitKaplan2 <- survfit(Surv(time, event) ~ Int.l.Plan)

and the summary of the fitted model is given per observed group (variable international plan):

summary(fitKaplan2)
   
Results in a table shows that many of the customers who choose the mobile package with international plan are likely to abandoned 
the company,  while larger part of the customers (34.9%) who didn't choose international package, have bigger probability to stay
(columns 'survival' in the second table remaining row shows 0.349). 
  
2. Cox proportional hazards function:
  
coxph(formula = Surv(time, event) ~ X, method = "breslow")

Results from the table indicate and confirm the intenational package (Int.l.Plan) being the critical determining factor
for leaving the company. Apart from Area.Code, all other factors are significant (z Pr(>|z|)).

* Coefficients in the column 'coef' with positive figures (>0) means the bigger probability to leave the company.
* Coefficients in a second column 'exp(coef)' represent the hazard rates, minus 1. 

Explanation:  Xcalls represents service calls, and the hazard rate is 0.297 - 1 = .703, meaning: each unit of increase of number of 
service calls is associated with 70% of hazard rate, or probability to churn.

Cox proportional hazard function proved to give most consistend results across different statistical platforms. 
