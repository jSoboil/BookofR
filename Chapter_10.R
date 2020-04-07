# =========================================================================================
# Conditions and Loops ----------------------------------------------------
# =========================================================================================
# Chapter 10 from the Book of R.

# =========================================================================================
# if Statements -----------------------------------------------------------
# =========================================================================================
# An if statement runs a block of code only if a certain value is true.
if (condition) {
 do any code here
}
# The condition statement must be a logical value (TRUE or FALSE). For example:
a <- 3
myNum <- 4

if (a <= myNum) {
 a <- a^2
}
# Because the condition statement is true, as a is less than 4, a is evaluated to be a^2, 
# which then executes the code chunk to make a 9.
a

# Will it be executed again? No! Because a is now 9, which is greater than 4.

# To illustrate a more complex if statement, consider the following two new objects:
myVec <- c(2.73, 5.40, 2.15, 5.29, 1.36, 2.16, 1.41, 6.97, 7.99, 9.52)
myVec

myMat <- matrix(data = c(2, 0, 1, 2, 3, 0, 3, 0, 1, 1), nrow = 5, ncol = 2)
myMat

# Using these objects in a complex if statement can be, for example, something like:
if (any(myVec - 1) > 9 || matrix(myVec, nrow = 2, ncol = 5)[2, 1] <= 6) {
 cat("Condition satisfied: \n")
 newMyVec <- myVec
 newMyVec[seq(from = 1, to = 9, by = 2)] <- NA
 myList <- list(aa = newMyVec, bb = myMat + .5)
 cat("- a list with", length(myList), "members now exists.")
}
myList

# Let's walk through it.

# The first condition looks at myVec, minuses 1 from each element ,and checks whether any of 
# the results are greater than 9:
myVec - 1
(myVec - 1) > 9
any(myVec - 1) > 9

# The second part of the condition uses potential matching in a call to matrix to construct a
# two-row, five-column, column-filled matrix using entries of the original myVec vector. Then,
# the number in the second row of the first column of that result is checked to see whether 
# it's less than or equal to 6, which it is:
matrix(myVec, nrow = 2, ncol = 5)
matrix(myVec, nrow = 2, ncol = 5)[2, 1]
matrix(myVec, nrow = 2, ncol = 5)[2, 1] <= 6

# Therefore, the overall condition being chekced by the if statement will be FALSE || TRUE, 
# whuch evaluates to:
 any(myVec - 1) > 9 || matrix(myVec, nrow = 2, ncol = 5)[2, 1] <= 6
# As a result, the code inside the braces is accessed and executed. 
 
 # The accessed code first prints the "Condition satisfied" string and copes myVec to newMyVec.
 # Using seq(), it then accesses the odd-numbered indexes of newMyVec and overwrites them with
 # NA. Next, it createss myList. In this list, myNewVec is stored in a member named aa, and
 # then takes the original myMat, increases all its elements by .5, and stores the result in 
 # bb. Lastly, it prints the length of the resulting list.
 
# =========================================================================================
# else Statements ---------------------------------------------------------
# =========================================================================================
 # If you want something different to happen when the condition is FALSE, you can add an else
 # declaration. Here's a pseudo-code example:
 if (condition) {
  # do any code in here if condition is TRUE
 } else {
  # do any code in here if condition is FALSE
 }
 
a <- 3
myNum <- 4 

if (a <= myNum) {
 # ... if we execute the if statement once...
 cat("Condition was", a >= myNum)
 a <- a^2
} else {
 # ... if we execute for if statement twice...
 cat("Condition was", a <= myNum)
 a <- a - 3.5
}
a 

# =========================================================================================
# Using ifelse for Element-wise Checks ------------------------------------
# =========================================================================================
# An if statement can check the condition of only a single logical value. If you pass in, for
# example, a vector of logicalss for the condition, the if statement will only check (and 
# operate based on) the very first element. It will issue a warning saying as much, for 
# example:
if (c(FALSE, TRUE, FALSE, TRUE, TRUE)) {
 
}
# ... there is, however, a shortcut function available, ifelse, which can perform this kind of 
# vector-orientated check in relatively simple cases. To deminstrate how it worksm consider 
# the following objects x and y:
x <- 5
y <- -5:5 
x/y
# Now suppose you want to produce the result of x/y, but with any instance of Inf (where x is 
# divided by zero) replaced by NA. In other words, for each element in y, you want to check 
# whether y is zero. If so, you want the code to output NA, and if not, it should output the 
# result of x/y.

# As you've just seen, a simple if statement won't work here. Since it accepts only a single
# logical value,  it can't run through the entire logical vector produced by y == 0:
y == 0
# Instead, you can use the element-wise ifelse functuon for this kind of scenario:
Output <- ifelse(test = y == 0, yes = NA, no = x/y)
Output 

# =========================================================================================
# Exercise 10.1 -----------------------------------------------------------
# =========================================================================================
#  a. Using the following vectors, determine which if statement will result in the string 
#     being printed to the console:
vec1 <- c(2, 1, 1, 3, 2, 1, 0)
vec2 <- c(3, 8, 2, 2, 0, 0, 0) 
# if statement ii.:
if (vec1[1] >= 2 && vec2[1] >= 2) {
  cat("Print me!")
} 

# b. Using vec1 and vec2 from (a), write and execute a line of code that multiplies the 
# corresponding elements of the two vectors together if their sum is greater than 3. 
# Otherwise, the code should simply sum the two elements:
ifelse(test = vec1 + vec2 > 3, yes = vec1 * vec2, no = vec1 + vec2)

