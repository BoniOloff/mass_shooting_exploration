library(shiny)
library(readr)
library(lubridate)

data <- read_csv("mass_shootings_1982_2021.csv")
data$date <- mdy(data$date)

ui <- bootstrapPage(
    title = "Mass Shooting Exploration",
    theme = shinythemes::shinytheme('yeti'),
    leaflet::leafletOutput('map', width = '100%', height = '100%'),
    absolutePanel(top = 10, right = 10, id = 'controls',
                  sliderInput('nb_fatalities', 'Minimum Fatalities', 1, max(data$fatalities), 10),
                  dateRangeInput('date_range', 'Select Date Range', min(data$date), max(data$date)),
    )
)

server <- function(input, output) {
    
}

shinyApp(ui = ui, server = server)