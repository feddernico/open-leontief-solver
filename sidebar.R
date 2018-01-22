dashboardSidebar(
        sidebarMenu(
                id = "tabMenu",
                
                # Overall KPIs
                menuItem("Readme", tabName = "readme", icon = icon("file")),
                menuItem("Input Data", tabName = "input", icon = icon("database")),
                menuItem("Solver", tabName = "solver", icon = icon("calculator")),
                
                
                
                sliderInput("n_industries", h4("Number of industries:"), 
                            min = 3, max = 15, value = 5, step = 1),
                submitButton("Update Model", icon("refresh"))
        )
)