# c. Write an if statement that takes a square character matrix and checks if any of the
# character strings on the diagonal begin with the letter g, both lower- and upper-case. If
# satisfied, these specific entries should be overwritten with the string "HERE", otherwise
# the matrix should be replaced with an identity matrix of the same dimensions. Then try your
# code on the following matrices:
myMat <- matrix(as.character(1:16), nrow = 4, ncol = 4)

myMat_2 <- matrix(c("DANDELION", "Hyacinthus", "Gerbera",
                    "MARIGOLD", "geranium", "ligularia", 
                    "Pachysandra", "SNAPDRAGON", "GLADIOLUS"), 
                  nrow = 3, ncol = 3)

myMat_3 <- matrix(c("GREAT", "exercises", "right", "here"), 
                  nrow = 2, ncol = 2, byrow = TRUE)

# test/condition...
# any(substr(diag(myMat_2), start = 1, stop = 1) == "g" | 
#       substr(diag(myMat_2), start = 1, stop = 1) == "G")

# Replacement:
# sub(pattern = "^g\\w+", replacement = "HERE", x = diag(myMat_2), 
#     ignore.case = TRUE)

# Identity matrix...
# diag(x = nrow(myMat_2))

# Create function...
finderFUNC <- function(x) {
  if (any(substr(diag(x), start = 1, stop = 1) == "g" | 
      substr(diag(x), start = 1, stop = 1) == "G")) {
  x <- sub(pattern = "^g\\w+", replacement = "HERE", x = diag(x),
      ignore.case = TRUE)
  } else {
    x <- diag(x = nrow(x))
  }
  print(x)
}

finderFUNC(myMat)
finderFUNC(myMat_2)
finderFUNC(myMat_3)

# =========================================================================================
# Nesting and Stacking Statements -----------------------------------------
# =========================================================================================
# if statement inception...

# For example, of we modify the mynumber condition a bit, we can get:
if (a <= myNum) {
  cat("First condition was TRUE\n")
  a <- a^2
  if (myNum > 3) {
    cat("Second condition was TRUE\n")
    b <- seq(1, a, length.out = myNum)
  } else {
    cat("Second condition was FALSE\n")
    b <- a * myNum
    }
  } else {
    cat("First condition was FALSE\n")
    a <- a - 3.5
    if (myNum >= 4) {
      cat("Second condition was TRUE")
      b <- a^(3 - myNum)
    } else {
      cat("Second condition was FALSE")
      b <- rep(x = a + myNum, times = 3)
    }
  }

# Alternatively you could accomplish the same thing by sequentially stacking if statements and
# using a combination of logical expression in each condition; known as else if statements:
if (a <= myNum && myNum > 3) {
  cat("Same as 'first condition TRUE and second TRUE'")
  a <- a^2
  b <- b <- seq(1, a, length.out = myNum)
} else if (a <= myNum && myNum <= 3) {
  cat("Same as 'first condition TRUE and second FALSE'")
  a <- a^2
  b <- a * myNum
} else if (myNum >= 4) {
  cat("Same as 'first condition FALSE and second TRUE'")
  a <- a - 3.5
  b <- a^(3 - myNum)
} else {
  cat("Same as 'first condition FALSE and second FALSE'")
  a <- a - 3.5
  b <- rep(a + myNum, times = 3)
}
a
b

# =========================================================================================
# The switch Function -----------------------------------------------------
# =========================================================================================
# Let's say you need to choose which code to run based on the value of a single object (a 
# common scenario). One option is to use a series of if statements, where you compare the 
# object with various pssoble values to produce a logical value for each condition. Setting 
# up if-else statements can be quite cumbersome. R can handle this multiple-choice decision
# in a much more compact form, using the switch() function. For example:
myString <- "Lisa"
foo <- switch (EXPR = myString, Homer = 12, Marge = 34, Bart = 56, Lisa = 78,
               Maggie = 90, NA)
foo
# and...
myString <- "Peter"
foo <- switch (EXPR = myString, Homer = 12, Marge = 34, Bart = 56, Lisa = 78, Maggie = 90,
               NA)
foo

# The first argument, EXPR, is the object of interest and can be either a numeric or character
# string. The remaining arguments provide the values or operations to carry out based on the 
# value OF EXPR. If EXPR is a string, these argument tags must exactly match the possible 
# results of EXPR, i.e. in the above, if the element evaluates to Homer it switches it to a 
# value of 12.

# The integer version of switch works in a slightly different way. Instead of using tags, the 
# outcome is determined purely with positional matching. Consider the following:
nyNum <- 3
foo <- switch (EXPR = nyNum, 12, 34, 56, 78, NA)
foo
# ... here you provide the interger nyNum and the furst aregument, and it's positionally 
# matched to EXPR. The example code then shows five untagged arguments: 12 to NA. The switch 
# function simply returns the value in the specific position requested by myNum/EXPR. 

# The switch function therefore behaves the same way as a set of stacked if statements, and can
# serve as a convenient shortcut. However, keep in mind that if you need to examine multiple 
# positions at once, or you need to execute a more complicated set of operations based on this
# decision, you'll need to use the explicit if and else control statements. 
myMat[myNum]

# =========================================================================================
# Exercise 10.2 -----------------------------------------------------------
# =========================================================================================
# a. Write an explicit stacked set of if statements that does the same thing as the integer 
# version of the switch function.

# Object:
x <- c(1, 2, 66, 2, 4, 5, 6)
x

# Condition:
length(myNum) <= length(x)
                        
# Find sequence:
# x[myNum] <- myNum

# Tested with: 
myNum <- 3

if (myNum[1] == 0) {
  print(NULL)
} else if (length(myNum) <= length(x)) {
  x[myNum] <- myNum
  print(x)
  } else if (length(myNum) >= length(x)) {
    print("No matching element found.")
  }

# Tested with: 
myNum <- 0

