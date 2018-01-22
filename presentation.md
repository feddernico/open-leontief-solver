Open Leontief Solver
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
           [,1]       [,2]       [,3]       [,4]        [,5]
[1,] 0.05265670 0.01318616 0.09793100 0.18235973 0.049248702
[2,] 0.02087187 0.04479925 0.14253633 0.07882243 0.142918222
[3,] 0.14058573 0.04801368 0.01128215 0.13547265 0.006228984
[4,] 0.06731539 0.11241884 0.14561655 0.05778927 0.038034080
[5,] 0.10394454 0.11441348 0.02702524 0.16840664 0.018181561
```


Demand Vector
========================================================

To generate a demand vector, which is a random vector of external demand volumes, we will use the same random function, and select just the first column and multiplying it by 100, this will be our demand vector  


```r
# generates a random external demand vector for all five industries
D <- 100 * generateOpen(5)[, 1]; D
```

```
[1] 12.697136 19.186696 15.071158 17.127307  7.564739
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
[1,] 22.58927
[2,] 29.24822
[3,] 23.79304
[4,] 27.72206
[5,] 18.91465
```

Conclusion
========================================================

Using this we can answer some useful questions like: 

 - Given current external demand, what should every industry be producing?

Conclusion - plot
========================================================


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
