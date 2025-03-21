# Create sample data
# set.seed(123)
x <- 1:20
y <- x + rnorm(20, 0, 3)
categories <- sample(LETTERS[1:3], 20, replace = TRUE)

# Create a simple scatter plot with base R
plot(x, y, 
     main = "Simple Scatter Plot with Base R",
     xlab = "X Values", 
     ylab = "Y Values",
     pch = 19,
     col = factor(categories))

# Add a legend
legend("topleft", 
       legend = unique(categories),
       col = 1:length(unique(categories)), 
       pch = 19,
       title = "Categories")

# Add a trend line
abline(lm(y ~ x), col = "blue", lwd = 2)