if (myNum[1] == 0) {
  print(NULL)
} else if (length(myNum) <= length(x)) {
  x[myNum] <- myNum
  print(x)
  } else if (length(myNum) >= length(x)) {
    print("No matching element found.")
  }

# Tested with: 
myNum <- rep(x = 1, times = 50)

if (myNum[1] == 0) {
  print(NULL)
} else if (length(myNum) <= length(x)) {
  x[myNum] <- myNum
  print(x)
  } else if (length(myNum) >= length(x)) {
    print("No matching element found.")
  }

# b. Supposed you are tasked with computing the precise dosage amounts of a certain drug in a
# collection of hypothetical scientific experiments. These amounts depend on some 
# pre-determined set of "dosage thresholds" (lowdose, meddose, and highdose), as well as a
# predetermined dose level factor vector named doselevel. Look at the following items (i-iv) 
# to see the intended form of these objects. Then write a set of nested if statements that
# produce a new numeric vector called dosage according to the following rules:

# if there are any instances of "High" in doselevel, perform the following operations:
#   if (any(doselevel == "High")) {
#   }

#   Check if lowdose is greater than or equal to 10. If so, overwrite lowdose with 10; otherwise
#   overwrite lowdose by itself divided by 2.
# if (lowdose >= 10) {
#     lowdose <- 10
#     } else {
#       lowdose <- (lowdose / 2)
#       }


#   Check if meddose is greater than or equal to 26. If so, overwrite meddose by 26. 
# if (meddose >= 26) {
#   meddose <- 26
# }

#   Check if highdose is less than 60. If so, overwrite highdose with 60; otherwise overwrite 
#   highdose by itself myultiplied by 1.5.
# if (highdose < 60) {
#   highdose <- 60
# } else {
#   highdose <- highdose * 1.5
# }

#   Create a vector named dosage with the value of lowdose repeated to match the length of 
#   doselevel.
# dosage <- rep(x = lowdose, length.out = length(doselevel))

#   Overwrite the elements in dosage corresponding to the index positions of instances of "Med"
#   in doselevel by meddose.
# dosage[doselevel == "Med"] <- meddose

#   Overwrite elements in dosage correpsonding to the index positions of instance of "High" in
#   doselevel by highdose.
# dosage[doselevel == "High"] <- highdose

# Otherwise (in other words, if there are no instances of "High" in doselevel), perform the
# following operations:
# else
#   Create a new version of doselevel, a factor with levels "Low" and "Med" only, and label 
#   those with "Small" and "Large", respectively. (Refer to factor() function...)
# doselevel <- factor(doselevel[doselevel == "Low" | doselevel == "Med"], 
#                       levels = c("Low", "Med"), labels = c("Small", "Large"))

#   Check to see if lowdose is less than 15 AND meddose is less than 35. If so, overwrite 
#   lowdose by itself multiplied by 2 and overwrite meddose by itself plus highdose.
# if (lowdose < 15 & meddose < 35) {
#   lowdose <- lowdose * 2
#   meddose <- meddose + highdose
# }

#   Create a vector named dosage, which is the value of the lowdose repeated to match the 
#   length of doselevel. 
# dosage <- rep(lowdose, length.out = length(doselevel))

#   Overwrite the elements in dosage corresponding to the index positions of instances of 
#   "Large" in doselevel by meddose.
# dosage[doselevel== "Large"] <- meddose

# Using:
lowdose <- 12.5
meddose <- 25.3
highdose <- 58.1
doselevel <- factor(c("Low", "High", "High", "High", "Low", "Med", "Med"), 
                    levels = c("Low", "Med", "High"))

if (any(doselevel == "High")) {
  if (lowdose >= 10) {
    lowdose <- 10
    } else {
      lowdose <- (lowdose / 2)
    } 
  if (meddose >= 26) {
  meddose <- 26
  }
  if (highdose < 60) {
  highdose <- 60
  } else {
    highdose <- highdose * 1.5
  }
  dosage <- rep(x = lowdose, length.out = length(doselevel))
  dosage[doselevel == "Med"] <- meddose
  dosage[doselevel == "High"] <- highdose
} else {
  doselevel <- factor(doselevel[doselevel == "Low" | doselevel == "Med"], 
                      levels = c("Low", "Med"), labels = c("Small", "Large"))
  if (lowdose < 15 & meddose < 35) {
  lowdose <- lowdose * 2
  meddose <- meddose + highdose
  }
  dosage <- rep(lowdose, length.out = length(doselevel))
  dosage[doselevel == "Large"] <- meddose
}
# Should be:
dosage
# ...correct!

# Using the the same lowdose, meddose, and highdose thresholds as in above,
lowdose <- 12.5
meddose <- 25.3
highdose <- 58.1
# but given:
doselevel <- factor(c("Low", "Low", "Low", "Med", "Low", "Med", "Med"), 
                    levels = c("Low", "Med", "High"))

if (any(doselevel == "High")) {
  if (lowdose >= 10) {
    lowdose <- 10
    } else {
      lowdose <- (lowdose / 2)
    } 
  if (meddose >= 26) {
  meddose <- 26
  }
  if (highdose < 60) {
  highdose <- 60
  } else {
    highdose <- highdose * 1.5
  }
  dosage <- rep(x = lowdose, length.out = length(doselevel))
  dosage[doselevel == "Med"] <- meddose
  dosage[doselevel == "High"] <- highdose
} else {
  doselevel <- factor(doselevel[doselevel == "Low" | doselevel == "Med"], 
                      levels = c("Low", "Med"), labels = c("Small", "Large"))
  if (lowdose < 15 & meddose < 35) {
  lowdose <- lowdose * 2
  meddose <- meddose + highdose
  }
  dosage <- rep(lowdose, length.out = length(doselevel))
  dosage[doselevel == "Large"] <- meddose
}
# Should be:
dosage
doselevel
# ... correct!

