Open Leontief Solver
========================================================
author: Federico Viscioletti 
date: 1/17/2018
autosize: true

<style>
.small-code pre code {
  font-size: 1em;
}
</style>


The Shiny app developed is a solver for the Open Leontief model

- The Open Leontief model is part of a branch of operational research called Input-Output analysis
- It is a way to describe and model an economy where there is external demand outside of the interrelated industries
- Is opposed to the Closed Leontief model which viceversa describes an economy without any external demand.


Consumption matrix
========================================================
class: small-code

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
           [,1]       [,2]       [,3]       [,4]       [,5]
[1,] 0.06180232 0.02064721 0.10797674 0.05640529 0.02872462
[2,] 0.16906275 0.09554726 0.07749790 0.08411975 0.12829147
[3,] 0.13418629 0.09475015 0.04694639 0.11260326 0.08882951
[4,] 0.18415156 0.02169703 0.05387261 0.04658061 0.01875123
[5,] 0.13737788 0.08113988 0.13171286 0.06383354 0.18414119
```


Demand Vector
========================================================
class: small-code

To generate a demand vector, which is a random vector of external demand volumes, we will use the same random function, and select just the first column and multiplying it by 100, this will be our demand vector  


```r
# generates a random external demand vector for all five industries
D <- 100 * generateOpen(5)[, 1]; D
```

```
[1]  9.393502 16.681422 19.726510  3.450167 11.991165
```

Solving the model
========================================================
class: small-code

Internal consumption is $C \times P$. So if P is our production vector and $D$ our demand, $P - C \times P = D$, the consumption of external industries.

We of course want to find the level of production that meets internal and external demand.

$$P - C \times P = P (I - C) = D$$

If $C$ is productive (sum of each row/col is less than 1), $(I - C)$ is guaranteed to be invertible.


```r
p <- solve(diag(5) - C)%*%D; p
```

```
          [,1]
[1,] 15.336510
[2,] 28.302926
[3,] 29.159055
[4,]  9.374888
[5,] 25.535807
```

Conclusion
========================================================
class: small-code

Using this we can answer some useful questions like: 

 - Given current external demand, what should every industry be producing?


```r
barplot(p, main = "Production", beside = TRUE, xlab = "Industries", names.arg = c("1", "2", "3", "4", "5"), las = 1)
```

![plot of chunk unnamed-chunk-4](presentation-figure/unnamed-chunk-4-1.png)

Sources
========================================================

The repository for all the Shiny code developed is hosted here: https://github.com/feddernico/open-leontief-solver/

 - https://www.youtube.com/watch?v=1p3Xlo5hqys
 - https://youtube.com/watch?v=UxVbDJ3ERas
 - http://www.math.ksu.edu/~gerald/leontief.pdf
 - http://home2.fvcc.edu/~dhicketh/LinearAlgebra/studentprojects/spring2006/nicholaskallem/Leontief%20project.htm
 - https://www.math.ucdavis.edu/~daddel/linear_algebra_appl/Applications/Leonteif_model/Leontief_model_9_19/Leontief_model_9_19.html
 - Math-23 and Paul Bamberg's R Scripts
