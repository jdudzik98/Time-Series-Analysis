##Final project for Time Series Analysis class at Faculty of Economic Sciences

###Full report in Report.md file

#In the project I analyse two time series using ARIMA and SARIMA models with prediction of it's future values and comparise accuracy of prediction methods.

#Topic of analysis 
Two time series were analysed: 
-3 month interest rate in Sweden - non seasonal
-Monthly amount of airplane passengers in the United Kingdom between years 1993 and 2019 - seasonal

#Used methods:
-ARIMA and SARIMA models
-ACF and PACF charts analysis
-Statistical tests - Dickey-Fuller, KPSS, Ljung-Box, Webel-Ollech, Breusch-Godfrey
-Goodness of fit classification criterions: Akaike and Bayesian
-Prediction methods - Holt, Holt-Winters, ARIMA, SARIMA

#Outcomes:
ARIMA/SARIMA models were identified with stationarity proven. 
Basing on several statistics (e.g. Mean Absolute Error, Mean Absolute Percentage Error), Holt method was detected as the best predicion approach for non-seasonal
time series and Holt-Winters for the seasonal.