# Now, given:
lowdose <- 9
meddose <- 49
highdose <- 61
doselevel <- factor(c("Low", "Med", "Med"), 
                    levels = c("Low", "Med", "High"))

if (any(doselevel == "High")) {
  if (lowdose >= 10) {
    lowdose <- 10
    } else {
      lowdose <- (lowdose / 2)
    } 
  if (meddose >= 26) {
  meddose <- 26
  }
  if (highdose < 60) {
  highdose <- 60
  } else {
    highdose <- highdose * 1.5
  }
  dosage <- rep(x = lowdose, length.out = length(doselevel))
  dosage[doselevel == "Med"] <- meddose
  dosage[doselevel == "High"] <- highdose
} else {
  doselevel <- factor(doselevel[doselevel == "Low" | doselevel == "Med"], 
                      levels = c("Low", "Med"), labels = c("Small", "Large"))
  if (lowdose < 15 & meddose < 35) {
  lowdose <- lowdose * 2
  meddose <- meddose + highdose
  }
  dosage <- rep(lowdose, length.out = length(doselevel))
  dosage[doselevel == "Large"] <- meddose
}
# Should be:
dosage
doselevel
# ... correct!

#  the same thresholds as experiment (iii) and the same doselevel as experiment (i):
lowdose <- 9
meddose <- 49
highdose <- 61
doselevel <- factor(c("Low", "High", "High", "High", "Low", "Med", "Med"), 
                    levels = c("Low", "Med", "High"))

if (any(doselevel == "High")) {
  if (lowdose >= 10) {
    lowdose <- 10
    } else {
      lowdose <- (lowdose / 2)
    } 
  if (meddose >= 26) {
  meddose <- 26
  }
  if (highdose < 60) {
  highdose <- 60
  } else {
    highdose <- highdose * 1.5
  }
  dosage <- rep(x = lowdose, length.out = length(doselevel))
  dosage[doselevel == "Med"] <- meddose
  dosage[doselevel == "High"] <- highdose
} else {
  doselevel <- factor(doselevel[doselevel == "Low" | doselevel == "Med"], 
                      levels = c("Low", "Med"), labels = c("Small", "Large"))
  if (lowdose < 15 & meddose < 35) {
    
  meddose <- meddose + highdose
  }
  dosage <- rep(lowdose, length.out = length(doselevel))
  dosage[doselevel == "Large"] <- meddose
}
# Should be:
dosage
# ... correct!

# =========================================================================================
# Coding Loops ------------------------------------------------------------
# =========================================================================================
# The loop repears a specified section of code, often while incrementing an index or counter. 
# There are teo types of looping: the for loop repeats code as it works its way through a 
# vector, element by element; the while loop simply releats code until a specific condition 
# evaluates to FALSE. Loop-like behaviour can also be achieved with the various apply functions.

# for Loops:
for (loopindex in loopvector) {
  # do any code here
}

# You can also use loops to manipulate objects that exist outside the loop. Consider the 
# following example:
counter <- 0
for (myitem in 5:7) {
  counter <- counter + 1
  cat("The item in run ", counter, " is ", myitem, "\n")
}

# Here, we have initially defined an object, counter, and set it to zero in the workspace. Then,
# inside the loop, counter is overwritten by itself plus 1. Each time the loop repeats, counter
# increases, and the current value is printed to the console.

# Looping via Index or Value:
# Note the diffeence between the loopindex to directly represent elements in the loopvector and
# using it to represent indexes of a vector. The following to examples illustrate the 
# difference:
myVec <- c(.4, 1, .1, .34, .55)
for (i in myVec) {
  print(2 * i)
}

for (i in 1:length(myVec)) {
  print(2 * myVec[i])
}
# The first loop uses the loopindex i to directly represent the elements in myVec, printing the
# value of each element times 2. In the second loop, on the other hand, you use i to represent 
# integers in the sequence 1:length(myVecx); these integers form all the possible index 
# positions of myVec, and you use these indexes to extract myVec's elements.

# Though longer, the second approach provides greater flexibility in terms of how you can use
# the loopindex. For example, suppose you want to write some code that will inspect any list 
# object and gather information about any matrix objects stored as memebers in the list. 
# Consider the following:
foo <- list(aa = c(3.4, 1), bb = matrix(1:4, nrow = 2, ncol = 2), 
            cc = matrix(c(TRUE, TRUE, FALSE, TRUE, FALSE, FALSE), nrow = 3, ncol = 2), 
            dd = "string here", ee = matrix(c("red", "green", "blue", "yellow")))
foo
# Now foo contains three matrices of varying dimensions and data types. We will write a for 
# loop that goes through each member of a list like this one and checks whether the member is
# matrix. If it is, the loop will retrieve the number of rows and columns and the data type of
# the matrix. 

# Before we write the for loop, we should create some vectors that will store information about
# the list members: name for the list member names, isMat to indicate whether each member is a 
# matrix, nc and nr to store the number of each rows and columns for each matrix, and dataType 
# to store the data type of each matrix:
name <- names(foo)
isMat <- rep(NA, length(foo))
nr <- isMat
nc <- isMat
dataType <- isMat

# These values will be updated appropriately by the for loop:
for (i in 1:length(foo)) {
  member <- foo[[i]]
  if (is.matrix(member)) {
    isMat[i] <- "Yes"
    nr[i] <- nrow(member)
    nc[i] <- ncol(member)
    # This final command first coerces the matrix
    # into a vector with as.vector and then uses
    # the class function to find the data type
    # of the elements:
    dataType[i] <- class(as.vector(member))
  } else {
    # If the member is not a matrix, and the if
    # statement fails, the corresponding entry in
    # isMat is set to "No" and therefore the entries
    # in the other vectors aren't changed, and 
    # remain as NA entries!
    isMat[i] <- "No"
  }
}
bar <- data.frame(name, isMat, nr, nc, dataType, stringsAsFactors = FALSE)
# Note the use of stringAsFactors = FALSE in order to prevent the character string vectors in 
# bar being automatically converted to factors!
bar

