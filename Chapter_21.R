library(MASS)

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
survMLM <- lm(Height ~ Wr.Hnd + Sex, data = survey)
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

























