# churn42
_Predicting churn in telco industry_

I have been tasked to have a deeper look into that problem and in particular to
predict churn for the next quarter (Q3 2021). In other words, the task consists
in identifying which customers are most likely going to churn in the next
quarter. By doing so, the company can proactively do its best to avoid
customers from churning - by for instance proposing customers with a better
deal.

Howto: this is mostly a graphical drilldown and a model in the end. The code is
in the /script directory.

# descriptive stats

## target variable

The churn rate in the data set is around 25%.
<img alt="Churn Rate" src="figs/20220204_predictor_Churn-distribution.png?raw=true" width="400">

## predictors

What do the other variables say?


## demographics

<img alt="Dependents" src="figs/20220204_predictor_Dependents-distribution.png?raw=true" width="400">
A 5-to-2 ratio of customers without and with dependents.

<img alt="Partner" src="figs/20220204_predictor_Partner-distribution.png?raw=true" width="400">
Around half of the customers have partners.

<img alt="SeniorCitizen" src="figs/20220204_predictor_SeniorCitizen-distribution.png?raw=true" width="400">
The share of seniors among the customers seems to be roughly similar to the general population.

<img alt="gender" src="figs/20220204_predictor_gender-distribution.png?raw=true" width="400">
Customers' gender is quite balanced. 

## contract features 

<img alt="Contract" src="figs/20220204_predictor_Contract-distribution.png?raw=true" width="400">
A lot of the clients have month-to-month (prepaid?) contracts.

<img alt="Device Protection" src="figs/20220204_predictor_DeviceProtection-distribution.png?raw=true" width="400">
Not so sure why there's a "no internet service" here. Might be joined with the "no" value, but I'll leave it for now.

<img alt="InternetService" src="figs/20220204_predictor_InternetService-distribution.png?raw=true" width="400">
Almost half of the customers have Fiber optic, and 1500/7000 have no internet service. Is that an ancient dataset?

<img alt="PhoneService" src="figs/20220204_predictor_PhoneService-distribution.png?raw=true" width="400">
90% of the customers have phone service.

<img alt="OnlineBackup" src="figs/20220204_predictor_OnlineBackup-distribution.png?raw=true" width="400">
Most of the customers do not have online backup or even no internet service.

<img alt="OnlineSecurity" src="figs/20220204_predictor_OnlineSecurity-distribution.png?raw=true" width="400">
Most of the customers do not have online security or even no internet service.

<img alt="StreamingTV" src="figs/20220204_predictor_StreamingTV-distribution.png?raw=true" width="400">
<img alt="StreamingMovies" src="figs/20220204_predictor_StreamingMovies-distribution.png?raw=true" width="400">
Streaming TV and Movies seem to be in the same package, which makes sense.

<img alt="TechSupport" src="figs/20220204_predictor_TechSupport-distribution.png?raw=true" width="400">
Half of the customers haven't needed tech support and a lot don't have internet service and therefore don't need tech support (?).

## payment stuff

<img alt="PaperlessBilling" src="figs/20220204_predictor_PaperlessBilling-distribution.png?raw=true" width="400">
The majority of customers has paperless billing.

<img alt="PaymentMethod" src="figs/20220204_predictor_PaymentMethod-distribution.png?raw=true" width="400">
Around one third of the customers pay by electronic check, the rest is evenly distributed over the other options.

<img alt="MonthlyCharges" src="figs/20220204_predictor_MonthlyCharges-distribution.png?raw=true" width="400">
1400 of 7000 customers pay up to 25 (currency units) a month, the rest is quite spread out up to around 120.

<img alt="TotalCharges" src="figs/20220204_predictor_TotalCharges-distribution.png?raw=true" width="400">

Long-tail distribution. A large share of customers (presumably also the ones
with short tenure) have low total charges, the rest stay for longer and pay
more over time

## duration of contract

<img alt="tenure" src="figs/20220204_predictor_tenure-distribution.png?raw=true" width="400">
A fun distribution, ranging from zero to 72 months.

# descriptive with relation to churn

If we split up the dataset into *churn=yes* and *churn=no* and compare the distributions of 
each of the variables between those subgroups, this will give an idea of the direction that
some of the features could be changed to reduce churn.

## contract features

<img alt="Contract" src="figs/20220205_churngroups_predictor_Contract-distribution.png?raw=true" width="400">
The churn quota is highest among the month-to-month contracts, which should be expected. Try to
upgrade those clients to fixed-duration contracts.

# predictive model 


