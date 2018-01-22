dashboardSidebar(
        sidebarMenu(
                id = "tabMenu",
                
                # Overall KPIs
                menuItem("Overview", tabName = "main", icon = icon("calculator")),
                menuItem("Readme", tabName = "readme", icon = icon("file")),
                
                sliderInput("n_industries", "Number of industries:", 
                            min = 3, max = 15, value = 5, step = 1)
        )
)