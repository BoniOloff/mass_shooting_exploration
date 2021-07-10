library(shiny)
library(readr)
library(lubridate)
library(magrittr)
library(leaflet)

data <- read_csv("mass_shootings_1982_2021.csv")
data$date <- mdy(data$date)

ui <- bootstrapPage(
    title = "Mass Shooting Exploration",
    theme = shinythemes::shinytheme('yeti'),
    leaflet::leafletOutput('map', width = '100%', height = '100%'),
    absolutePanel(top = 10, right = 10, id = 'controls',
                  sliderInput('nb_fatalities', 'Minimum Fatalities', 1, max(data$fatalities), 10),
                  dateRangeInput('date_range', 'Select Date Range', min(data$date), max(data$date)),
    ),
    tags$style(type = "text/css", "
    html, body {width:100%;height:100%}
    #controls{background-color:white;padding:20px;}
    ")
)

server <- function(input, output) {
    mass_shootings_filtered <- reactive({
        data %>%
            dplyr::filter(
                date >= as_date(input$date_range[1]),
                date <= as_date(input$date_range[2]),
                fatalities >= input$nb_fatalities
            )
    })
    
    output$map <- leaflet::renderLeaflet({
        mass_shootings_filtered() %>% 
        leaflet() %>%
        addTiles() %>%
        setView( -98.58, 39.82, zoom = 5) %>% 
        addCircleMarkers(
            popup = ~ summary,
            radius = ~ fatalities,
            fillColor = 'red', color = 'red', weight = 1
        )
    })
}

shinyApp(ui = ui, server = server)