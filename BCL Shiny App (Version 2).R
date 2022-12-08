#Load relevant libraries

library(tidyverse)
library(shiny)
library(ggplot2)
library(DT)
library(dplyr)
library(shinythemes)

#Load bcl data

bcl <- read_csv("bcl-data.csv")

#Shiny app

ui <- fluidPage(theme = shinytheme("united"), #Feature 1: I have added a theme called united to make my app more visually appealing using the shinytheme package.
                tags$figure(align = "center",
                            img(src = "bclimage.png", height=300, width = 700)),
                br(),
                titlePanel("BC Liquor Store Product Properties"),
                h3("Welcome to my shiny app! This app is the perfect way for you to assess different properties of liquor products from around the world that is sold at BC Liquor stores such as alcohol content, price, and more! This data set can be retrieved at the link in the bottom of the page. You can explore the BC Liquor dataset either through the dataset in the 'Data' tab or through visualization of distribution in the 'Histogram' Tab. You can toggle the data in the table and the histogram by using the options in the 'Filter' side panel such as showing you certain number of bins in the histogram, specific countries of origin, price ranges, and more! The histogram will color your data based on the type of product you have chosen as well for better visualization. Enjoy!"), #I have added a more descriptive caption for my app
                hr(style="border-color: red;"),
                br(),
                sidebarLayout(
                  sidebarPanel(
                    h3("Filters"),
                    br(),
                    sliderInput("priceInput", "Price", 0, 100, value = c(25,40), pre = "$"),
                    sliderInput(inputId = "NOofBins", #Feature 2: Added a sliderInput option to choose the number of bins shown in the histogram. This is useful for improved visualization, it will improve ability to look at outliers, and more bins will help with any future analysis
                                label = "Number of bins",
                                min = 1,
                                max = 50,
                                value = 30),
                    checkboxGroupInput("typeInput", "Product Type", #Feature 3: I have changed the product type choice in the side panel so that you can select more than one product type at a time to show in the histogram or the data table by replacing radioButtons function with checkboxGroupInput. This is useful to compare different product types in terms of prices and distribution.
                                       choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                                       selected = "WINE"),
                    uiOutput("countryOutput"),
                    textOutput("selected_results")
                    )
                  ,
                  mainPanel(
                    tabsetPanel( #Feature 5: Added tabs of Histogram and Data to the app to improve organization using tabsetPanel.
                      tabPanel("Histogram", plotOutput("alcohol_hist")),
                      tabPanel("Data", DT::dataTableOutput("data_table"), downloadButton("download_table", "Download Table"))), #Feature 6: Added download button that allows you to download the datatable as a csv file. This is important if users want to use the datatable for data analysis or have it saved for future use.
                    #Feature 7: Turned datatable from a static to interactive table using the DT package. This allows users to have useful functions such as search bar, showing however number of rows they like, etc.

                  )
                ),
                hr(style="border-color: red;"),
                a(href="https://github.com/daattali/shiny-server/blob/master/bcl/data/bcl-data.csv",
                  "Click this link to see the original data set!"),
                hr(style="border-color: red;")
)

server <- function(input, output) {

  output$countryOutput <- renderUI({
    selectInput("countryInput", "Country",
                sort(unique(bcl$Country)),
                selected = "CANADA")
  })

  filtered_data <-
    reactive({
      if (is.null(input$countryInput)) {
        return()
      }
      if (is.null(input$typeInput)) {
        return()
      }
      bcl %>%filter(Price >= input$priceInput[1],
                    Price <= input$priceInput[2],
                    Type == input$typeInput,
                    Country == input$countryInput)
    })

  output$alcohol_hist <- renderPlot({

    if (is.null(filtered_data())) {
      return()
    }

    filtered_data() %>%
      ggplot(aes(Alcohol_Content, fill=Type)) +
      geom_histogram(bins = input$NOofBins) +
      labs(title = "BCL Liquor Histogram", x = "Alcohol Content (%)", y = "Count") + #added labs
      theme_light() +
      theme(panel.border = element_rect(colour = "black", fill=NA),
            plot.title = element_text(size = 25, face = "bold"),
            legend.box.background = element_rect(colour = "black"),
            legend.title = element_text("Product Type"),
            axis.title = element_text(size = 17, face = "bold"),
            axis.text = element_text(size = 15)) #added box and panel borders
      #Feature 2: Added bins to the geom_histogram and enabled a fill color by product type aesthetic in the ggplot to distinguish between product types when more than one is chosen.
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

  output$selected_results<- renderText({
    paste("There are", nrow(filtered_data()),"number of results based on your selections." )
  })
}

shinyApp(ui = ui, server = server)
