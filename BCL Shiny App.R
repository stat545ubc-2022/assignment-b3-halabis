#Load relevant libraries

library(tidyverse)
library(shiny)

#Load bcl data

bcl <- read_csv("~/Desktop/bcl-data.csv")

#Shiny app

ui <- fluidPage(
  titlePanel("BC Liquor Store Data"),
  h5("Welcome to my shiny app!"),
  br(),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, value = c(25,40), pre = "$"),
      radioButtons("typeInput", "Type",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"))
    )
    ,
    mainPanel(
      plotOutput("alcohol_hist"),
      tableOutput("data_table")
    )
  ),
  a(href="https://github.com/daattali/shiny-server/blob/master/bcl/data/bcl-data.csv")
)

server <- function(input, output) {
  filtered_data <-
    reactive({bcl %>%filter(Price > input$priceInput[1] &
                              Price < input$priceInput[2] &
                              Type == input$typeInput)
    })

  output$alcohol_hist <- renderPlot({ #this curly bracket is not super necessary but if you want to specify that this is your plotting code you can add
    filtered_data() %>%
      ggplot(aes(Alcohol_Content)) + geom_histogram()
  })

  output$data_table <-
    renderTable({
      filtered_data()
    })

}

shinyApp(ui = ui, server = server)
