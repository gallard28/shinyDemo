#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(babynames)
data(babynames)

# Define UI for application that draws a histogram
ui <- fluidPage(
    titlePanel('Baby Names Explorer'),
    h4('Based on the exercises on DataCamp.'),
    
    sidebarLayout(
        sidebarPanel(
            textInput('name', 'Enter your name here'),
        ),
        mainPanel(
            plotOutput('trend'),
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$trend <- renderPlot({
        ggplot(subset(babynames, name==input$name))+
            geom_line(aes(x=year, y=prop, color=sex))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
