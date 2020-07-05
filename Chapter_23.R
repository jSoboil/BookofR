# The following chapter deals with advanced techniques for plot customisation in R.

# ===========================================================================================
# General Graphics Device Layout ---------------------------------------------
# ===========================================================================================
# Manually Opening a New Device -------------------------------------------
# You can open new device windows using dev.new; the newly opened window will immediately 
# become active, and any subsequent plotting commands will affect the particular device. For
# example:
plot(quakes$long, quakes$lat)
# Now, say you want to also see a histogram of the number of stations that detected each 
# event. To create a new plotting window:
dev.new() 
hist(quakes$stations)
# So, if you hadn't used dev.new(), you would've just overwritten the first window.

# Switching between devices -----------------------------------------------
# To switch between devices, use  dev.set() followed by the device number you want to make
# active. The following code activates Device 2 and re-plots the locations of the seismic 
# events so that the size of each point is proportional to the number of stations that 
# detected the event. It also tidies up the axis labels:
dev.set(2)
plot(quakes$long, quakes$lat, cex = .02 * quakes$stations, 
     xlab = "Longitude", ylab = "Latitude")
# Switching back to the histogram plot:
dev.set(4)
abline(v = mean(quakes$stations), lty = 2)

# Closing a device --------------------------------------------------------
# To close a device, it is easiest to use dev.off(). dev.off() with no arguments simply 
# closes the currently active device. Otherwise, you can specify the device number just as 
# when using dev.set(). To close the plot of the spatial locations, leaving the histogram as
# the active device, call dev.off() with the respective argument:
dev.off(2)
# the repeat call of dev.off() will close the remaining device:
dev.off()

# Multiple plots in one device --------------------------------------------
# There are a few ways to do this. There are two ways which are arguably the easiest.

# 1. Setting the mfrow parameter:
# The mfrow argument instructs device to 'invisibly' divide itself into a grid of the 
# specified dimensions, with each cell holding one plot.You pass the mfrow option a numeric 
# integer vector of length 2 in the order of c(rows, columns); with the default being c(1, 1).

# Say you want two plots, side by side:
par(mfrow = c(1, 2))
plot(quakes$long, quakes$lat, cex = .02 * quakes$stations,
     xlab = "Longitude", ylab = "Latitude")
hist(quakes$stations)
abline(v = mean(quakes$stations), lty = 2)

# ===========================================================================================
# Plotting Regions and Margins --------------------------------------------
# ===========================================================================================
# Default spacing ---------------------------------------------------------
# You can find your default figure margin settings with a call to par():
par()$oma
par()$mar
# there is no out margin (oma) set by default. The default margin space is the output of mar.

# To illustrate these regions, consider the following image:
plot(1:10)
box(which = "figure", lty = 2)
# ... you can see the dashed line snug up-against the window edges.

# Custom spacing ----------------------------------------------------------
# Let's tailor the outer margins:
par(oma = c(1, 4, 3, 2), mar = 4:7)
plot(1:10)
box(which = "figure", lty = 2)
box(which = "figure", lty = 3)
# Since you would usually manipulate margin space to accommodate particular annotations of 
# the plot, let's look at the mtext() function, used specifically to produce text in the 
# figure or outer margins. By default, the argument outer is FALSE. Setting outer = TRUE 
# positions the text in the outer region, e.g.:
mtext("Figure region margins\nmar[ . ]", line = 2)
mtext("Outer region margins\noma{ . ]", line = .5, outer = TRUE)

# Clipping ----------------------------------------------------------------
# Controlling clipping allows you to draw in or add elements to the margin regions with
# reference to the user coordinates of the plot itself. For example, you might want to 
# place a legend outside the plotting area, or you might wish to draw an arrow that 
# extends beyond the plot region to embellish a particular observation. 

# The graphical parameter xpd controls clipping in base R. By default, xpd is set to 
# FALSE, so all drawing is clipped to the available plot region only. Setting xpd to TRUE
# allows you to draw things outside the formally defined plot region intot he figure 
# margins, but not into any outer margins.

