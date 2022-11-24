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

ui <- fluidPage(theme = shinytheme("flatly"), #Feature 1: I have added a theme called flatly to make my app more visually appealing using the shinytheme package.
  titlePanel("BC Liquor Store Data"),
  h5("Welcome to my shiny app! In this app, you can explore the BC Liquor data either through the dataset in the 'Data' tab or through visualization in the 'Histogram' Tab. The data can be ordered by price using the check box in the side panel. The histogram is interactive and can be filtered by product type, price range, and can show different bin numbers using the slider."), #I have added a more descriptive caption for my app
  br(),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, value = c(25,40), pre = "$"),
      sliderInput(inputId = "NOofBins", #Feature 2: Added a sliderInput option to choose the number of bins shown in the histogram. This is useful for improved visualization, it will improve ability to look at outliers, and more bins will help with any future analysis
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      checkboxGroupInput("typeInput", "Product Type", #Feature 3: I have changed the product type choice in the side panel so that you can select more than one product type at a time to show in the histogram or the data table by replacing radioButtons function with checkboxGroupInput. This is useful to compare different product types in terms of prices and distribution.
                         choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                         selected = "WINE"),
      checkboxInput("sortInput", label ="Sort data by price") #Feature 4: Providing an option to sort data table by price. This is important if users want to view data in different ways such as from cheapest to most expensive.
    )
    ,
    mainPanel(
      tabsetPanel( #Feature 5: Added tabs of Histogram and Data to the app to improve organization using tabsetPanel.
      tabPanel("Histogram", plotOutput("alcohol_hist")),
      tabPanel("Data", DT::dataTableOutput("data_table"), downloadButton("download_table", "Download Table"))), #Feature 6: Added download button that allows you to download the datatable as a csv file. This is important if users want to use the datatable for data analysis or have it saved for future use.
      #Feature 7: Turned datatable from a static to interactive table using the DT package. This allows users to have useful functions such as search bar, showing however number of rows they like, etc.

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
     if(input$sortInput){ #Feature 4: Adding a filter that will allow user to choose (using UI checkboxGroupInput above) whether to adjust datatable by price.
       new %>%
         arrange(Price)
     } else{
       new
     }
    })

  output$alcohol_hist <- renderPlot({
    filtered_data() %>%
      ggplot(aes(Alcohol_Content, fill=Type)) + geom_histogram(bins = input$NOofBins) #Feature 2: Added bins to the geom_histogram and enabled a fill color by product type aesthetic in the ggplot to distinguish between product types when more than one is chosen.
  })

  output$data_table <-
    DT::renderDataTable({ #Feature 7: Turned datatable from a static to interactive table.
     filtered_data()

    })

  output$download_table <- downloadHandler( #Feature 6: Added downloadHandler to accompany downloadButton in ui that will allow for the datatable to be downloaded as a csv file.
    filename = function(){
      paste('data_table', '.csv', sep="-")
    },
    content = function(file){
      write.csv(filtered_data(), file)
    }
  )
}

shinyApp(ui = ui, server = server)
