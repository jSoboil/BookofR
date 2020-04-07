# ================================================================================
# Continuous Random Variables ---------------------------------------------
# ================================================================================
# A probability distribution tied to a continuous random variable is called a probability
# density function. Consider the following temprature example:

# ƒ(w) = 
#  (w - 40) / 625 if 40 ≤ w ≤ 65;
#  (90 - w) / 625 if 65 < w ≤ 90;
#  otherwise 0.

# The division by 625 normalises the output, in order to obtain a total Pr = 1.

# To plot the density function, consider the following code:
w <- seq(from = 35, to = 95, by = 5)
w

lower_w <- w >= 40 & w <= 65
lower_w

upper_w <- w > 65 & w <= 90
upper_w

# Now we make use of the above to evaluate the correct result of ƒ(w) for entries in w:
fw <- rep(0, length(w))
fw[lower_w] <- (w[lower_w] - 40) / 625
fw[upper_w] <- (90 - w[upper_w]) / 625
fw
# This doesn't mean that you've just written am R-coded function to return ƒ(w) for any w.
# Here, you've merely created a vector to obtain the corresponding values of the 
# *mathemtical* function as the vector fw. However, these two vectors are sufficient for
# plotting.
plot(w, fw, type = "l", ylab = "f(w)")
abline(h = 0, col = "grey", lty = 2)

# To calculate the total area underneath the function, you need be concerned only with the
# function evaluated at 40 ≤ w ≤ 90 since it is zero everywhere else!

# You can do this geometrically by working out the area of the triangle formed by the 
# function and the horizonal line at zero. For this triangle, you can use the standard
# triangle are formula, half times base times height:
.5*50*.04

# What's the Pr(w ≤ 55.2)? For this, one must find the area underneath ƒ(w), the 
# probability density function, bounded by the horizontal line at zero and an imaginary 
# vertical line at 55.2. In Cartesian coordinates, this is the triangle formed by the 
# vertices at (40, 0), (55.2, 0), and (55.2, f(55.2)).

# Therefore, one should first workout the value of ƒ(55.2):
fw_specific <- (55.2 - 40) / 625
fw_specific
# NOTE: this is not a probability, it cannot be assigned to specific realisations. It is
# just the height value of the function that is needed in order to calculate the 
# interval-based probability Pr(W ≤ 55.2)!

# One can easily determine that the base of the trianlge in this setting is 
# 55.2 - 40 = 15.2. Then, along with fw_specific, note that the area formula gives:
fw_specific_area <- .5 * 15.2 * fw_specific
fw_specific_area
# ... thus, the answer is reached. You've shown geometrically, using ƒ(w), that the
# Pr(W ≤ 55.2) ≈ .185, rounded. In other words, you can say that there is roughly an
# 18.5 % chance that the max temp will be less than or equal to 55.2 degrees F

# The followng R code plots the density function ƒ(w) and marks off and shades the area of
# interest:
fw_specific_vertices <- rbind(c(40, 0), c(55.2, 0), c(55.2, fw_specific))
fw_specific_vertices

plot(w, fw, type = "l", ylab = "f(w)", main = "Pr(W <= 55.2)")
abline(h = 0, col = "grey", lty = 2)
polygon(fw_specific_vertices, col = "grey", border = NA)
abline(v = 55.2, lty = 3)
text(50, .005, labels = fw_specific_area, cex = 1.2)

# However, as stated in the text, I am aware that not all density functions can be 
# appraised in this simple geometric fashion, and formally, integration is the method
# to find areas of a function.

# Cumulative Probability Distributions of Continuous Random Variables --------
# Given a certain value of w, more generally, you find a cumulatgive probability for a
# continuous random variable by calculating the area under the density function of 
# interest, from -Inf to w. This general treatment therefore requires mathematical 
# integration of the relevant probability density function. 

# For the temp example, it can be shown that the cumulative distribution function F is 
# given with the following:


#  F(w) = ∫ -∞ to w f(µw) du

