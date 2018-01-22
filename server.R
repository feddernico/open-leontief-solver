library(DT)
library(shiny)

source("helpers.R")

shinyServer(function(input, output) {
        
        ## Global Variables
        rv <- reactiveValues(trigger = 0)

        # creates the consumption matrix reactively
        consumptionMatrix <- reactive({
                input$input$n_industries
                withProgress(message = 'Creating consumption matrix', value = 0.5, {
                        C <- generateOpen(input$n_industries)
                        rownames(C) <- industries.institutions[1:nrow(C), 2]
                        colnames(C) <- industries.institutions[1:ncol(C), 2]
                        return(C)
                })
        })
        
        # creates the demand vector
        demandVector <- reactive({
                withProgress(message = 'Creating demand vector', value = 0.5, {
                        D <- as.data.frame(100 * generateOpen(input$n_industries)[, 1])
                        rownames(D) <- industries.institutions[1:nrow(D), 2]
                        colnames(D) <- "Demand"
                        return(D)
                })
        })
        
        productionVector <- reactive({
                withProgress(message = 'Solving the Leontief model', value = 0.5, {
                        P <- solve(diag(input$n_industries) - rv$C) %*% as.vector(rv$D[, 1])
                        rownames(P) <- industries.institutions[1:nrow(P), 2]
                        colnames(P) <- "Production"
                        return(P)
                })
        }) 
        
        # solves the problem
        
        # observe changes in the input values
        observe({
                # creates the consumption matrix
                rv$C <- consumptionMatrix()
                
                # creates the demand vector
                rv$D <- demandVector()
                
                # solves the model and saves the Production vector into a variable
                rv$P <- productionVector()
        })
        
        # Generates a random consumption matrix for the Leontief model
        output$consumptionMatrix <- DT::renderDataTable({
                DT::datatable(as.data.frame(rv$C), options = list(pageLength = 25))
        })
        
        # Generates a random demand vector for the Leontief model
        output$demandVector <- DT::renderDataTable({
                DT::datatable(rv$D, options = list(pageLength = 25))
        })
        
        # Solves the Leontief model and shows the result in a data table
        output$productionVector <- DT::renderDataTable({
                DT::datatable(rv$P, options = list(pageLength = 25))
        })
        
        output$productionPlot <- renderPlot({
                barplot(rv$P, main = "Production", beside = TRUE, xlab = "Industries", 
                        names.arg = rownames(rv$P), las = 1)
        })
})