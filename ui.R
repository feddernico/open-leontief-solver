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
                                tabItem(tabName = "readme",
                                        fluidRow(
                                                column(12, h2("Readme"),
                                                       HTML("<hr />"))
                                        ),
                                        fluidRow(
                                                box(
                                                        id = "readme",
                                                        title = "",
                                                        width = 12,
                                                        withMathJax(includeMarkdown("readme.Rmd"))
                                                )
                                        )       
                                ),
                                tabItem(tabName = "input",
                                        fluidRow(
                                                column(12, h2("Input Data"),
                                                       HTML("<hr />"))
                                        ),
                                        fluidRow(
                                                box(
                                                        id = "consumption_matrix",
                                                        title = "Consumption Matrix",
                                                        status = "primary",
                                                        collapsible = TRUE,
                                                        width = 12,
                                                        DT::dataTableOutput("consumptionMatrix")
                                                )
                                        ),
                                        fluidRow(
                                                box(
                                                        id = "demand_vector",
                                                        title = "Demand Vector",
                                                        status = "warning",
                                                        collapsible = TRUE,
                                                        width = 12,
                                                        DT::dataTableOutput("demandVector")
                                                )
                                        )
                                ),
                                tabItem(tabName = "solver",
                                        fluidRow(
                                                column(12, h2("Solver"),
                                                       HTML("<hr />"))
                                        ),
                                        fluidRow(
                                                box(
                                                        id = "solver",
                                                        title = "Solver",
                                                        status = "primary",
                                                        collapsible = TRUE,
                                                        width = 6,
                                                        DT::dataTableOutput("productionVector")
                                                ),
                                                box(
                                                        id = "production_plot",
                                                        title = "Prodution",
                                                        collapsible = TRUE,
                                                        width = 6,
                                                        plotOutput("productionPlot")
                                                )
                                        )
                                )
                        )
                )
        )
))