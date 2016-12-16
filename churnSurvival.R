# DATA PREPARATION

library(survival)
library(ggplot2)
library(ggfortify)
library(survminer)
library(survMisc)

churn <- read.csv("D:/Projects/datasets/mobile/datasets/churn.txt")
s <- churn
attach(s)

# main parameters ofthe survival analysis

# Note: to choose the right predictors (independent variables) we can use the results  
# given by the the correlation matrix of the same data set from the churn prediction problem
# in order to get the features that account for the most of the variability in dependent variable.
# We will only add Area.Code as a predictor in the survival analysis afterwards:

# Correlation matrix                
# [16,] "int_calls"     "0.2052"
# [17,] "int_charge"    "0.2087"
# [18,] "service_calls" "0.2599"
# [19,] "choice"        "1"    

time <- Account.Length
event <- as.numeric(as.factor(Churn.))
X <- cbind(Area.Code, calls, Int.l.Plan, VMail.Plan, Intl.Charge)
group <- Int.l.Plan

# some transformations

event <- ifelse(event==1,0,1)
s$Int.l.Plan <- ifelse(s$Int.l.Plan=='no',0,1)
s$VMail.Plan <- ifelse(s$VMail.Plan=='no',0,1)
names(s)[20] <- 'calls'
names(s)[21] <- 'event'
names(s)[2] <- 'time'
s$event <- ifelse(s$event=="False.",0,1)

# set service calls threeshold to >3 ?

# SURVIVAL ANALYSIS

# Kaplan-Meier function (non-parametric)

# without groups
fitKaplan1 <- survfit(Surv(time, event) ~ 1)
summary(fitKaplan1)
autoplot(fitKaplan1)

# with international plan grouping
fitKaplan2 <- survfit(Surv(time, event) ~ Int.l.Plan)
summary(fitKaplan2)

# plot 1
autoplot(fitKaplan2)

# plot 2
ggsurvplot(fitKaplan2, risk.table = TRUE)

#plot 3
plot(fitKaplan2, col=c("orange","purple"), lty=c(1:2), lwd=3,
     conf.int = TRUE, xmax = 2000,
     xlab='Time', ylab='Survival probability',
     main='Probability of customer to leave the company depending on int.plan')
legend(20, .5, c("No int.plan", "With int.plan"), 
       lty = c(1:2), col=c("orange","purple"))

#plot4
# survMisc:::autoplot.survfit(fitKaplan2)

# Cox proportional hazard model - coefficients and hazard rates (semi-parametric)

fitCoxph <- coxph(Surv(time,event)~ X, method='breslow')
summary(fitCoxph)

# OTHER METHODS

# Nelson-Aalen non-parametric analysis

fitNelson <- survfit(coxph(Surv(time,event)~1), type='aalen')
summary(fitNelson)
plot(fitNelson, xlab='Time', ylab='Survival probability')
autoplot(fitNelson)

fitNelson1 <- survfit(coxph(Surv(time,event)~X), type='aalen')
summary(fitNelson1)
plot(fitNelson1, xlab='Time', ylab='Survival probability')
autoplot(fitNelson1)

# exponential

fitExp <- survreg(Surv(time,event)~X, dist = 'exponential')
summary(fitExp)

# weibull

fitWeibull <- survreg(Surv(time,event)~X, dist = 'weibull')
summary(fitWeibull)

# log-logistic

fitLog <- survreg(Surv(time,event)~X, dist = 'loglogistic')
summary(fitLog)
