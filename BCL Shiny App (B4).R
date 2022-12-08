#Load relevant libraries

library(tidyverse)
library(shiny)
library(ggplot2)
library(DT)
library(dplyr)
library(shinythemes)

#Load bcl data

bcl <- read_csv("bcl-data.csv")

#Shiny app with additional features (compared to assignment B3)
##please note that all feature comments in this script are only corresponding to changes made in part B4 of the assignment. Features from part B3 are commented on in the B3 script.

ui <- fluidPage(theme = shinytheme("united"), #Feature 1: I have changed my previous theme from flatly to the theme united to make my app more visually appealing using the shinytheme package.
                tags$figure(align = "center",
                            img(src = "bclimage.png", height=300, width = 600)),#Feature 2: I have added an image/logo to the app with some additional html properties
                br(),
                titlePanel("BC Liquor Store Product Properties"), #I have changed the title of my app
                h4("Welcome to my shiny app! This app is the perfect way for you to assess different properties of liquor products from around the world that is sold at BC Liquor stores such as alcohol content, price, and more! This data set can be retrieved at the link in the bottom of the page. You can explore the BC Liquor dataset either through the dataset in the 'Data' tab or through visualization of distribution in the 'Histogram' Tab. You can toggle the data in the table and the histogram by using the options in the 'Filter' side panel such as showing you certain number of bins in the histogram, specific countries of origin, price ranges, and more! The histogram will color your data based on the type of product you have chosen as well for better visualization. Enjoy!"), #I have added a more descriptive caption for my app
                hr(style="border-color: red;"), #Feature 3: I added a border to visually differentiate between sections in my app
                br(),
                sidebarLayout(
                  sidebarPanel(
                    h3("Filters"), #Feature 4: I added a title to the side panel to improve user understanding
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
                    #In assignment B3 modifications, I had added a widget to sort the graph and data by price, but it is redundant since my table is already interactive and the data can be sorted by price by clicking on that column.

                    uiOutput("countryOutput"), #Feature 5: I added a uiOutput to add a drop down menu that allows users to choose which country of origin they want to explore
                    textOutput("selected_results") #Feature 6: I added a text output in the side panel under all the filters so that once done filtering, the users can see how many results they have in their data
                    )
                  ,
                  mainPanel(
                    tabsetPanel(
                      tabPanel("Histogram", plotOutput("alcohol_hist")),
                      tabPanel("Data", DT::dataTableOutput("data_table"), downloadButton("download_table", "Download Table"))), #Feature 6: Added download button that allows you to download the datatable as a csv file. This is important if users want to use the datatable for data analysis or have it saved for future use.
                    #Feature 7: Turned datatable from a static to interactive table using the DT package. This allows users to have useful functions such as search bar, showing however number of rows they like, etc.

                  )
                ),
                hr(style="border-color: red;"), #Feature 3: I added a border to visually differentiate between sections in my app
                a(href="https://github.com/daattali/shiny-server/blob/master/bcl/data/bcl-data.csv",
                  "Click this link to see the original data set!"), #Feature 7: I have added a title and link to the original dataset for users to access at the bottom of my app.
                hr(style="border-color: red;") #Feature 3: I added a border to visually differentiate between sections in my app
)

server <- function(input, output) {

  output$countryOutput <- renderUI({
    selectInput("countryInput", "Country",
                sort(unique(bcl$Country)),
                selected = "CANADA") #Feature 8 (corresponds with Feature 6): I have added a countryOutput widget corresponding to the uiOutputto my server and filtered data so that users can select input of their country of choice.
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
                    Country == input$countryInput) #Country output added
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
  }) #Feature 9: I have greatly improve my histogram by added numerous parameters and features to it such as a clearer theme, appropriate axis and graph titles, and more visual factors.

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

  output$selected_results<- renderText({
    paste("There are", nrow(filtered_data()),"number of results based on your selections." )
  }) #Feature 10 (corresponds with Feature 6): I inputted a message so that the number of results will be outputted in a sentence format.
}

shinyApp(ui = ui, server = server)
