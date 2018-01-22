library(shiny)

source("helpers.R")

shinyServer(function(input, output) {
        
        ## Global Variables
        rv <- reactiveValues()
        
        # observe changes in the input values
        observe({
                
        })
        
        model <- reactive({
                brushed_data <- brushedPoints(trees, input$brush1, xvar = "Girth",
                                              yvar = "Volume")
                
                if(nrow(brushed_data) < 2) {
                        return(NULL)
                }
                lm(Volume ~ Girth, data = brushed_data)
        })
        
        output$consumptionMatrix <- renderDataTable({
                
                
                m <- generateOpen(input$n_industries)
                
                rownames(m) <- industries.institutions[1:nrow(m), 2]
                colnames(m) <- industries.institutions[1:nrow(m), 2]
                
                as.data.frame(m)
                
        })
})