# Resuls interpretation

In order to understand the results, we need to compute some basic parameters of this analysis:

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

 Int.l.Plan=0 
 time n.risk n.event survival  std.err lower 95% CI upper 95% CI
    1   3010       1    1.000 0.000332        0.999        1.000
   12   2982       1    0.999 0.000472        0.998        1.000
   13   2980       1    0.999 0.000579        0.998        1.000
   ...
  212     11       1    0.465 0.068008        0.349        0.619
  225      4       1    0.349 0.112829        0.185        0.657
  
 Int.l.Plan=1 
 time n.risk n.event survival std.err lower 95% CI upper 95% CI
    2    323       1   0.9969 0.00309       0.9909        1.000
   17    317       1   0.9938 0.00440       0.9852        1.000
   36    312       1   0.9906 0.00542       0.9800        1.000
   ...
  188      4       1   0.1525 0.06001       0.0705        0.330
  197      2       1   0.0763 0.06171       0.0156        0.372
  224      1       1   0.0000 0.00000       0.0000        0.000
   
Results in a table shows that many of the customers who choose the mobile package with international plan are likely to abandoned 
the company,  while larger part of the customers (34.9%) who didn't choose international package, have bigger probability to stay
(columns 'survival' in the second table remaining row shows 0.349). 
  
2. Cox proportional hazards function:
  
coxph(formula = Surv(time, event) ~ X, method = "breslow")

n= 3333, number of events= 483 

                   coef  exp(coef)   se(coef)      z Pr(>|z|)    
XArea.Code    0.0001437  1.0001437  0.0010723  0.134 0.893411    
Xcalls        0.2979573  1.3471042  0.0267789 11.127  < 2e-16 ***
XInt.l.Plan   1.2325960  3.4301225  0.1017284 12.117  < 2e-16 ***
XVMail.Plan  -0.7107998  0.4912511  0.1235273 -5.754 8.71e-09 ***
XIntl.Charge  0.2133862  1.2378626  0.0618676  3.449 0.000563 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Results from the table above indicate and confirm the intenational package (Int.l.Plan) being the critical determining factor
for leaving the company. Apart from Area.Code, all other factors are significant (z Pr(>|z|)).

* Coefficients in the column 'coef' with positive figures (>0) means the bigger probability to leave the company.
* Coefficients in a second column 'exp(coef)' represent the hazard rates, minus 1. 

Explanation:  Xcalls represents service calls, and the hazard rate is 0.297 - 1 = .703, meaning: each unit of increase of number of 
service calls is associated with 70% of hazard rate, or probability to churn.

Cox proportional hazard function proved to give most consistend results across different statistical platforms. 
