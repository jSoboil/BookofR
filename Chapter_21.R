library(MASS)
library(tidyverse)
library(faraway)

# ====================================================================================
# Multiple Linear Regression ----------------------------------------------
# ====================================================================================

# Estimating in Matrix form: a simple example -----------------------------
# Let's say you have two predictor variables: X[1] as a continuous and X[2] as a binary.
# You're target regression equation is therefore 

# y_hat = ß_hat[0] + ß_hat[1] * x[1] + ß_hat[2] * x[2]

# Suppose you collect the following data, where the response, data for  X[1], and data for
# X[2], for n = 8 individuals, are given in columns y, x1, and x2, respectively.

demo_Data <- data.frame(y = c(1.55, .42, 1.29, .73, .76, -1.09, 1.41, -.32),
                        x1 = c(1.13, -.73, .12, .52, -.54, -1.15, .20, -1.09),
                        x2 = c(1, 0, 1, 1, 0, 1, 0, 1))
demo_Data

# To get your point estimates in ß = [ß[0], ß[1], ß[2]]^t for the linear model, you first
# have to construct X and Y in matrix notation. Therefore, you have to split y into a 
# seperate matrix column:
Y <- matrix(demo_Data$y)
Y

n <- nrow(demo_Data)

X <- matrix(c(rep(1, n), demo_Data$x1, demo_Data$x2), nrow = n, ncol = 3)
X
# Notice your leading 1's column to map ß[0]...

# Now all you have to do is execute the line corresponding to a matrix form of a linear 
# equation:

# (X^t dot-product X)^-1 dot-product X^t dot-product Y

BETAHAT <- solve(t(X) %*% X) %*% t(X) %*% Y
BETAHAT
# ... you've just used OLS to fit your model. However, thank goodness R does this 
# automatically!

# ====================================================================================
# Visualising the MLM -----------------------------------------------------
# ====================================================================================
data("survey")
survMLM <- lm(Height ~ Wr.Hnd + Sex + Smoke, data = survey)
summary(survMLM)
confint(survMLM)

# Being male simply changes the overall ß[0], intercept, by around 9.49cm:
surv_coeffs <- coef(survMLM)
surv_coeffs
as.numeric(surv_coeffs[1] + surv_coeffs[3])

plot(survey$Height ~ survey$Wr.Hnd,
     col = c("gray", "black")[as.numeric(survey$Sex)],
     pch = 16, xlab = "Writing handspan", ylab = "Height")
abline(a = surv_coeffs[1], b = surv_coeffs[2], col = "gray", lwd = 2)
abline(a = surv_coeffs[1] + surv_coeffs[3], b = surv_coeffs[2], col = "black", lwd = 2)
legend("topleft", legend = levels(survey$Sex), col = c("gray", "black"), pch = 16)

# ====================================================================================
# Omnibus F-test ----------------------------------------------------------
# ====================================================================================
# The f-test in the Multilinear model is effectively comparing the amount of error 
# attributed to the null model (i.e. the one with an intercept only) with the amount of 
# error attributed to the predictors when all the predictors are present. Thus, the more
# the predictors are able to model the response, the more error they explain, giving you
# a more extreme F statistic and therefore a smaller p-value. It is especially useful when
# you have many explanatory variables. When multiple regression models are fitted, the 
# amount of output alone can take time to digest and interpret, and care must be taken to
# avoid Type 1 errors (the incorrect rejection of a true H0).

# The F-test allows you to consider:
# 1. Evidence against the null hypothesis, if the assoicated p-value is smaller than 
# the chosen alpha, which then suggests that the model does a significantly better job at
# predicting the response than if you removed all the predictors used in the model.

# 2. No evidence against the null, if the assoicated p-value is larger than alpha, which
# suggests that using the predictors have no tangible benefit over having an intercept 
# alone - randomness.

# Note! The test, however, does not tell you which of the predictors is having a 
# beneficial impact on the fit of the model, nor does it tell you anything about their 
# coefficients or respective standard errors (se's).

# One can compute the F-test using the coefficient of determination, R^2, from the fitted
# regression model. Let p be the number of regression parameters requiring estimation, 
# excluding the intercept ß0. Then,

