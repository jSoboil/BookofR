library(ggplot2)
library(ggthemes)
library(MASS)

# ==========================================================================================
# Advanced Grammar of Graphics --------------------------------------------
# ==========================================================================================
# Using either qplot or ggplot typically depends on the quality of the graphics that you are
# seeking. qplot is great for quick data exploration however, using ggplot offers far more 
# choice in the refinement of your visualisations. It is also important to note the slight 
# variations in syntax between both packages. Here we focus on ggplot, as at time of writing,
# qplot is not available for R version 4.0.2:
gg_static <- ggplot(data = mtcars, mapping = aes(x = hp)) +
 ggtitle("Horsepower") +
 labs(x = "HP")
mtcars_mm <- data.frame(mm = c(mean(mtcars$hp), median(mtcars$hp)),
                        stats = factor(c("mean", "median")))
gg_lines <- geom_vline(mapping = aes(xintercept = mm, linetype = stats),
                       show.legend = TRUE, data = mtcars_mm)

gg_static + 
 geom_histogram(colour = "black", fill = "white",
                breaks = seq(0, 400, 25), closed = "right") +
 gg_lines + 
 scale_linetype_manual(values = c(2, 3)) +
 labs(linetype = "")

# ==========================================================================================
# Smoothing and Shading ---------------------------------------------------
# ==========================================================================================

# Adding LOESS Trends -----------------------------------------------------
# When you're looking at raw data, it's sometimes difficult to get an overall impression of 
# trends without fitting a parametric model, which means making assumptions about the nature of
# of these trends. This is where nonparametric smoothing comes in - you can use certain methods
# to determine how your data appear to behave without fitting a specific model. However, the 
# trade-off is that you are not provided with any specific numeric details of the 
# relationships between response and predictor variables (since you're not estimating the 
# coefficients such as slopes or intercepts) and you lose any reliable ability to extrapolate.

# Locally weighted scatter plot smoothing (LOESS) is a nonparametric smoothing technique that 
# produces the smoothed trend by using regression methods on localised subsets of the data, 
# step-by-step over the entire range of the explanatory variable. Using the MASS package, let us
# first create a new data object with any missing values deleted to avoid NA warnings.
surv <- na.omit(survey[, c("Sex", "Wr.Hnd", "Height")])
# then we can plot:
ggplot(surv, aes(x = Wr.Hnd, y = Height)) +
 geom_point(aes(col = Sex, shape = Sex)) +
 geom_smooth(method = "loess")
# producing the same plot in base R takes significantly more code and therefore time.

# Constructing Smooth Density Estimates -----------------------------------
# Kernel density estimation (KDE) is a method for producing a smooth estimate of a probability
# density function, based on observed data. Briefly, KDE involves assigning a scaled 
# probability function (the kernel) to each observation in a data set and summing them all to 
# give an impression of the distribution of the data set as a whole. It's basically a 
# sophisticated version of a histogram. 

# Let's illustrate:
ggplot(data = airquality, aes(x = Temp)) +
 geom_density()
# Doing this in base R is relatively easy. But suppose you want to visualise the density of 
# estimates for temprature separately according to the month of observation:
air <- airquality
# We also have to recode the data from numeric vector to a factor vector.
air$Month <- factor(air$Month,
                    labels = c("May", "June", "July", "August", "September"))
# Then:
ggplot(data = air, aes(x = Temp, fill = Month)) + 
 geom_density(alpha = .4) +
 ggtitle("Monthly temperature probability densities") +
 labs(x = "Temp (F)", y = "Kernel estimate") +
 theme_hc()

# ==========================================================================================
# Multiple Plots and Variable-Mapped Facets -------------------------------
# ==========================================================================================























