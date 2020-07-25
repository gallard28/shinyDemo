#Top Baby Names by Year
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
    titlePanel("What's in a Name?"),

    selectInput('sex', 'Select Sex', choices = c("F", "M")),

    sliderInput("year", "Select year", min=1900,max=2010, 1900),
    #Plot
    plotOutput('plot_top_10_names'),
    #static Table
    tableOutput('table_top_10_names'),
    #Interactive Table
    DT::DTOutput('table_top_10_names_interactive')
)

server <- function(input, output, session) {
    output$plot_top_10_names <- renderPlot({
        top_10_names <- babynames %>% 
            filter(sex == input$sex) %>% 
            filter(year == input$year) %>% 
            top_n(10, prop)
        ggplot(top_10_names, aes(x = name, y = prop)) +
            geom_col(fill = "#263e63") 
        })
  
        #Table
    top_10_names <- function(){
        top_10_names <- babynames %>% 
            filter(sex == input$sex) %>% 
            filter(year == input$year) %>% 
            top_n(10, prop)
    }
        output$table_top_10_names <- renderTable({
            top_10_names()
        })
        #Interactive Table
        output$table_top_10_names_interactive <- DT::renderDT({
            top_10_names()
        })
    }
        
            
# Run the application 
shinyApp(ui = ui, server = server)
