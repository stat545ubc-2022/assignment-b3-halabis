#Assignment B3 - Sabine Halabi

Hello! For assignment B3, I have decided to go with **Option A: Add three features to an already-existing BC Liquor shiny app**. The application allows users to assess, visualize, and interact with data from the BC liquor dataset which includes features such as product type, country, price, alcohol content, and more. 

This repository includes the script **BCL Shiny App.R** in which the app development code is, the data itself **bcl-data.csv**, and all other necessary technological files. 

##Data Source
The dataset has been uploaded in this repository **bcl-data.csv**. The data was obtained from the shiny-server repository at the following link: https://github.com/daattali/shiny-server/blob/master/bcl/data/bcl-data.csv 

##Application Link

You can access the Shiny App through the following link: https://halabis.shinyapps.io/assignment-b3-halabis/ 

##Features

My application additions and modifications have made the app more user-friendly, visually appealing, and less rigid. The following features have been added:

**Feature 1:** Using the *shinytheme* package, I have added a **theme called flatly** to make my app more visually appealing.

**Feature 2:** I added a *sliderInput* option to choose the **number of bins** shown in the histogram. This is useful for improved visualization of the data, improved ability to look at outliers, and more ability to conduct any future analysis.

**Feature 3:** I have changed the product type choice in the side panel so that you can **select more than one product type at a time** to show in the histogram or the data table by replacing *radioButtons* function with *checkboxGroupInput*. This is useful to compare different product types in terms of prices and distribution.

**Feature 4:** I have provided an option to **sort the data table by price** by adding a *checkboxInput* function to the UI and adding filtration in the server reactive function. This is important if users want to view data in different ways such as from cheapest to most expensive.

**Feature 5:** I have **added tabs** to organize the Histogram and Data separately in the app to improve organization and ease of orientation using *tabsetPanel*.

**Feature 6:** I have added a **download button** that allows you to download the datatable as a csv file using the *downloadButton* in the UI and the *downloadHandler* in the server. This is important if users want to use the datatable for data analysis or have it saved for future use.

**Feature 7:** I have turned datatable from a static to **interactive table** using the *DT* package. This allows users to have useful functions such as search bar, showing however number of rows they like, etc.


