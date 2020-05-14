# ========================================================================================
# Linear Model Selection and Diagnostics ----------------------------------
# ========================================================================================
# Selected sections from this chapter that improved my practical knowledge.

# Calculating Leverage ----------------------------------------------------
# Leverage itself is calculated using the design matrix structute. Specifically, if you have
# n observations, then the leverage of the ith point (i = 1, ..., n) is denoted h[ii]. These
# are the diagonal elements (ith row, ith column) of the n %*% n matrix H (Hessian?), such 
# that,

# H = X(t(X) %*% X) ^ -1 %*% t(X)

# For example:
x <- c(1.1, 1.3, 2.3, 1.6, 1.2, .1, 1.8, 1.9, .2, .75)
X <- cbind(rep(1, 10), x)
X

hii <- diag(X %*% solve(t(X) %*% X) %*% t(X))
plot(hii ~ x, ylab = "Leverage", main = "", pch = 4)

# You would typically use the built-in R function called hatvalues, named after the style of
# matrix algebra used in the equation above. 

# Cook's Distance ---------------------------------------------------------
# Arguably the most well-known measure of influence is Cook's distance, which estimates the 
# magnitude of the effect of deleting the ith value from the fitted model. Cook's distance for
# observation i (denoted D[i]) is given with the following equation:

# D[i] = ∑[j = i, n] ((y.hat[j] i y.hat[j]^[-i]) ^ 2) / (p + 1) * sigma.sq ; i, j = 1, ..., n


# This equation is a specific function of a point's leverage and residual. Here, the value
# y.hat[j] is the predicted mean respinse of observation j for the model fitted with all n
# observations, and y.hat[j] ^ [-i] represents the predicted mean response of the observation
# j for the model fitted *without* the ith observation. As usual, the term p is the number
# of predictor regression parameters (excl. the intercept), and the value sigma.sq is the
# estimate of the residual standard error.

# The larger the value of D[i], the larger the influence the ith observation has on the fitted
# model, meaning outlying observations in high-leverage positions will correspond to higher 
# values of D[i]. The important question is, how big does D[i] have to be in order for point
# i to be considered influential? In practice, this is difficult to generalise, and there is
# no formal hypothesis test for it, but there are several rule-of-thumb cutoff values. One 
# such rule states that if D[i] > 1, the point should be considered influential; another, more
# sensitive rule suggests D[i] > 4/n. It's generally advised that you compare multiple Cook's
# distance for a given fitted model rather than analysing one single value, and that any point
# corresponding to a comparatively large D[i] might need further inspection.

# Collinearity ------------------------------------------------------------
# The following items serve as potential warning signs when inspecting a model summary:

# The omnibus F-test result is statistically significant, but none of the individual t-test
# results for the regression parameters are significant.

# The sign of a given coefficient estimate contradicts what you would reasonably expect to
# see, for example, drinking more wine resulting in a lower blood alchohol level.

# Parameter estimates are assoicated with unusually high standard errors or vary widly when
# the model is fitted to different random record subsets of the data.

# As the last point notes, collinearity tends to have more of a detrimental effect on the 
# standard errors of the coefficients than it does on the point predictors per se.


# End file ----------------------------------------------------------------