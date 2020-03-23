# I know the basics of functions, so let's skip to the practical section.

# ==========================================================================================
# Function Creation -------------------------------------------------------
# ==========================================================================================
# # Let's take the Fibonacci sequence generator from the end of the previous section and turn it
# into a function:
myFib <- function() {
 fibA <- 1
 fibB <- 1
 cat(fibA, ", ", fibB, ", ", sep = "")
 repeat {
  temp <- fibA + fibB
  fibA <- fibB
  fibB <- temp
  cat(fibB, ", ", sep = "")
  if (fibB > 150) {
   cat("BREAK NOW...")
   break
  }
 }
}
myFib()

# Adding Arguments --------------------------------------------------------
# Rather than printing a fixed set of terms, let's add an argument to control how many Fibonacci
# numbers are printed. Consider the following modification:
myFib2 <- function(thresh) {
 fibA <- 1
 fibB <- 1
 cat(fibA, ", ", fibB, sep = "")
 repeat {
  temp <- fibA + fibB
  fibA <- fibB
  fibB <- temp
  cat(fibB, ", ", sep = "")
  if (fibB > thresh) {
   cat("BREAK NOW...")
   break
  }
 }
}
myFib2(thresh = 300)

# Returning Results -------------------------------------------------------
# If you want to use results of a function in future operations (rather than just printing 
# output to the console), you need to return content to the user. Continuing with the current
# example, here's a Fibonacci function that stores the sequence in a vector and returns it:
myFib3 <- function(thresh) {
 fibSeq <- c(1, 1)
 counter <- 2
 repeat {
  fibSeq <- c(fibSeq, fibSeq[counter - 1] +fibSeq[counter])
  counter <- counter + 1
  if (fibSeq[counter] > thresh) {
   break
  }
 }
 return(fibSeq)
}
myFib3(300)
# Thus the assigned vector ultimately becomes the returnedObject...

# Using return ------------------------------------------------------------
# If there's no return statement inside a function, the function will end when the last line in 
# the body code has been run, at which point it will return the most recently assigned or created 
# object in the function. If nothing is created, such as in the initial fib functions, the 
# function returns NULL. To demonstrate, see the following dummy functions:
dummy1 <- function() {
 aa <- 2.5
 bb <- "string me along"
 cc <- "string 'em up'"
 dd <- 4:8
}
foo <- dummy1()
foo
# See how the function only assigns four different objects and does not explicitly return 
# anything. 

dummy2 <- function() {
 aa <- 2.5
 bb <- "string me along"
 cc <- "string 'em up"
 dd <- 4:8
 return(bb)
}
bar <- dummy2()
bar
# ... whereas dummy2 creates the same four objects and explicitly returns bb. 

# Note: a function will end as soon as it evaluates the return command, without executing any 
# remaining code in the function body.

# ==========================================================================================
# Exercise 11.1 -----------------------------------------------------------
# ==========================================================================================
# Write another Fibonacci sequence. The function should provide an option to perform either the
# operations available in myFib2, where the sequence is simply printed to the console, or the 
# operations in myFib3, where a vector of the sequence is formally returned. Your function 
# should take two arguments: the first, thresh, should define the limit of the sequence (just 
# as in myFib2 or myFib3); second, printime should be a logical value. If TRUE, then the 
# function should just print; if FALSE, then the function should return a vector.

myFibonacci <- function(thresh, printime) {
  if (printime == TRUE) {
    fibA <- 1
    fibB <- 1
    cat(fibA, ", ", fibB, sep = "")
    repeat {
      temp <- fibA + fibB
      fibA <- fibB
      fibB <- temp
      cat(fibB, ", ", sep = "")
      if (fibB > thresh) {
        cat("BREAK NOW...")
        break
      }
    }
  } else if (printime == FALSE) {
    fibSeq <- c(1, 1)
    counter <- 2
    repeat {
      fibSeq <- c(fibSeq, fibSeq[counter - 1] + fibSeq[counter])
      counter <- counter + 1
      if (fibSeq[counter] > thresh) {
        break
      }
    }
    return(fibSeq)
  }
}

# Test on following:
myFibonacci(thresh = 150, printime = TRUE)
myFibonacci(thresh = 1000000, printime = TRUE)
myFibonacci(thresh = 150, printime = FALSE)
myFibonacci(thresh = 1000000, printime = FALSE)