# F = (R^2 * (n - p - 1)) / ((1 - R^2) * p)

# where F follows an F distribution, with df[1] = p, df[2] = n - p - 1. The p-value 
# associated with the above equation is yielded as the upper-tail area of the 
# F-distribution.

# We can also predict (forecast) with our model in R as follows:
# train model...
survMLM <- lm(Height ~ Wr.Hnd + Sex, data = survey)
# test model...
predict(survMLM, newdata = data.frame(Wr.Hnd = 16.5, Sex = "Male"), 
        interval = "prediction", level = .99)

# ====================================================================================
# Transformations ---------------------------------------------------------
# ====================================================================================
# I exclude polynomial transformations due to familiarity and dislike for 
# interpretability - there are better ways to model non-linear relationships!

# Logarithmic transformations ---------------------------------------------
# To briefly illustrate the behaviour of the log transformation:
plot(1:1000, log(1:1000), type = "l", xlab = "x", ylab = "y", ylim = c(-8, 8))
lines(1:1000, -log(1:1000), lty = 2)
legend("topleft", legend = c("log(x)", "-log(x)"), lty = c(1, 2))

# Fitting the log transformation ------------------------------------------
# For illustration, consider mileage as a function of both horsepower and transmission, 
# from the mtcars data set.
plot(mtcars$hp, mtcars$mpg, pch = 19, col = c("black", "gray")[factor(mtcars$am)],
       xlab = "Horsepower", ylab = "MPG")
# Since, at least for this example, you want to account for the potential of transmission
# type to affect the response, this is included as an additional predictor variable as 
# usual:
car_log <- lm(mpg ~ log(hp) + am, data = mtcars)
summary(car_log)
confint(car_log)

# Predicting and Plotting the model ---------------------------------------
hp_seq <- seq(min(mtcars$hp) - 20, max(mtcars$hp) + 20, length.out = 30)
n <- length(hp_seq)
car_logPred <- predict(car_log, newdata = data.frame(hp = rep(hp_seq, 2), am
                                                     = rep(c(0, 1), each = n)))
lines(hp_seq, car_logPred[1:n])
lines(hp_seq, car_logPred[(n + 1):(2 * n)], col = "gray")

# To this end, however you choose to model your own data, the objective of transforming 
# numeric variables should always be to fit a valid model that represents the data and the
# relationships more realisrticaly and accurately.

# ====================================================================================
# Interactive terms  ------------------------------------------------------
# ====================================================================================
# An interactive effect between predictors is an additional change to the response that
# pccurs at particular combinations of the predictors. Interactiosn can can take various
# dimensuons, however, we will for now focus on a two-way interaction.

# One Categorical, One Continuous -----------------------------------------
data("diabetes")
dia_fit <- lm(chol ~ age + frame + age:frame, data = diabetes)
summary(dia_fit)
confint(dia_fit)
dia_coef <- coef(dia_fit)

# Now, let's sum the relevant components of this vector. This will allow us to plot the
# fitted model:
dia_small <- c(dia_coef[1], dia_coef[2])
dia_small

dia_medium <- c(dia_coef[1] + dia_coef[3], dia_coef[2] + dia_coef[5])
dia_medium

dia_large <- c(dia_coef[1] + dia_coef[4], dia_coef[2] + dia_coef[6])
dia_large

# This stores the three lines as numeric vectors of length 2, with the intercept first and
# the slope second. This is the form required by the optional coef argument of abline, 
# which allows you to superimpose these straight lines on a plot of the raw data:
cols <- c("black", "darkgray", "lightgray")
plot(diabetes$chol ~ diabetes$age, col = cols[diabetes$frame],
     cex = .5, xlab = "age", ylab = "cholestrol")
abline(coef = dia_small, lwd = 2)
abline(coef = dia_medium, lwd = 2, col = "darkgray")
abline(coef = dia_large, lwd = 2, col = "lightgray")
legend("topright", legend = c("small frame", "medium frame", "large frame"), lty = 1,
       lwd = 2, col = cols)

# Am also familiar with the other interactive topics covered, such as categorical and 
# continuous interaction effects. Thus, will leave out. The above serves as a simple 
# practical example.

# End file ----------------------------------------------------------------