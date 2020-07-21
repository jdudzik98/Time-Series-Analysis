library(readxl)
seasonal <- read_excel("pasażerowieUK.xls")
passengers = ts(data=seasonal$Liczba, frequency = 12,             
                start=c(1993,1), end=c(2019,11)) 

autoplot(passengers, main = "United Kingdom airplane passengers 1993-2019", ts.colour = 'red',xlab="Year", ylab="Number of passengers", lty=3)


d.passengers <- diff(passengers, 12)
tsdisplay(d.passengers)

d.d.passengers <- diff(d.passengers, 11)
tsdisplay(d.d.passengers)
testdf(d.d.passengers, adf_order = 3)
kpss.test(d.d.passengers)

ggAcf(d.d.passengers, lag.max = 36)

ggPacf(d.d.passengers, lag.max = 36)

sarima_312_111 <- arima(passengers, order = c(3,1,2), seasonal = list(order = c(1,1,1), period = 12))
sarima_313_111 <- arima(passengers, order = c(3,1,3), seasonal = list(order = c(1,1,1), period = 12))
sarima_318_111 <- arima(passengers, order = c(3,1,8), seasonal = list(order = c(1,1,1), period = 12))

library(tseries)

auto.arima(passengers, stepwise = TRUE, approximation = FALSE, seasonal = TRUE)

sarima_202_111 <- arima(passengers, order = c(2,0,2), seasonal = list(order = c(1,1,1), period = 12))

Box.test(sarima_312_111$residuals, type = "Ljung-Box")
Box.test(sarima_313_111$residuals, type = "Ljung-Box")
Box.test(sarima_318_111$residuals, type = "Ljung-Box")
Box.test(sarima_202_111$residuals, type = "Ljung-Box")

AIC(sarima_312_111, sarima_313_111, sarima_318_111)
AIC(sarima_202_111)
BIC(sarima_312_111, sarima_313_111, sarima_318_111)
BIC(sarima_202_111)

train_data = ts(data=seasonal$Liczba[1:191], frequency = 12,             
                start=c(1993,1), end=c(2018,11)) 
pass.hw.add<-hw(train_data, h=20,seasonal="additive")
pass.hw.mult<-hw(train_data, h=20,seasonal="multiplicative")

plot(passengers)
lines(fitted(pass.hw.add), col="orange", lty=2)
lines(fitted(pass.hw.mult), col="green", lty=2)

sarima_318_111 <- arima(train_data, order = c(3,1,8), seasonal = list(order = c(1,1,1), period = 12))

forecast.sarima = (forecast(sarima_318_111, h = 12))

holt.test1 = forecast(HoltWinters(train_data, alpha = 0.175, beta = 0.0143, gamma = 0.3223, seasonal = "additive"), h = 12)
holt.test2 = forecast(HoltWinters(train_data, alpha = 0.1679, beta = 0.0109, gamma = 0.3856, seasonal = "multiplicative"), h = 12)

test_data = ts(data=seasonal$Liczba[192:203], frequency = 12,             
               start=c(2018,12), end=c(2019,11))

stats <- c("MAE", "MSE","MAPE","SMAPE")
sarima_stats <- forecast_stats <- c(round(MAE(forecast.sarima$mean, test_data), 5),round(MSE(forecast.sarima$mean, test_data), 5),round(MAPE(forecast.sarima$mean, test_data), 5), round(SMAPE(forecast.sarima$mean, test_data), 5))
holt_add_stats <- c(round(MAE(holt.test1$mean, test_data), 5), round(MSE(holt.test1$mean, test_data), 5),round(MAPE(holt.test1$mean, test_data), 5),round(SMAPE(holt.test1$mean, test_data), 5))
holt_mult_stats <- c(round(MAE(holt.test2$mean, test_data), 5), round(MSE(holt.test2$mean, test_data), 5),round(MAPE(holt.test2$mean, test_data), 5),round(SMAPE(holt.test2$mean, test_data), 5))

stats <- rbind(stats, sarima_stats, holt_add_stats, holt_mult_stats)
stats

plot(passengers, xlim=c(as.Date(2017), as.Date(2020)))
lines(holt.test2$mean, col = "green", lty = 2)
lines(holt.test1$mean, col = "yellow", lty = 2)
lines(forecast.sarima$mean, col = "red", lty = 2)
legend("topright",
       legend=c("original values", "Holt-Winters additive", "Holt-Winters multiplicative", "SARIMA forecast"),
       col=c("black", "green", "yellow", "red"), lty=c(1,2,2,2))