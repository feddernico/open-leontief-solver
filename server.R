library(shiny)

source("helpers.R")

shinyServer(function(input, output) {
        
        ## Global Variables
        rv <- reactiveValues()
        
        # observe changes in the input values
        observe({
                rv$m <- generateOpen(input$n_industries)
                
                rownames(rv$m) <- industries.institutions[1:nrow(rv$m), 2]
                colnames(rv$m) <- industries.institutions[1:nrow(rv$m), 2]
                
                rv$dfm <- as.data.frame(rv$m)
                
        })
        
        model <- reactive({
                brushed_data <- brushedPoints(trees, input$brush1, xvar = "Girth",
                                              yvar = "Volume")
                
                if(nrow(brushed_data) < 2) {
                        return(NULL)
                }
                lm(Volume ~ Girth, data = brushed_data)
        })
        
        # Generates a random consumption matrix for the Leontief problem
        output$consumptionMatrix <- renderDataTable({
                rv$dfm
        })
        
        output$demandVector <- renderDataTable({
                
        })
})