# Survival analysis

Survival analysis is a common name for a group of statistical methods with primary goal to determine the time (duration) of a subject 
to stay (survive) within the observed group.

More simple, if we have some statistical sample of observed customers in a mobile company, the survival analysis tries to compute 
the probability of their leaving / not leaving the company for some other competing company.

There are some terms to clarify, and in order to do that, we will use the same dataset provided in churn prediction analysis:

* Survivial - if the customer stays in the company, then he survived within the group (time to event is a synonym for survival analysis)
* Event (failure) - binary outcome, meaning: 0 (customer stays), and 1 (customer churns, or fails to stay in the group)
* Hazard rate - probability of customer to churn (the bigger the hazard rate, the lower the duration, or survival time)
* Subject (observed customer, a single observation in the samples)
* Time to risk: total time (duration) observed in the dataset
* Incidence rate: percentage of customers leaving the company / total time to risk

Types of variables:

* Pesponse (depentent) variables - time component (duration) and event (customer decision - churn/stay)
* Predictors (independent variables) - features within the dataset with high relative importance affecting customer's final choice

For particular problem, here is the setting:

* Dataset name: churn.txt
* Event - variable ['Churn.]' with binary decision True (churn) and False (stay)
* Time - duration, or time customer stayed within the company represented by the variable [Account.Length]
* Independent variables - will be determined by using correlation matrix [Int.l.Plan, VMail.Plan, Intl.Charge, service.calls]
* Group - a single, binary categorical variable serving to split the analysis in groups and compare their survival probability
          (in out example, we will use the variable [Int.l.Plan])

Main methods of the survival analysis:

* Parametric (Explonential, Weibull, Gompertz, Log-logistic)
* Non-parametric (Kaplan-Meier)
* Semi-parametric (Cox proportional hazards - PH regression analysis)

Statistically, survival analysis is a decreasing step function (of number of subjects survived) with simultaneously increase of time (duration).