# =========================================================================================
# Nesting for Loops:
# =========================================================================================
# You can also nest for loops, just like if statements. When a for loop is nested in another 
# for loop, the inner loop is executed in full before the outer loop loopindex is incremented,
# at which point the inner loop is executed all ofer again. Let's try it out with the following
# objects:
loopVec1 <- 5:7
loopVec2 <- 9:6

# Create a matrix to store the results...
foo <- matrix(NA, length(loopVec1), length(loopVec2))

# The following nested loop fills foo with the result of multiplying each integer in loopVec1
# by each integer in loopVec2:
for (i in 1:length(loopVec1)) {
  for (j in 1:length(loopVec2)) {
    foo[i, j] <- loopVec1[i] * loopVec2[j]
  }
}
foo

# Note: nested loops require a unique loopindex for each use of for; hence i, j. i for the 
# outer loop and j for the inner loop. When the code is executed, i is first assigned 1, the 
# inner begins, and then j is assigned 1. The only command in the inner loop is to take the
# product of the ith element of loopVec1 and the jth element of loopVec2 and assign it to row
# i, column j of foo. The inner loop repeats until j reaches length(loopVec2) and fills the 
# first row of foo; then i increments, and the inner loop is started up again. The entire
# procedure is complete after i reaches length(loopVec1) and the matrix is filled.

# inner loopvectors can even be defined to match the current value of the loopindex of the 
# outer loop. Using loopVec1 and loopVec2, here's an example:
foo <- matrix(NA, length(loopVec1), length(loopVec2))

for (i in 1:length(loopVec1)) {
  for (j in 1:i) {
    foo[i, j] <- loopVec1[i]+loopVec2[j]
  }
}
foo
# Here, the ith row, jth column element of foo is filled with the sum of loopVec1[i] and 
# loopVec2[j]. However, the inner loop values for j are now decided based on the value of i. 
# For example, when i is 1, the inner loopvector is 1:1, so the immer loop executes only once
# before returning, and so on. Therefore, extra care must be taken when programming loops this
# way! 

# =========================================================================================
# Exercise 10.3 -----------------------------------------------------------
# =========================================================================================
# a. In the interest of efficient coding, rewrite the nested loop example from this section, 
# where the matrix foo was filled with the multiples of the elements of loopVec1 and loopVec2,
# using only a single for loop:
loopVec1 <- 5:7
loopVec2 <- 9:6

# Create a matrix to store the results...
foo <- matrix(NA, length(loopVec1), length(loopVec2))
foo
# for loop:
for (i in 1:length(loopVec1)) {
  foo[i, ] <- loopVec1[i] * loopVec2
}
foo

# b. The switch function will not evaluate if the object supplied is a character vector. Write
# some code that will take a character vector and return a vector of the appropriate numeric 
# values. Test it out on the following:
myString <- c("Peter", "Homer", "Lois", "Stewie", "Maggie", "Bart")
any(is.character(myString))


if (any(is.character(myString))) {
  myVec <- rep(NA, length(myString))
  for (i in 1:length((myString))) {
    myVec[i] <- switch (EXPR = myString[i], Homer = 12, Marge = 34, Bart = 56, 
                        Lisa = 78, Maggie = 90, NA)
  }
  myString <- myVec
}

myString
any(is.character(myString))
# Correct! 

# c. Suppose you have a list named myList that can contain other lists as members, but assume 
# those "member lists" cannot themselves contain lists. Write nested loops that can search any
# possible myList defined in this way and count how many matrices are present. 
myList <- list(aa = c(3.4, 1), bb = matrix(1:4, nrow = 2, ncol = 2), 
               cc = matrix(c(TRUE, TRUE, FALSE, TRUE, FALSE, FALSE), nrow = 3, ncol = 2),
               dd = "string here", ee = list(c("hello", "you"), matrix(c("hello",
                                                                         "there"))),
               ff = matrix(c("red", "green", "blue", "yellow")))


counter <- 0
for (i in 1:length(myList)) {
  memberList <- myList[[i]]
  if (is.matrix(memberList) == TRUE) {
    counter <- counter + 1
    } else {
      for (j in 1:length(memberList)) {
        subListmember <- memberList[[j]]
        if (is.matrix(subListmember == TRUE)) {
          counter <- counter + 1
        }
      }
    }
  }
counter
# ... correct! 

myList <- list("tricked you", as.vector(matrix(1:6, nrow = 3, ncol = 2)))

counter <- 0
for (i in 1:length(myList)) {
  memberList <- myList[[i]]
  if (is.matrix(memberList) == TRUE) {
    counter <- counter + 1
    } else {
      for (j in 1:length(memberList)) {
        subListmember <- memberList[[j]]
        if (is.matrix(subListmember == TRUE)) {
          counter <- counter + 1
        }
      }
    }
  }
counter
# ... correct!

myList <- list(list(1, 2, 3), list(c(3, 2), 2), list(c(1, 2), matrix(c(1, 2))),
               rbind(1:10, 100:91))

counter <- 0
for (i in 1:length(myList)) {
  memberList <- myList[[i]]
  if (is.matrix(memberList) == TRUE) {
    counter <- counter + 1
    } else {
      for (j in 1:length(memberList)) {
        subListmember <- memberList[[j]]
        if (is.matrix(subListmember == TRUE)) {
          counter <- counter + 1
        }
      }
    }
  }
