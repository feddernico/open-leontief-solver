library(markdown)
library(plotly)
library(shiny)
library(shinyjs)
library(shinydashboard)

shinyUI(fluidPage(theme = "css/main.css",
                  
        # Adds the Roboto font to the available fonts
        tags$head(HTML("<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>")),
        
        # Dashboard layout
        dashboardPage(
        
                # header layout file
                source("header.R", local = T)$value,
                
                # sidebar layout file
                source("sidebar.R", local = T)$value,
                
                dashboardBody(
                        tabItems(
                                tabItem(tabName = "main",
                                        fluidRow(
                                                box(
                                                        id = "consumption_matrix",
                                                        title = "Consumption Matrix",
                                                        status = "primary",
                                                        collapsible = TRUE,
                                                        solidHeader = TRUE,
                                                        width = 12,
                                                        dataTableOutput("consumptionMatrix")
                                                )
                                        )
                                ),
                                tabItem(tabName = "tutorial",
                                        fluidRow(
                                                box(
                                                        id = "tutorial",
                                                        title = "Tutorial",
                                                        status = "primary",
                                                        collapsible = TRUE,
                                                        solidHeader = TRUE,
                                                        width = 12,
                                                        includeMarkdown("readme.Rmd")
                                                )
                                        )       
                                )
                        )
                )
        )
))