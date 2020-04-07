# ================================================================================
# Analysis of Variance ----------------------------------------------------
# ================================================================================
# In its simplest for,, ANOVA is used to compare multiple means in a test for equivalence.
# In this sense, it is a straightforward extension of the hypothesis test comparing two
# means.

# One-Way ANOVA -----------------------------------------------------------
# Simply, one-way ANOVA is used to test two or more means for equality. The means are split
# by a categorical group or factor variable. In fact, when k = 2 the two-sample t-test
# is equivalent to one-way ANOVA. The following assumptions have to be satisfied in order
# for the results of the basic one-way to be considered reliable:

#  Independence: the samples making the k groups must be independent of one another, and
#  the observations in each group must be independent and identically distributed (iid).

#  Normality: the observations in each group should be normally distributed, or at least
#  approximately so.

#  Equality of variances: the variance of the observations in each group should be equal,
#  or at least approximately so - ≠ heteroskedascity.

# It is worth noting that you don't need to have an equal number of observatios in
# each group to perform the test. However, having unbalanced groups does render the test
# more sensitive to potentially detrimental effects if your assumptions of heterogeneity
# and normality are not sound. Let's work run an few examples using the chickwts data:
data("chickwts")
table(chickwts$feed)

chick_means <- tapply(chickwts$weight, INDEX = chickwts$feed, FUN = mean)
chick_means

par(mfrow = c(1, 2))
boxplot(chickwts$weight ~ chickwts$feed)
points(1:6, chick_means, pch = 4, cex = 2)

# Assuming independence of the data, before implementing the test, you must first check
# that the other assumptions are valid. To examine the equality of variances, you can 
# use a rule of thumb. by assuming equality of variances if the ratio of the largest 
# sample standard deviation to the the smallest sample is < 2:
chicks_z <- tapply(chickwts$weight, INDEX = chickwts$feed, FUN = sd)
max(chicks_z) / min(chicks_z)
# ... this informal result indicates that it is reasonable to make this assumption.

# Next we can assess normality using a QQ-plot. First we have to centre the data:
chicks_meanCentered <- chickwts$weight - chick_means[as.numeric(chickwts$feed)]
qqnorm(chicks_meanCentered)
qqline(chicks_meanCentered)
# Therefore, based on this plot, it does not seem unreasonable to assume normality for
# these data. 

# Building One-Way Anova with aov Function --------------------------------
chick_ANOVA <- aov(weight ~ feed, data = chickwts)
summary(chick_ANOVA)
plot(chick_ANOVA)

# Two-Way ANOVA -----------------------------------------------------------
# Used when the outcome variable is categorised by more than jyust one grouping variable.
# Therefore, an important part of distinguishing main effects and interactive effects.
data("warpbreaks")

# The following executes a two-way ANOVA for the warp breaks data set based only on the
#  main effects:
summary(aov(breaks ~ wool + tension, data = warpbreaks))

# However, this doesn't address possibility that a difference in the mean number of warp
# breaks might vary further according to precisely which level of either tension or wool
# is being used when holding the other variable constant. Hence, let's further investigate
# by taking interaction into consideration:
summary(aov(breaks ~ wool + tension + wool:tension, data = warpbreaks))

# To help with this, you can interpret such a two-way interaction effect in more detail 
# with an interaction plot. First we create group means:
wb_means <- aggregate(warpbreaks$breaks, 
                      by = list(warpbreaks$wool, warpbreaks$tension), FUN = mean)
wb_means

dev.off()
interaction.plot(x.factor = wb_means[, 2], trace.factor = wb_means[, 1],
                 response = wb_means$x, trace.label = "wool",
                 xlab = "tension", ylab = "mean warp breaks")
# In general, when the lines, or segments thereof, are not parrallel, it suggests an 
# interaction could be present. Vertical separations between the plotted locations 
# indicate the individual main effects of the grouping variables. Considering the above 
# plot, it does indeed appear that the mean number of warp breaks for wool type A is 
# higher if tension is low, but the nature of the difference changes if you move to a 
# medium tension, where B has a higher point estimate than A. Moving to a high tension,
# type A again has a higher estimate of the mean number of breaks than B, though here the
# difference between A and B is nowhere near as big as it is at a low tension. 

# ================================================================================
# Kruskal-Wallis Test -----------------------------------------------------
# ================================================================================
# The Kruskal-Wallies test is an alternative to the one-way ANOVA that relaxes the 
# assumption of normality. You can think of this test as one that compares multiple 
# medians rather than means. It is a non-parametric approach since it does not rely on
# quantiles of a standard parametric distribution. It is a generalisation of the 
# Mann-Whitney test for two medians. It is also referred to as the Kruskal-Wallies rank 
# sum test, and you use the chi-squared distribution to calculate the p-value. 

# Suppose you are interested in seeing whether the age of students tends to differ with
# respect to four smoking categories found in the survey data pack:
library(MASS)
data("survey")

# An inspection of the relevant side-by-side plots suggests a straightforward one-way 
# ANOVA is not a good idea:
dev.off()
par(mfrow = c(1, 2))
boxplot(Age ~ Smoke, data = survey)

age_mean <- tapply(survey$Age, INDEX = survey$Smoke, mean)
age_meanCentered <- survey$Age - age_mean[as.numeric(survey$Smoke)]
qqnorm(age_meanCentered, main = "Normal QQ plot of residuals")
qqline(age_meanCentered)

# With this violation of normality, you could therefore apply Kruskal-Wallis:
kruskal.test(Age ~ Smoke, data = survey)
# ... the results suggest that there is not sufficient evidence against the null, which
# states that the medians are all equal. Therefore, there does not seem to be an overall 
# age difference between students.

# Considering that the exercise for this chapter is a repitive variation of the above, 
# and that I have covered the above material throughout my education, I will not 
# complete this chapter's exercise.

# End file ----------------------------------------------------------------