counter
# ... correct!

# =========================================================================================
# while Loops -------------------------------------------------------------
# =========================================================================================
# To use for loops, one must know, or be able to calculate, the number of times the loop
# should repeat.  In situations where you don't know how manu times the desired operations
# need to be run, you can turn to the while loop. A while loop runs and repeats while a 
# specified condition returns TRUE, and takes on the general form:
while (loopcondition) {
  # do any code in here
}

# For example:
myVal <- 5
while (myVal < 10) {
  myVal <- myVal + 1
  cat("\n 'myVal' is equal to ", myVal,",\n")
  cat("'my condition' is now", myVal < 10, "\n")
}

# In more complicated settings, it's often useful to set the loopcondition to be a seperate 
# object so that you can modify it as necessary within the braced area. For the next example,
# you'll use a while loop to iterate through an integer vector and create an identity matrix
# with the dimension matching the current integer. This loop should stop when it raches a 
# number in the vector thats greater than 5 or when it reaches the end of the integer 
# vector:
myList <- list()
counter <- 1
myNums <- c(4, 5, 1, 2, 6, 2, 4, 6, 6, 2)
myCond <- myNums[counter] <= 5

while (myCond) {
  myList[[counter]] <- diag(myNums[counter])
  counter <- counter + 1
    if (counter <= length(myNums)) {
    myCond <- myNums[counter] <= 5
    } else {
    myCond <- FALSE
  }
}
myList

# =========================================================================================
# Exercise 10.4 -----------------------------------------------------------
# =========================================================================================
# a. Based on the most recent example of storing identity matrices in a list, determine 
# what the resulting myList would look like for each of the following possible myNums 
# vectors, without executing anything:
myList <- list()
counter <- 1
myNums <- c(2, 2, 2, 2, 5, 2)
myCond <- myNums[counter] <= 5

while (myCond) {
  myList[[counter]] <- diag(myNums[counter])
  counter <- counter + 1
  if (counter <= length(myNums)) {
    myCond <- myNums[counter] <= 5
  } else {
    myCond <- FALSE
  }
}
myList

myList <- list()
counter <- 1
myNums <- 2:20
myCond <- myNums[counter] <= 5

while (myCond) {
  myList[[counter]] <- diag(myNums[counter])
  counter <- counter + 1
  if (counter <= length(myNums)) {
    myCond <- myNums[counter] <= 5
  } else {
    myCond <- FALSE
  }
}
myList

myList <- list()
counter <- 1
myNums <- c(10, 1, 10, 1, 2)
myCond <- myNums[counter] <= 5

while (myCond) {
  myList[[counter]] <- diag(myNums[counter])
  counter <- counter + 1
  if (counter <= length(myNums)) {
    myCond <- myNums[counter] <= 5
  } else {
    myCond <- FALSE
  }
}
myList

# b. For this problem, we introduce the factorial operator. The factorial of a non-negative 
# integer x, expressed as x!, refers to x multiplied by the product of all integers less 
# than x, down to 1.

# Write a while loop that computes and stores as a new object the factorial of any 
# non-negative integer myNum by decrementing myNum by 1 at each repitition of the braced
# code.

# 5 factorial is 120:
myNum <- 5
counter <- 1
myCond <-  counter < myNum

if (myCond == FALSE) {
  myFactorial <- 1
  print(myFactorial)
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
   print(myFactorial)
}
# ... correct!

# 12 factorial is 479001600:
myNum <- 12
counter <- 1
myCond <-  counter < myNum

if (myCond == FALSE) {
  myFactorial <- 1
  print(myFactorial)
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
   print(myFactorial)
}
# ... correct!

# 0 factorial is 1:
myNum <- 0
counter <- 1
myCond <-  counter < myNum

if (myCond == FALSE) {
  myFactorial <- 1
  print(myFactorial)
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
   print(myFactorial)
}
# ... correct!

# c. Consider the following code, where the operations in the braced area of the while loop have
# been omitted:
myString <- "R fever"
index <- 1
eCount <- 0
result <- myString

while (eCount < 2 && index <= nchar(myString)) {
  # several omitted operations
}
# ... result

# The task is to complete the code in the braced area so it inspects myString character by
# character until it reaches the second instance of the letter e or the end of the string, 
# whichever comes first. The result object should be the entire character string if there is
# no second e or the character string made up of all the characters up to, but not including, 
# the second e if there is one.

# For example, myString <- "R fever" should provide a result as "R fev". This must be achieved
# by following these operations in the braces:
#   1. Use substr() to extract the single character of myString at position index
indexedChar <- substr(x = myString, start = index, stop = index)
indexedChar
#   2. Use a check of equality to determine whether this single-character string is either "e"
#   OR "E". If so, increase eCount by 1.
indexedChar == "e" || indexedChar == "E"

#   3. Next, perform separate check to see whether eCount is equal to 2. If so, use substr to
#   set result equal to the characters between 1 and index-1 inclusive.
eCount == 2
result <- substr(x = myString, start = 1, stop = (index - 1))
result

#   4. Increment index by 1.
index <- index + 1

while (eCount < 2 && index <= nchar(myString)) {
  indexedChar <- substr(x = myString, start = index, stop = index)
  if (indexedChar == "e" || indexedChar == "E") {
    eCount <- eCount + 1
  }
  if (eCount == 2) {
    result <- substr(x = myString, start = 1, stop = (index - 1))
  } else {
    index <- index + 1
  }
}
result
# ... correct!

# Test the code on the following:
myString <- "beautiful"
# Reset counters:
index <- 1
eCount <- 0
result <- myString

