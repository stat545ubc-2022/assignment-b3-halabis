# BC Liquor App

Hello! Welcome to my BC Liquor App repository. In this repository you will find 2 assignments in which the BC Liquor app was developed and improved. Repository contents include:

* The dataset being used **bcl-data.csv** in the main branch.

* This README file.

* A **www** folder containing the image I have included in my app (*see section Assignment B4*).

* A **B3** folder which contains all previous and initial work done on the app from **Assignment B3** including adding 3+ features to the original app.

* A **B4** folder which contains all the new improvements and feature additions to the app from **Assignment B4** in the R script **BCL Shiny App (B4).R**. 

Please follow along below for the details of the repository.

## Data Source
The dataset has been uploaded in this repository **bcl-data.csv**. The data was obtained from the shiny-server repository at the following link: https://github.com/daattali/shiny-server/blob/master/bcl/data/bcl-data.csv

##Assignment B3

For **assignment B3**, I added three (or more) features to an already-existing BC Liquor shiny app. The application allows users to assess, visualize, and interact with data from the BC liquor dataset which includes features such as product type, country, price, alcohol content, and more. I have outlined what features I added initially in **assignment B3** in the next subsection. This app will be further developed in future assignments (**assignment B4**).

This repository includes a folder labelled **B3** which contains the script **BCL Shiny App.R** in which the app development code is from **assignment B3**. This is separate from the **assignment B4** script which I will discuss later in the README.

### Assignment B3 Application Link

You can access the Shiny App through the following link: https://halabis.shinyapps.io/assignment-b3-halabis/ 

### Features Added in Assignment B3

My application additions and modifications have made the app more user-friendly, visually appealing, and less rigid. The following features have been added:

**Feature 1:** Using the *shinytheme* package, I have added a **theme called flatly** to make my app more visually appealing.

**Feature 2:** I added a *sliderInput* option to choose the **number of bins** shown in the histogram. This is useful for improved visualization of the data, improved ability to look at outliers, and more ability to conduct any future analysis.

**Feature 3:** I have changed the product type choice in the side panel so that you can **select more than one product type at a time** to show in the histogram or the data table by replacing *radioButtons* function with *checkboxGroupInput*. This is useful to compare different product types in terms of prices and distribution.

**Feature 4:** I have provided an option to **sort the data table by price** by adding a *checkboxInput* function to the UI and adding filtration in the server reactive function. This is important if users want to view data in different ways such as from cheapest to most expensive.

**Feature 5:** I have **added tabs** to organize the Histogram and Data separately in the app to improve organization and ease of orientation using *tabsetPanel*.

**Feature 6:** I have added a **download button** that allows you to download the datatable as a csv file using the *downloadButton* in the UI and the *downloadHandler* in the server. This is important if users want to use the datatable for data analysis or have it saved for future use.

**Feature 7:** I have turned datatable from a static to **interactive table** using the *DT* package. This allows users to have useful functions such as search bar, showing however number of rows they like, etc.

##Assignment B4 

For **assignment B4**, I have included several more features (in addition to the previous ones from **assignment B3**) while also improving on a few of the previous features and overall aesthetics of the application. The script for **assignment B4** can be found under folder 