# Setting xpd to NA will permit drawing in all three areas - plot region, margins, and 
# outer margins. For example:
dev.off()
#  xpd = FALSE...
par(oma = c(1, 1, 5, 1), mar = c(2, 4, 5, 4))
boxplot(mtcars$mpg ~ mtcars$cyl, xaxt = "n", ylab = "MPG")
box("figure", lty = 2)
box("outer", lty = 3)
arrows(x0 = c(2, 2.5, 3), y0 = c(44, 37, 27), x1 = c(1.25, 2.25, 3), y1 = c(31, 22, 20),
       xpd = FALSE)
text(x = c(2, 2.5, 3), y = c(45, 38, 28), c("V4 cars", "V6 cars", "V8 cars"),
     xpd = FALSE)
# xpd = TRUE...
par(oma = c(1, 1, 5, 1), mar = c(2, 4, 5, 4))
boxplot(mtcars$mpg ~ mtcars$cyl, xaxt = "n", ylab = "MPG")
box("figure", lty = 2)
box("outer", lty = 3)
arrows(x0 = c(2, 2.5, 3), y0 = c(44, 37, 27), x1 = c(1.25, 2.25, 3), y1 = c(31, 22, 20),
       xpd = TRUE)
text(x = c(2, 2.5, 3), y = c(45, 38, 28), c("V4 cars", "V6 cars", "V8 cars"),
     xpd = TRUE)
# xpd NA...
par(oma = c(1, 1, 5, 1), mar = c(2, 4, 5, 4))
boxplot(mtcars$mpg ~ mtcars$cyl, xaxt = "n", ylab = "MPG")
box("figure", lty = 2)
box("outer", lty = 3)
arrows(x0 = c(2, 2.5, 3), y0 = c(44, 37, 27), x1 = c(1.25, 2.25, 3), y1 = c(31, 22, 20),
       xpd = NA)
text(x = c(2, 2.5, 3), y = c(45, 38, 28), c("V4 cars", "V6 cars", "V8 cars"),
     xpd = NA)

# Point-and-Click Coordinate Interaction ----------------------------------
# You can also use mouse clicks to select coordinates. Here's how you do it:
plot(1)
coordList <- locator(type = "o", pch = 4, lty = 2, lwd = 3, col = "red", xpd = TRUE)
# you terminate the process by clicking on 'finish', found at the top right of the plot 
# console; the coordinates are saved in the defined object.

# Ad Hoc Annotation -------------------------------------------------------
# The locator function alos allows you to place ad hoc annotations, such as legends, on 
# your plot.

# The following code produces a scatter plot of a multiple linear regression of mean 
# student height as a function of handspan and sex, which was covered in chapter 21.
library(MASS)
plot(survey$Height ~ survey$Wr.Hnd, pch = 16,
     col = c("grey", "black")[as.numeric(survey$Sex)],
     xlab = "Writing handspan", ylab = "Height")
legend(locator(n = 1), legend = levels(survey$Sex), pch = 16,
       col = c("grey", "black"))
# Here, by indicating n = 1, it automatically induces an upper limit on the number of 
# points that the function argument locator records.

# ===========================================================================================
# Customising Traditional R Plots -----------------------------------------
# ===========================================================================================
# Now it is time to focus on common features of plots.

# Graphical Parameters for Style and Suppression --------------------------
# There are two axis 'styles' controlled by the graphical parameters xaxs and yaxs. Their 
# sole purpose is to decide whether to impose the small amount of additional horizontal and
# vertical buffer spaces that's present at the ends of each axis to prevent points being 
# chopped off. The default, xaxs = "r" and yaxis = "r", is to include that space. The 
# alternative is to set one or both parameters to "i", which instructs the plot region to be
# strictly defined by the upper and lower limits of the data. E.g.:
plot(mtcars$hp, mtcars$mpg, cex = (mtcars$wt / mean(mtcars$wt)), xaxs = "i", yaxs = "i")

# If you want total control over the specific appearance of any boxes, axes, and their labels,
# you'll want to start a plot with none of these and add them as per your design. For example:
plot(mtcars$hp, mtcars$mpg, cex = (mtcars$wt / mean(mtcars$wt)), xaxt = "n", yaxt = "n",
     bty = "n", xlab = "")
# or...
plot(mtcars$hp, mtcars$mpg, cex = (mtcars$wt / mean(mtcars$wt)), axes = FALSE, ann = FALSE)

