presentation
========================================================
author: Federico Viscioletti 
date: 1/17/2018
autosize: true

Introduction
========================================================

The Shiny app developed is a solver for the Open Leontief model

- The Open Leontief model is part of a branch of operational research called Input-Output analysis
- It is a way to describe and model an economy where there is external demand outside of the interrelated industries
- Is opposed to the Closed Leontief model which viceversa describes an economy without any external demand.

Consumption matrix
========================================================

The core of the Shiny app is represented by a function which randomly generates a consumption matrix. The matrix represents the flows among each sector of the economy described


```r
# generates a t x t productive economy consumption matrix
generateOpen <- function(t) {
        m <- NULL
        for (i in 1:t) {
                m <- cbind(m, c(runif(t, min = 0, max = (1/t))))
        }
        return(m)
}
```

Consumption matrix - example
========================================================


```r
# generates a 5 x 5 consumption matrix
C <- generateOpen(5); C
```

```
             [,1]       [,2]      [,3]       [,4]       [,5]
[1,] 0.1231753082 0.05522136 0.1379053 0.18025292 0.04359406
[2,] 0.1000745854 0.12149475 0.1902300 0.06830827 0.07834090
[3,] 0.0003958454 0.03155534 0.1200691 0.13333110 0.19063047
[4,] 0.0321416918 0.03561477 0.1406450 0.14704422 0.10814213
[5,] 0.1692157816 0.13938399 0.1333258 0.13229187 0.14040502
```


Demand Vector
========================================================

To generate a demand vector, which is a random vector of external demand volumes, we will use the same random function, and select just the first column and multiplying it by 100, this will be our demand vector  


```r
# generates a random external demand vector for all five industries
D <- 100 * generateOpen(5)[, 1]; D
```

```
[1] 15.9152503 13.9944673  0.4236157 15.7808228  0.2763460
```

Solving the model
========================================================

Internal consumption is $C \times P$. So if P is our production vector and $D$ our demand, $P - C \times P = D$, the consumption of external industries.

We of course want to find the level of production that meets internal and external demand.

$$P - C \times P = P (I - C) = D$$

If $C$ is productive (sum of each row/col is less than 1), $(I - C)$ is guaranteed to be invertible.

Solving the model - view
========================================================


```r
p <- solve(diag(5) - C)%*%D; p
```

```
          [,1]
[1,] 26.476336
[2,] 23.791499
[3,]  8.017719
[4,] 23.623791
[5,] 14.270579
```

Conclusion
========================================================

Using this we can answer some useful questions like: Given current external demand, what should every industry be producing?


```r
barplot(p, main = "Production", beside = TRUE, xlab = "Industries", names.arg = c("1", "2", "3", "4", "5"), las = 1)
```

![plot of chunk unnamed-chunk-5](presentation-figure/unnamed-chunk-5-1.png)

Sources
========================================================

 - https://www.youtube.com/watch?v=1p3Xlo5hqys
 - https://youtube.com/watch?v=UxVbDJ3ERas
 - http://www.math.ksu.edu/~gerald/leontief.pdf
 - http://home2.fvcc.edu/~dhicketh/LinearAlgebra/studentprojects/spring2006/nicholaskallem/Leontief%20project.htm
 - https://www.math.ucdavis.edu/~daddel/linear_algebra_appl/Applications/Leonteif_model/Leontief_model_9_19/Leontief_model_9_19.html
 - Math-23 and Paul Bamberg's R Scripts