while (eCount < 2 && index <= nchar(myString)) {
  indexedChar <- substr(x = myString, start = index, stop = index)
  if (indexedChar == "e" || indexedChar == "E") {
    eCount <- eCount + 1
  } else if (index == nchar(myString)) {
    result <- myString
  }
  if (eCount == 2) {
    result <- substr(x = myString, start = 1, stop = (index - 1))
  } else {
    index <- index + 1
  }
}
result
# ... correct!

# Test the code on the following:
myString <- "ECCENTRIC"
# Reset counters:
index <- 1
eCount <- 0
result <- myString

while (eCount < 2 && index <= nchar(myString)) {
  indexedChar <- substr(x = myString, start = index, stop = index)
  if (indexedChar == "e" || indexedChar == "E") {
    eCount <- eCount + 1
  } else if (index == nchar(myString)) {
    result <- myString
  }
  if (eCount == 2) {
    result <- substr(x = myString, start = 1, stop = (index - 1))
  } else {
    index <- index + 1
  }
}
result
# ... correct!

# Test the code on the following:
myString <- "ElAbOrAte"
# Reset counters:
index <- 1
eCount <- 0
result <- myString

while (eCount < 2 && index <= nchar(myString)) {
  indexedChar <- substr(x = myString, start = index, stop = index)
  if (indexedChar == "e" || indexedChar == "E") {
    eCount <- eCount + 1
  } else if (index == nchar(myString)) {
    result <- myString
  }
  if (eCount == 2) {
    result <- substr(x = myString, start = 1, stop = (index - 1))
  } else {
    index <- index + 1
  }
}
result
# ... correct!

# Test the code on the following:
myString <- "eeeeek!"
# Reset counters:
index <- 1
eCount <- 0
result <- myString

while (eCount < 2 && index <= nchar(myString)) {
  indexedChar <- substr(x = myString, start = index, stop = index)
  if (indexedChar == "e" || indexedChar == "E") {
    eCount <- eCount + 1
  } else if (index == nchar(myString)) {
    result <- myString
  }
  if (eCount == 2) {
    result <- substr(x = myString, start = 1, stop = (index - 1))
  } else {
    index <- index + 1
  }
}
result
# ... correct!

# =========================================================================================
# Implicit Looping with apply ---------------------------------------------
# =========================================================================================
# In some situations, especially for relatively routine for loops (such as executing some 
# function on each member of a list), you can avoid some details associated with explicit 
# looping by using the apply function. The apply function is the mist basic form of implicit
# looping - it takes a function and applies it to ecah margin of an array.

# To illustrate, take the following example. Let's say you have the following matrix:
foo <- matrix(1:12, nrow = 4, ncol = 3)
foo

# Now say you want to find the sum of each row. If you call the following, you just get the 
# grand tital of all the elements, which is not what you want!
sum(foo)

# Instead, you could use a for loop:
rowTot <- rep(NA, length.out = nrow(foo))

for (i in 1:nrow(foo)) {
  rowTot[i] <- sum(foo[i, ])
}
rowTot

# However, you can also use apply to do the same trick! In apply(), the first argument X is the
# object you want to cycle through, i.e. a matrix. The next argument, MARGIN, takes an integer
# that flags which margin of X to operate on (rows, columns, etc.). Finally, FUN provides the 
# function you want to perform on each margin:
rowTotApply <- apply(X = foo, 1, FUN = sum)
rowTotApply
# Note, that specifying 1 indicates rows, 2 is columns, i.e. standard matrix notation as in
# c(1, 2) or c(i, j) depending of dimensions if it was an array...

# For example, with an array, the FUN specification should be appropriate for the MARGIN 
# selected. So, if you select rows or columns with MARGIN = 1 or MARGIN = 2, make sure the FUN
# function is appropriate for vectors. Or if you have a three-dimensional array and use apply
# with MARGIN = 3, be sure to set FUN to a function approriate for matrices. For example:
bar <- array(data = 1:18, dim = c(3, 3, 2))
bar
apply(X = bar, MARGIN = 3, FUN = diag)
apply(X = bar, MARGIN = 3, FUN = sum)
# i.e. setting MARGIN 3 specifies conditioning the function on the highest dimension, and 
# therefore cycles through the matrices, etc. for rows and columns...

# Other apply Functions ---------------------------------------------------
# There are different flavours of the basic apply function. The tapply function, for example,
# performs operations on subsets of the object of interest, where those subsets are defined
# in terms of one ore more factor vectors. As an example, let's return to the code from a
# previous section whicb reads in a web based data file on diamond pricing, sets appropriate
# variable names of the data frame, and displays the first five rows:
diaURL <- "http://www.amstat.org/publications/jse/v9n2/4Cdata.txt"
diamonds <- read.table(diaURL)
names(diamonds) <- c("Carat", "Colour", "Clarity", "Cert", "Price")
diamonds[1:5, ]

# Now, to add up the total value of the diamonds present for the full data set but separated 
# according to Colour, you can use tapply:
tapply(diamonds$Price, INDEX = diamonds$Colour, FUN = sum)
# ... this sums the relevant elements of the target vector diamonds$Price. The correpsonding
# factor vecetor diamonds$Colour is passed to INDEX, and the function of interest is specified
# with FUN = sum, exactly as earlier.

# Another particularly useful alternative is lapply, which can operate member by member on a 
# list. Recall that we wrote a for loop to inspect matrices in the following list:
baz <- list(
  aa = c(3.4, 1), bb = matrix(1:4, nrow = 2, ncol = 2), 
  cc = matrix(c(TRUE, TRUE, FALSE, TRUE, FALSE, FALSE), nrow = 3, ncol = 2),
  dd = "string here", ee  =matrix(c("red", "green", "blue", "yellow"))
)

