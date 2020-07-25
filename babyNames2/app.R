#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    selectInput('sex', 
                'Select Sex', 
                choices= c('M','F'),
                'F'),
    plotOutput('plot_top_10_names')
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$plot_top_10_names <- renderPlot({
        # Get top 10 names by sex and year
        top_10_names <- babynames %>% 
            # MODIFY CODE BELOW: Filter for the selected sex
            filter(sex == input$sex) %>% 
            filter(year == 1900) %>% 
            top_n(10, prop)
        # Plot top 10 names by sex and year
        ggplot(top_10_names, aes(x = name, y = prop)) +
            geom_col(fill = "#263e63")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
