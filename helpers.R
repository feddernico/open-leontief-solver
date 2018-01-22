# generates a [t x t] productive economy consumption matrix
generateOpen <- function(t) {
        m <- NULL
        for (i in 1:t) {
                m <- cbind(m, c(round(runif(t, min = 150, max = (100000/t)), 2)))
        }
        return(m)
}

