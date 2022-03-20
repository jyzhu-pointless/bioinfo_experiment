x <- rnorm(100)
y <- rnorm(100)
plot(x, y)
plot(x, y, xlab = "x-axis", ylab = "y-axis", main = "Plot of X vs Y")

# save the output
jpeg("Figure.jpg")
plot(x, y, col = "green")
dev.off()

# contour plot
x <- seq(-pi, pi, length = 50)
y <- x
f <- outer(x, y, function(x, y) cos(y)/(1 + x^2))
contour(x, y, f)
contour(x, y, f, nlevels = 45, add = T)
fa = (f - t(f)) / 2
contour(x, y, fa, nlevels = 15)