# b. i) Make your factorial while loop a function:
myFac <- function(x) {
myNum <- x
counter <- 1
myCond <-  counter < myNum
if (x < 0) {
  return(NaN)
}
if (myCond == FALSE) {
  myFactorial <- 1
  return(myFactorial)
  } else if (myCond == TRUE) {
    while (myCond == TRUE)  {
      if (counter == 1) {
    myFactorial <- myNum * (myNum - counter) 
    counter <- counter + 1
    } 
      if (counter > 1 & myNum > counter) {
        myFactorial <- myFactorial * (myNum - counter)
        counter <- counter + 1
        } else {
          myCond <- FALSE
        }
      }
    return(myFactorial)
   }
}
# Test it on factorials of 5, 12, and 0:
myFac(x = 5)
myFac(x = 12)
myFac(x = 0)
# ... correct!

# ii). Now, modify the function so that it returns negative-integers to be NaNs:
myFac(x = -6)
# ... correct!

# ==========================================================================================
# Arguments ---------------------------------------------------------------
# ==========================================================================================
# Arguments are an essential part of most R functions. This section considers how R evaluates 
# functions.

# Lazy Evaluation ---------------------------------------------------------
# Lazy evaluation refers to the instance where arguments are evaluated only when they are 
# needed. Thus, they are accessed and used only at the point they appear in the function body.

# Let's see exactly how R functions recognise and use arguments during execution. We'll write
# a function to search through a specified list for matrix objects and attempt tp post multiply
# each with another matrix specified as a second argument. The function will store and return
# the result in a new list. If no matrices are in the supplied list or if no appropriate 
# matrices are present, the function should return a character string informing the user of 
# these facts. 
multiplesOne <- function(x, matrix, stringOne, stringTwo) {
  matrixFlags <- sapply(x, FUN = is.matrix)
  
  if (!any(matrixFlags)) {
    return(stringOne)
  }
  
  indexes <- which(matrixFlags)
  counter <- 0
  result <- list()
  for (i in indexes) {
    temp <- x[[i]]
    if (ncol(temp) == nrow(matrix)) {
      counter <- counter + 1
      result[[counter]] <- temp %*% matrix
    }
  }
  
  if (counter == 0) {
    return(stringTwo)
  } else {
    return(result)
  }
}
# Now let's test the function:
foo <- list(matrix(1:4, nrow = 2, ncol = 2), "not a matrix",
            "definitely not a matrix", matrix(1:8, nrow = 2, ncol = 4),
            matrix(1:8, nrow = 4, ncol = 2))
bar <- list(1:4, "not a matrix", c(FALSE, TRUE, TRUE, TRUE), "??")
baz <- list(1:4, "not a matrix", c(FALSE, TRUE, TRUE, TRUE), "??", 
            matrix(1:8, nrow = 2, ncol = 4))
