library(shiny)
library(readr)

data <- read_csv("mass_shootings_1982_2021.csv")

ui <- fluidPage(

    titlePanel("Mass Shootings Exploration")
    
)

server <- function(input, output) {
    
}

shinyApp(ui = ui, server = server)