# Using lapply, you can check for matrices in the list with a single short line of code:
lapply(baz, FUN = is.matrix)
# ... note: no MARGIN or INDEX information is required for lappy; R knows to apply FUN to each
# member of the specified list. The returned value is itself a list. Another variant, sapply,
# returns the same results as lapply but in vector form:
sapply(baz, FUN = is.matrix)
# As you can see, the difference is that the result is returned as a vector. 

# vapply is an additional variant. which is similar to sapply albeit with some relatively 
# subtle differences, and mapply, which can operate on multiple vectors or lists at once.

# Note: all of R's apply functions allow for additional arguments. For example:
apply(foo, 1, FUN = sort, decreasing = TRUE)

# =========================================================================================
# Exercise 10.5 -----------------------------------------------------------
# =========================================================================================
# a. Continuing from the most recent example. write an implicit loop that calculates the 
# product of all the column elements of the matrix returned by the call:
foo_2 <- apply(foo, 1, FUN = sort, decreasing = TRUE)
apply(foo_2, 2, prod)

# b. Convert the following for loop to an implicit loop that does exactly the same thing:
matList <- list(
  matrix(c(TRUE, FALSE, TRUE, TRUE), nrow = 2, ncol = 2),
  matrix(c("a", "c", "b", "z", "p", "q"), nrow = 3, ncol = 2),
  matrix(1:8, nrow = 2, ncol = 4)
)

for (i in 1:length(matList)) {
  # return transpose of each matrix:
  matList[[i]] <- t(matList[[i]])
}
# Implicit loop:
lapply(matList, t)

# c. In R, store the following 4 x 4 x 2 x 3 array as the object qux:
qux <- array(96:1, dim = c(4, 4, 2, 3))
# It is a four-dimensional array comprised of three blocks, with each block being an array 
# made up of two layers of 4 x 4 matrices. Then do the following:
#   i. Write an implicit loop that obtains the diagonal elements of all second layer matrices
#   only:
apply(qux[, , 2, ], MARGIN = 3, FUN = diag)

#   ii. Write an implicit loop that will return the dim of each of the three matrices followed
#   by accessing the fourth column of every matrix in qux, regardless of layer or block, 
#   wrapped by another implicit loop that finds the row sums of that returned structure:
apply(X = apply(qux, 4, dim), 1, FUN = sum)

# =========================================================================================
# Other Control Flow Mechanisms -------------------------------------------
# =========================================================================================
# To round off this chapter, we look at three control flow mechanisms: break, next, and repeat.
# These mechanisms are often used in conjunction with the loops and if statements we have 
# worked on.

# Declaring break or next -------------------------------------------------
# Normally a for loop will exit only when the loopindex exhausts the loopvector, and a while
# loop will exit only when the loopcondition evaluates to FALSE. But you can also preemptively
# terminate a loop by declaring break.
# For example, say you have a number, foo, that you want to divide by each element in a 
# numeric vector bar:
foo <- 5
bar <- c(2, 3, 1.1, 4, 0, 4.1, 3)

# Furthermore, let's say you want to divide foo by bar element by element but want to halt
# execution if one of the results evaluates to Inf (which will result by dividing by zero!). 
# To do this, you can check each iteration with the is.finite function, and you can issue a 
# break command to terminate the loop if it returns FALSE:
loopResult_1 <- rep(NA, length(bar))
loopResult_1
for (i in 1:length(bar)) {
  temp <- foo/bar[i]
  if (is.finite(temp)) {
    loopResult_1[i] <- temp
  } else {
    break
  }
}
loopResult_1
# Here, the loop divides normally until it reaches the fifth element of bar and divides by 
# zero, resulting in Inf. Upon the resulting conditional check, the loop terminates. 

# Invoking break is a fairly drastic move. Often a programmer will include it only as a safety
# catch that's meant to highlight or prevent unintended calculations. For more routine 
# operations, it is best to use another methods. For instance, the example loop could easily
# be replicated as a while loop or the vector-orientated ifelse function, rather than relying
# on a break.

# Instead of breaking and completely ending a loop, you can use next to simply advance to the
# next iteration and continue execution. Consider the following, where using next avoids
# division by zero:
loopResult_2 <- rep(NA, length(bar))

for (i in 1:length(bar)) {
  if (bar[i] == 0) {
    next
  }
  loopResult_2[i] <- foo/bar[i]
}
loopResult_2
# First the loop checks to see whether the ith element of bar is zero. If it is, next is 
# declared, and as a result, R ignores any subsequent lines of code that are in the braced 
# area of the loop and returns to the top, automatically advancing to the next value of the 
# loopindex.

# Note: if you use either break or next in a nested loop, the command will apply only to the 
# innermost loop. Only that inner loop will exit or advance to the next iteration, and many 
# outer loops will continue as normal. 

# The repeat Statement ----------------------------------------------------
repeat {
  # do any code here
}
# Notice that a repeat statement does not include any kind of loopindex or loopcondition. To
# stop repeating code inside the braces, you *must* use a break decleration inside the braced
# area, usually done within an if statement. Without it, the braced code will repeat without
# end, creating an infinite loop. 

# To see an example of a repeat statement in action, let's calculate the Fibonacco sequence.
# Formally, if Fn represents the nth Fibonacci number, then you have:

#   Fn+1 = Fn + Fn - 1; for n = 2, 3, 4, 5, ...

# where

#   F2 = F1 = 1 

# The following repeat statement computes and prints the Fibinacci sequence, ending when it
# reaches a term greater than 150:
fibA <- 1
fibB <- 1

repeat {
  temp <- fibA + fibB
  fibA <- fibB
  fibB <- temp
  cat(fibB, ", ", sep = "")
  if (fibB > 150) {
    cat("Break now... \n")
    break
  }
}


# End chapter -------------------------------------------------------------