multiplesOne(x = foo, matrix = diag(2), stringOne = "No matrices in 'x'", 
             stringTwo = "Matrices in 'x', but none meeting appropriate 
             dimensions given matrix = ...")
multiplesOne(x = bar, matrix = diag(2), stringOne = "No matrices in 'x'", 
             stringTwo = "Matrices in 'x', but none meeting appropriate 
             dimensions given matrix = ...")
multiplesOne(x = baz, matrix = diag(2), stringOne = "No matrices in 'x'", 
             stringTwo = "Matrices in 'x', but none meeting appropriate 
             dimensions given matrix = ...")

# Notice: the string arguments stringOne and stringTwo are used only wjen the argument x does
# not contain a matrix with the appropriate dimensions. R evaluates the defined expressions 
# lazily, dictating that argument values are sought only at the moment they are required 
# during execution. Thus, here stringOne and stringTwo are required only when the input list
# doesn't have suitable matrices, so you could lazily ignore providing values for these 
# arguments when x = foo.
multiplesOne(x = foo, matrix = diag(2))
# ... but this is not the case with the bar matrix:
multiplesOne(x = bar, matrix = diag(2))

# Setting Defaults --------------------------------------------------------
# The previous example shows a case where it's useful to set default values for certain 
# arguments. So, let's write a new function of the multiplesOne function, which includes 
# default values for stringOne and stringTwo:
multiplesTwo <- function(x, matrix, stringOne = "No valid matrices.", 
                         stringTwo = stringOne) {
  matrixFlags <- sapply(x, FUN = is.matrix)
  
  if (!any(matrixFlags)) {
    return(stringOne)
  }
  
  indexes <- which(matrixFlags)
  counter <- 0
  result <- list()
  for (i in indexes) {
    temp <- x[[i]]
    if (ncol(temp) == nrow(matrix)) {
      counter <- counter + 1
      result[[counter]] <- temp %*% matrix
    }
  }
  
  if (counter == 0) {
    return(stringTwo)
  } else {
    return(result)
  }
}
multiplesTwo(x = foo, matrix = diag(2))
# ... and now this is the case with the bar matrix:
multiplesTwo(x = bar, matrix = diag(2))

# Checking for Missing Arguments ------------------------------------------
# The missing function checks the arguments of a function to see if all the required arguments
# have been supplied. It takes an argument tag and returns a single logical value. You can use
# missing to avoid the error you saw in the example of multiplesOne.

# In some situations the missing function can be particularly useful in the body code. Consider
# another modification to the multiples function:
multiplesThree <- function(x, matrix, str1 = "No valid matrices.", 
                         str2 = str1) {
  matrixFlags <- sapply(x, FUN = is.matrix)
  
  if (!any(matrixFlags)) {
    if (missing(str1)) {
      return("'str1' argument missing.")
    } else {
    return(str1)
    }
  }
  
  indexes <- which(matrixFlags)
  counter <- 0
  result <- list()
  for (i in indexes) {
    temp <- x[[i]]
    if (ncol(temp) == nrow(matrix)) {
      counter <- counter + 1
      result[[counter]] <- temp %*% matrix
    }
  }
  
  if (counter == 0) {
    if (missing(str2)) {
      return("'str2' argument missing.")
    } else {
    return(str2)
    }
  } else {
    return(result)
  }
}
multiplesThree(foo, diag(2))
multiplesThree(bar, diag(2))
multiplesThree(baz, diag(2))
# Thus, using missing this way permits arguments to be left unsupplied in a given function call.
# It is primarily used when it's difficult to choose a default value for a certain argument, 
# yet the function still needs to handle cases when the argument isn't provided. However, in the
# current example, it makes more sense to define defaults for str1 and str2, and avoid the extra
# code required to implement missing.

# Dealing with Ellipses ---------------------------------------------------
# The dot-dot-dot notation allows you to pass extra arguments without having to first define
# them in the argument list, and these arguments can then be passed to another function call
# within the code body. When included in a function definition, the ellipses is often placed in
# the last position because it represents a variable number of arguments. 

# Building on the myFibonacci function, let's use the ellipses to write a function that can 
# plot the specified Fibonacco numbers:
myFibonnaciPlot <- function(thresh, plot = TRUE, ...) {
  fibSeq <- c(1, 1)
  counter <- 2
  repeat {
    fibSeq <- c(fibSeq, fibSeq[counter - 1] + fibSeq[counter])
    counter <- counter + 1
    if (fibSeq[counter] > thresh) {
      break
    }
  }
  
  if (plot) {
    plot(1:length(fibSeq), fibSeq, ...)
  } else {
    return(fibSeq)
  }
}
myFibonnaciPlot(150)
# In this function, an if statement checks to see whether the plot argument is TRUE (which is 
# the default value). If so, then the function calls plot. You can spruce things up by 
# specifying more plotting options, for example:
myFibonnaciPlot(thresh = 150, plot = TRUE, type = "b", pch = 4, lty = 2, 
                main = "Terms of the Fibonnaci sequence", ylab = "Fibonnaci number",
                xlab = "nth term")

# ==========================================================================================
# Exercise 11.2 -----------------------------------------------------------
# ==========================================================================================
# a. Given a principal investment ammount P, an interest rate per annum i%, and a frequency of 
# interest paid per year t, the final amount F after y years is given as:

#   F = P(1 + (i / 100t))^(t*y)

# Write a function that can compute F as per the following notes:
# - Arguments must be present for P, i, t, and y. The argument for t should have a default 
#   value of 12.
# i.e. P = ..., i = ..., t = ..., y = ...

# - Another argument giving a logical value that determines whether to plot the amount F at 
# each integer time should be included.

# - If this function is plotted, it should always be a stepplot, so plot should always be 
#   called with type = "s".

# - If plot = FALSE, the final amount F should be returned as a numeric vector corresponding to
#   the same integer times, as shown earlier. 

# - An ellipses should also be included to control other details of plotting, if it takes place.

F_interest <- function(P, i, t, y, plot = TRUE, CompRate = TRUE, ...) {
  temp <- matrix(nrow = y)
  if (CompRate & plot) {
    for (j in 1:y) {
      temp[[j]] <- 100*(1 + (22.9 / (100 * 12)))^(12 * j)
      }
    plot(temp, type = "s", ...)
    return(as.numeric(temp))
  }
  if (CompRate & !plot) {
    for (j in 1:y) {
      temp[[j]] <- 100*(1 + (22.9 / (100 * 12)))^(12 * j)
      }
    return(as.numeric(temp))
    }  
  if (!CompRate & !plot) {
    for (j in 1:y) {
      temp[[j]] <- 100*(1 + (22.9 / (100 * 12)))^(12 * j)
      }
    return(as.numeric(temp))
  }
}
# Test:
# i)
F_interest(P = 5000, i = 4.4, t = 12, y = 10)
# ... correct!

# ii) 
F_interest(P = 100, i = 22.9, t = 12, y = 20, ylab = "Balance (F)", xlab = "Year (y)")
# ... correct!

# iii)
exe3 <- F_interest(P = 100, i = 22.9, t = 1, y = 20, plot = FALSE)
plot(exe3, pch = 16, ylab = "Balance (F)", xlab = "Year (y)")
lines(x = exe3, type = "s", col = "grey", lty = 3, lwd = 2)
legend("topleft", legend = c("nth Year Balance (F)", "Compounded Interest (t)"), 
       pch = c(16, NA), lty = c(NA, 3), col = c("black", "grey"), lwd = c(NA, 3))
arrows(x0 = 7, y0 = 7600, x1 = 11.3, y1 = 2000)
arrows(x0 = 8.2, y0 = 8800, x1 = 18.5, y1 = 7600)

# ==========================================================================================
# Specialised Functions ---------------------------------------------------
# ==========================================================================================
# We will look at three kinds of specialised user-defined R functions.

# ==========================================================================================
# Helper Functions --------------------------------------------------------
# ==========================================================================================
# A helper function is a general terms used to describe functions written and used specifically
# to facilitate the computations carried out by another function. They're a good way to improve
# the readability of complicated functions. 

# A helper function can be either internally or externally defined.

# Externally Defined ------------------------------------------------------
# Building on the multiplesTwo function, here's a new version that splits the functionality 
# over two separate functions, one of which will be externally defined:
multiples_helper_ext <- function(x, matrix.flags, mat) {
  indexes <- which(matrix.flags)
  counter <- 0
  result <- list()
  for (i in indexes) {
    temp <- x[[i]]
    if (ncol(temp) == nrow(mat)) {
      counter <- counter + 1
      result[[counter]] <- temp %*% mat
    }
  }
  return(list(result, counter))
}

multiplesFour <- function(x, mat, str1 = "No valid matrices", str2 = str1) {
  matrix.flags <- sapply(x, FUN = is.matrix)
  
  if (!any(matrix.flags)) {
    return(str1)
  }
  
  helper.call <- multiples_helper_ext(x, matrix.flags, mat)
  result <- helper.call[[1]]
  counter <- helper.call[[2]]
  
  if (counter == 0) {
    return(str2)
  } else {
    return(result)
  }
}

# Internally --------------------------------------------------------------
multiplesFive <- function(x, mat, str1 = "No valid matrices", str2 = str1) {
  matrix.flags <- sapply(x, FUN = is.matrix)
  
  if (!any(matrix.flags)) {
    return(str1)
  }
  
  multiples_helper_ext <- function(x, matrix.flags, mat) {
    indexes <- which(matrix.flags)
    counter <- 0
    result <- list()
    for (i in indexes) {
      temp <- x[[i]]
      if (ncol(temp) == nrow(mat)) {
        counter <- counter + 1
        result[[counter]] <- temp %*% mat
        }
      }
    return(list(result, counter))
    }
  
  helper.call <- multiples_helper_ext(x, matrix.flags, mat)
  result <- helper.call[[1]]
  counter <- helper.call[[2]]
  
  if (counter == 0) {
    return(str2)
  } else {
    return(result)
  }
}

# ==========================================================================================
# Disposable Functions ----------------------------------------------------
# ==========================================================================================
# Often, you may need a function that performs a simple, one-line task. For example, when you 
# use apply, you'll typically just want to pass a short, simple function as an argument. That's
# where disposable (or anonymous) functions come in - they allow you to define a function 
# intended for use in a single instance without explicitly creating a new object in your global
# environment. 

# Say you have a numeric matrix whose columns you want to repeat twice and then sort:
foo <- matrix(data = c(2, 3, 3, 4, 2, 4, 7, 3, 3, 6, 7, 2), nrow = 3, ncol = 4)
foo
# ... this is a perfect task for apply:
apply(foo,MARGIN = 2, FUN = function(x) {sort(rep(x, 2))})

# The function is defined in the standard form direclty in the call to apply.

# ==========================================================================================
# Recurvive Functions -----------------------------------------------------
# ==========================================================================================
# Recursion is when a function calls itself. This technique isn't commonly used in statistical
# analyses, but it's worth it to be knowledge of it.

# Suppse you want to write a function that takes a single positive integer argument n and 
# returns the correpsonding nth term of the Fibonacci sequence. In previous sections, the 
# Fibonacci sequence was built in an iterative fashion by using a loop. In a recursive 
# function, instead of using a loop to repeat an operation, the function calls itself multiple
# times. Consider the following:
myFibrec <- function(n) {
  if (n == 1 || n == 2) {
    return(1)
  } else {
    return((myFibrec(n - 1) + myFibrec(n - 2)))
  }
}
myFibrec(5)

# Note: have not completed final exercises as they are relatively basic and intuitive for me.
# End file ----------------------------------------------------------------