# Customising Boxes -------------------------------------------------------
# When starting with a suppressed-box or suppressed-axis plot, to add a box specific to the 
# current plot region in the active graphics device, you use box and specify its type with 
# bty. For example:
box(bty = "u")
# bty is A character string which determined the type of box which is drawn about plots. If 
# bty is one of "o" (the default), "l", "7", "c", "u", or "]" the resulting box resembles 
# the corresponding upper case letter. A value of "n" suppresses the box.

# Customising Axes --------------------------------------------------------
# One you have a box the way you want it, you can focus on the axes. The axis() function 
# allows you to control the addition and appearance of an axis on any of the four sides of 
# the plot region in greater detail. The first argument it takes is side, provided with a 
# single integer, either: 1 (bottom), 2 (left), 3 (top), 4 (right). These numbers are 
# consistent with the positions of the relevant margin-spacing values when you're setting 
# graphical parameter vectors, like mar.

# For example, the first thing you might want to change on an axis are the positions of the 
# tick marks. By default, R uses the built-in function pretty() to find a 'neat' sequence of 
# values for scale of each axis, but you can set your own by passing the at argument to axis.
# For example:
hp_sequence <- seq(min(mtcars$hp), max(mtcars$hp), length.out = 10)
plot(mtcars$hp, mtcars$mpg, cex = (mtcars$wt / mean(mtcars$wt)), xaxt = "n", bty = "n",
     ann = FALSE)
axis(side = 1, at = hp_sequence)
axis(side = 3, at = round(hp_sequence))

# ===========================================================================================
# Specialised Text and Label Notation -------------------------------------
# ===========================================================================================
# Tools for controlling fonts and displaying special notation.

# Font --------------------------------------------------------------------
# The displayed font is controlled by two graphical parameters: family() for the specific 
# font family and font(), an integer selector for controlling bold and italic typeface.

# Available fonts depend on the OS and the graphics device you are using. There are, however,
# three general families - "sans" (default), "serif", and "mono" - that are always available.
# You can set the family and font parameters globally, but it is also common to set them for
# specific graphical outputs.  For example:
par(mar = c(3, 3, 3, 3))
plot(1, 1, type = "n", xlim = c(-1, 1), ylim = c(0, 7), xaxt = "n", yaxt = "n", ann = FALSE)
text(0, 6, labels = "sans text (default)\nfamily =\"sans\", font = 1")
text(0, 5, labels = "serif text \nfamily = \"mono\", font = 1", family = "serif", font = 1)
text(0, 4, labels = "mono text \nfamily = \"mono\", font = 1", family = "mono", font = 1)
text(0, 3, labels = "mono text (bold, italic)\nfamily = \"mono\", font = 4", family = "mono",
     font = 4)
text(0, 2, labels = "sans text (italic)\nfamily = \"sans\", font = 3", family = "sans",
     font = 3)
text(0, 1, labels = "serif text (bold)\nfamily = \"serif\", font = 2", family = "serif", 
     font = 2)
mtext("some", line = 1, at = -.5, cex = 2, family = "sans")
mtext("different", line = 1, at = 0, cex = 2, family = "serif")
mtext("fonts", line = 1, at = .5, cex = 2, family = "mono")

# Greek Symbols -----------------------------------------------------------
# For statistically or mathematically technical plots, annotation may require Greek symbols 
# or mathematical markup. You can display these using the expression() function, which, among
# other things, is capable of invoking the plotmath mode of R. Use of expression returns a
# special object that has a class of the same name and can subsequently be passed to any 
# argument in a plotting function that requires the character string to be displayed. For
# example:
dev.off()
par(mar = c(3, 3, 3, 3))
plot(1, 1, type = "n", xlim = c(-1, 1), ylim = c(.5, 4.5), xaxt = "n", yaxt = "n", 
     ann = FALSE)
text(0, 4, labels = expression(alpha), cex = 1.5)
text(0, 3, labels = expression(paste("sigma: ", sigma, " Sigma: ", Sigma)),
     family = "mono", cex = 1.5)
text(0, 2, labels = expression(paste(beta, " ", gamma, " ", Phi)), cex = 1.5)
text(0, 1, labels = expression(paste(Gamma, "(", tau, ") = 24 when ", tau, " = 5")),
     family = "serif", cex = 1.5)
title(main = expression(paste("Gr", epsilon, epsilon, "k")), cex.main = 2)

# Mathematical Expression -------------------------------------------------










