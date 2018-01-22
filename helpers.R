# generates a [t x t] productive economy consumption matrix
generateOpen <- function(t) {
        m <- NULL
        for (i in 1:t) {
                m <- cbind(m, c(round(runif(t, min = 0, max = (1/t)), 2)))
        }
        return(m)
}

