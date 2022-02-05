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


### demographics

<img alt="Dependents" src="figs/20220204_predictor_Dependents-distribution.png?raw=true" width="400">
- A 5-to-2 ratio of customers without and with dependents.

<img alt="Partner" src="figs/20220204_predictor_Partner-distribution.png?raw=true" width="400">
- Around half of the customers have partners.

<img alt="SeniorCitizen" src="figs/20220204_predictor_SeniorCitizen-distribution.png?raw=true" width="400">
- The share of seniors among the customers seems to be roughly similar to the general population.

<img alt="gender" src="figs/20220204_predictor_gender-distribution.png?raw=true" width="400">
- Customers' gender is quite balanced. 

### contract features 

<img alt="Contract" src="figs/20220204_predictor_Contract-distribution.png?raw=true" width="400">
- A lot of the clients have month-to-month (prepaid?) contracts.

<img alt="Device Protection" src="figs/20220204_predictor_DeviceProtection-distribution.png?raw=true" width="400">
- Not so sure why there's a "no internet service" here. Might be joined with the "no" value, but I'll leave it for now.

<img alt="InternetService" src="figs/20220204_predictor_InternetService-distribution.png?raw=true" width="400">
- Almost half of the customers have Fiber optic, and 1500/7000 have no internet service. Is that an ancient dataset?

<img alt="PhoneService" src="figs/20220204_predictor_PhoneService-distribution.png?raw=true" width="400">
- 90% of the customers have phone service.

<img alt="OnlineBackup" src="figs/20220204_predictor_OnlineBackup-distribution.png?raw=true" width="400">
- Most of the customers do not have online backup or even no internet service.

<img alt="OnlineSecurity" src="figs/20220204_predictor_OnlineSecurity-distribution.png?raw=true" width="400">
- Most of the customers do not have online security or even no internet service.

<img alt="StreamingTV" src="figs/20220204_predictor_StreamingTV-distribution.png?raw=true" width="400">
<img alt="StreamingMovies" src="figs/20220204_predictor_StreamingMovies-distribution.png?raw=true" width="400">
- Streaming TV and Movies seem to be in the same package, which makes sense.

<img alt="TechSupport" src="figs/20220204_predictor_TechSupport-distribution.png?raw=true" width="400">
- Half of the customers haven't needed tech support and a lot don't have internet service and therefore don't need tech support (?).

### payment stuff

<img alt="PaperlessBilling" src="figs/20220204_predictor_PaperlessBilling-distribution.png?raw=true" width="400">
- The majority of customers has paperless billing.

<img alt="PaymentMethod" src="figs/20220204_predictor_PaymentMethod-distribution.png?raw=true" width="400">
- Around one third of the customers pay by electronic check, the rest is evenly distributed over the other options.

<img alt="MonthlyCharges" src="figs/20220204_predictor_MonthlyCharges-distribution.png?raw=true" width="400">
- 1400 of 7000 customers pay up to 25 (currency units) a month, the rest is quite spread out up to around 120.

<img alt="TotalCharges" src="figs/20220204_predictor_TotalCharges-distribution.png?raw=true" width="400">

- Long-tail distribution. A large share of customers (presumably also the ones
with short tenure) have low total charges, the rest stay for longer and pay
more over time

### duration of contract

<img alt="tenure" src="figs/20220204_predictor_tenure-distribution.png?raw=true" width="400">
- A fun distribution, ranging from zero to 72 months.

# descriptive with relation to churn

If we split up the dataset into *churn=yes* and *churn=no* and compare the distributions of 
each of the variables between those subgroups, this will give an idea of the direction that
some of the features could be changed to reduce churn. Predictors that are not listed show
no difference in the distributions.

## demographics

<img alt="Dependents" src="figs/20220205_churngroups_predictor_Dependents-distribution.png?raw=true" width="400">
- People without dependents churn more often. Can we do something here? Give discounts to families?

<img alt="Partner" src="figs/20220205_churngroups_predictor_Partner-distribution.png?raw=true" width="400">
- Customers who have no partners churn more often.

<img alt="SeniorCitizen" src="figs/20220205_churngroups_predictor_SeniorCitizen-distribution.png?raw=true" width="400">
- Seniors churn more frequently.

## contract features

<img alt="Contract" src="figs/20220205_churngroups_predictor_Contract-distribution.png?raw=true" width="400">
- The churn quota is highest among the month-to-month contracts, which should be expected. 
- Try to upgrade those clients to fixed-duration contracts.

<img alt="DeviceProtection" src="figs/20220205_churngroups_predictor_DeviceProtection-distribution.png?raw=true" width="400">
- Customers without DeviceProtection churn more often. And people with internet service stay?

<img alt="InternetService" src="figs/20220205_churngroups_predictor_InternetService-distribution.png?raw=true" width="400">
- Customers with Fiber Optic churn way more than those on DSL. Is there any regulatory background here? Monopoly on DSL and competition on fiber?

<img alt="OnlineBackup" src="figs/20220205_churngroups_predictor_OnlineBackup-distribution.png?raw=true" width="400">
- Customers without OnlineBackup churn more often. This is probably related to some internet combination offer.

<img alt="OnlineSecurity" src="figs/20220205_churngroups_predictor_OnlineSecurity-distribution.png?raw=true" width="400">
- Customers without OnlineSecurity churn more often. 
- This is probably related to some internet combination offer that combines the online backup and online security.

<img alt="StreamingMovies" src="figs/20220205_churngroups_predictor_StreamingMovies-distribution.png?raw=true" width="400">
<img alt="StreamingTV" src="figs/20220205_churngroups_predictor_StreamingTV-distribution.png?raw=true" width="400">
- The main factor here seems to be the *no internet service* rather than those additional services.

<img alt="TechSupport" src="figs/20220205_churngroups_predictor_TechSupport-distribution.png?raw=true" width="400">
- Customers without Tech Support churn more often. But I don't know if they never needed tech support because the service is so good.


## payment stuff

<img alt="PaperlessBilling" src="figs/20220205_churngroups_predictor_PaperlessBilling-distribution.png?raw=true" width="400">
- Paperless billing is possibly related to higher churn. 
- But this probably doesn't mean that we should get the customers back towards paper bills.

<img alt="PaymentMethod" src="figs/20220205_churngroups_predictor_PaymentMethod-distribution.png?raw=true" width="400">
- Electronic Check is by far the worst payment method when it comes to churn. Try to get customers away from this payment method.

<img alt="MonthlyCharges" src="figs/20220205_churngroups_predictor_MonthlyCharges-distribution.png?raw=true" width="500">
- Customers with expensive contracts churn more often than those with cheap contracts.

<img alt="TotalCharges" src="figs/20220205_churngroups_predictor_TotalCharges-distribution.png?raw=true" width="500">
- Customers with small Total Charges churn more often. 
- But it could also be the other way around: because they churn they don't run up that many total charges. 
- And on the other end of the spectrum: the more total charges, the less likely to churn.

## duration of contract
<img alt="tenure" src="figs/20220205_churngroups_predictor_tenure-distribution.png?raw=true" width="500">
- Short tenure = high churn. Causality can go both ways here, also on the right end of the graphic.

# predictive model 


