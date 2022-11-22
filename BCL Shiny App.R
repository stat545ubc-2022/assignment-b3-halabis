#Load relevant libraries

library(tidyverse)
library(shiny)
library(ggplot2)
library(DT)
library(dplyr)
library(colourpicker)
library(shinythemes)

#Load bcl data

bcl <- read_csv("~/Desktop/bcl-data.csv")

#Shiny app

ui <- fluidPage(theme = shinytheme("cosmo"),
  titlePanel("BC Liquor Store Data"),
  h5("Welcome to my shiny app!"),
  br(),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, value = c(25,40), pre = "$"),
      sliderInput(inputId = "NOofBins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      checkboxGroupInput("typeInput", "Product Type",
                         choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                         selected = "WINE"),
     # radioButtons("typeInput", "Type",
                   #choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE")),
      checkboxInput("sortInput", "Sort data by price"), #providing 2 options by which to sort data table
     #colourInput("colorInput", "Plot Color", "Black"),
     textOutput("")
    )
    ,
    mainPanel(img(src = "bcliquor.png", height=150, width = 400),
      tabsetPanel(
      tabPanel("Histogram", plotOutput("alcohol_hist")),
      tabPanel("Data", DT::dataTableOutput("data_table"), downloadButton("download_table", "Download Table"))),
      textOutput("text")

     )
  ),
  a(href="https://github.com/daattali/shiny-server/blob/master/bcl/data/bcl-data.csv")
)

server <- function(input, output) {
  filtered_data <-
    reactive({
     new <- bcl %>%filter(Price >= input$priceInput[1] &
                              Price <= input$priceInput[2] &
                              Type == input$typeInput)
     if(input$sortInput){
       new %>%
         arrange(Price)
     } else{
       new
     }
    })

  output$alcohol_hist <- renderPlot({ #this curly bracket is not super necessary but if you want to specify that this is your plotting code you can add
    filtered_data() %>%
      ggplot(aes(Alcohol_Content, fill=Type)) + geom_histogram(bins = input$NOofBins,)
  })

  output$data_table <-
    DT::renderDataTable({
     filtered_data()

    })

  output$download_table <- downloadHandler(
    filename = function(){
      paste('data_table', '.csv', sep="-")
    },
    content = function(file){
      write.csv(filtered_data(), file)
    }
  )

  output$text <- renderText({
    paste("The number of results in this price range and for this product(s) is:", nrow(filtered_data()))
  })
}

shinyApp(ui = ui, server = server)
