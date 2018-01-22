Open Leontief Solver
========================================================
author: Federico Viscioletti 
date: 1/17/2018
autosize: true


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

# generates a 5 x 5 consumption matrix
C <- generateOpen(5); C
```

```
            [,1]       [,2]       [,3]        [,4]       [,5]
[1,] 0.111626473 0.19659323 0.17515098 0.149321368 0.16236612
[2,] 0.180552691 0.13844739 0.01315655 0.043296987 0.13709462
[3,] 0.007417716 0.09819259 0.10954386 0.056173119 0.03588688
[4,] 0.006158115 0.09750236 0.05724366 0.000161776 0.13556443
[5,] 0.119012932 0.05006637 0.17061717 0.016698104 0.17064129
```


Demand Vector
========================================================

To generate a demand vector, which is a random vector of external demand volumes, we will use the same random function, and select just the first column and multiplying it by 100, this will be our demand vector  


```r
# generates a random external demand vector for all five industries
D <- 100 * generateOpen(5)[, 1]; D
```

```
[1] 13.400183  8.630779  6.399920 15.189368 18.674417
```

Solving the model
========================================================

Internal consumption is $C \times P$. So if P is our production vector and $D$ our demand, $P - C \times P = D$, the consumption of external industries.

We of course want to find the level of production that meets internal and external demand.

$$P - C \times P = P (I - C) = D$$

If $C$ is productive (sum of each row/col is less than 1), $(I - C)$ is guaranteed to be invertible.


```r
p <- solve(diag(5) - C)%*%D; p
```

```
         [,1]
[1,] 32.30285
[2,] 23.15219
[3,] 12.71349
[4,] 22.66388
[5,] 31.62155
```

Conclusion
========================================================

Using this we can answer some useful questions like: 

 - Given current external demand, what should every industry be producing?


```r
barplot(p, main = "Production", beside = TRUE, xlab = "Industries", names.arg = c("1", "2", "3", "4", "5"), las = 1)
```

![plot of chunk unnamed-chunk-4](presentation-figure/unnamed-chunk-4-1.png)

Sources
========================================================

 - https://www.youtube.com/watch?v=1p3Xlo5hqys
 - https://youtube.com/watch?v=UxVbDJ3ERas
 - http://www.math.ksu.edu/~gerald/leontief.pdf
 - http://home2.fvcc.edu/~dhicketh/LinearAlgebra/studentprojects/spring2006/nicholaskallem/Leontief%20project.htm
 - https://www.math.ucdavis.edu/~daddel/linear_algebra_appl/Applications/Leonteif_model/Leontief_model_9_19/Leontief_model_9_19.html
 - Math-23 and Paul Bamberg's R Scripts
