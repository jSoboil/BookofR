# The following chapter deals  advanced techniques for plot customisation.

# ===========================================================================================
# Manually Opening a New Device -------------------------------------------
# ===========================================================================================
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
# To close a device, it is easiest to use dev.off(). dev.off() with no arguments simply closes
# the currently active device. Otherwise, you can specify the device number just as when using
# dev.set(). To close the plot of the spatial locations, leaving the histogram as the active 
# device, call dev.off() with the respective argument:
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
# Since you would usually manipulate margin space to accommodate particular annotations of the
# plot, let's look at the mtext() function, used specifically to produce text in the figure or
# outer margins. By default, the argument outer is FALSE. Setting outer = TRUE positions the
# text in the outer region, e.g.:
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

# ===========================================================================================
# Point-and-Click Coordinate Interaction ----------------------------------
# ===========================================================================================