#  is

#  =  0 if w < 40;

#  = (w^2 - 80w + 1600) / 1250 if 40 ≤ w ≤ 65;

#  = (180w - w^2 - 6850) / 1250 if 65 < w ≤ 90;

#  1 otherwise.


# Making use of the sequence w and the logical vectors lower_w and upper_w, you can use
# the same vector subset-and-overwrite approach to plot F(w):
Fw <- rep(0, length(w))
Fw[lower_w] <- (w[lower_w]^2 - 80 * w[lower_w] + 1600) / 1250
Fw[upper_w] <- (180 * w[upper_w] - w[upper_w]^2 - 6850) / 1250
Fw[w > 90] <- 1

plot(w, Fw, type = "l", ylab = "F(w)")
abline(h = c(0, 1), col = "grey", lty = 2)
# Including these extra two lines identifies the fact that at w = 55.2, the cumulative
# probability is located precisely on the curve of F:
abline(v = 55.2, lty = 3)
abline(h = fw_specific_area, lty = 3)

# Mean and Variance of a Continuous Random Variable -----------------------
# Naturally, it is also possible, and useful, to determine the mean and variance of a
# continuous random variable.

# For a continuous random variable W with density f, the mean uw (or expectation or
# expected value E[W]) is again interpreted as the "average outcome" that you can expect
# over many realisations. This is expressed mathematically as follows:

#  µw = E[W] = ∫ -∞ to ∞ ƒ(w) ∂w

# This can be read as "the total area underneath the function given by the multiplication
# of the density f(w) with the value of w itself."

# For W, the variance sigma^2, also written as Var[W], quantifies the variability 
# inherent in realisations of W. Calculation of the continuous variable variance depends 
# upon its mean uw and is given as follows:

#  ∑^2 = Var[W] = ∫ -∞ to ∞ (w - µw)^2 ƒ(w) ∂w 

# Again, the procedure is to find the area under the density function multiplied by a
# certain quantity - in this case, the squared difference of the value of w with the 
# overall expected value uw.

# However, analytic calculations of integrals can be quite complex - let's leave it up
# to the mathematicians - luckily we have software for us these days, depsite the 
# information asymmetry!

# In terms of the required integrals, you can therefore use the previously stored w and
# fw objects to view the functions wƒ(w) and (w - µw)^2 ƒ(w), by executing the following:
plot(w, w * fw, type = "l", ylab = "ƒ(w)")
plot(w, (w - 65)^2 * fw, type = "l", ylab = "(w - 65)^2 ƒ(w)")

# ================================================================================
# Exercise 15.2 -----------------------------------------------------------
# ================================================================================
# c. Return to the temp example.

#  i) Write a function to return ƒ(w) for any number vector of values supplied as w.
#     Try to avoid using a loop in favour of vector-orientated operations.
fw_function <- function(w) {
  lower_w <- w >= 40 & w<= 65
  upper_w <- w > 65 & w <= 90
  
  fw <- rep(0, length(w))
  fw[lower_w] <- (w[lower_w] - 40) / 625
  fw[upper_w] <- (90 - w[upper_w]) / 625
  
  return(fw)
}

fw_function(55.2)
# ... correct!

#  ii). Write a function to return F(w) for any numeric vector of values supplied as w:
Fw_function <- function(w) {
  lower_w <- w >= 40 & w<= 65
  upper_w <- w > 65 & w <= 90
  
  Fw <- rep(0, length(w))
  Fw[lower_w] <- (w[lower_w]^2 - 80 * w[lower_w] + 1600) / 1250
  Fw[upper_w] <- (180 * w[upper_w] - w[upper_w]^2 - 6850) / 1250
  Fw[w > 90] <- 1
  
  return(Fw)
}
Fw_function(55.2)
# ... correct!


# iv & v) 
1 - Fw_function(60)
1 - Fw_function(c(60.3, 76.89))

# End file ----------------------------------------------------------------