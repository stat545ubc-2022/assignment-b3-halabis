# BC Liquor App

Hello! Welcome to my BC Liquor App repository. The function of this app is to allow users to interactively explore the BC Liquor data set which includes properties of products that are sold at BC Liquor Stores including prices, country of origin, product type, etc.

In this repository you will find 2 assignments in which the BC Liquor app was developed and improved. Repository contents include:

* The dataset being used **bcl-data.csv** in the main branch.

* This README file.

* A **www** folder containing the image I have included in my app (*see section Assignment B4*).

* A **B3** folder which contains all previous and initial work done on the app from **Assignment B3** in the R script **BCL Shiny App.R** including adding 3+ features to the original app.

* A **B4** folder which contains all the new improvements and feature additions to the app from **Assignment B4** in the R script **BCL Shiny App (B4).R**. 

Please follow along below for the details of the repository as well as lists of all features included in the application. 

**Please note:** The features are additive, so all features from **assignment B3** are still included in **assignment B4** (with minor adjustments) but they will not be listed AGAIN in the **Assignment B4** subsection. You can find the features from **assignment B3** listed in the **Assignment B3** subsection.

## Data Source
The dataset has been uploaded in this repository **bcl-data.csv**. The data was obtained from the shiny-server repository at the following link: https://github.com/daattali/shiny-server/blob/master/bcl/data/bcl-data.csv

Another option for checking out the data is through the government BC site where they have the version of the data set that has not been pre-processed yet: https://catalogue.data.gov.bc.ca/dataset/bc-liquor-store-product-price-list-historical-prices 

## Assignment B3

For **assignment B3**, I added three (or more) features to an already-existing BC Liquor shiny app. The application allows users to assess, visualize, and interact with data from the BC liquor dataset which includes features such as product type, country, price, alcohol content, and more. I have outlined what features I added initially in **assignment B3** in the next subsection. This app was further improved in **assignment B4** (see **assignment B4** section).

This repository includes a folder labelled **B3** which contains the script **BCL Shiny App.R** in which the app development code is from **assignment B3**. This is separate from the **assignment B4** script which I will discuss later in the README.

### Assignment B3 App Link

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

## Assignment B4 

For **assignment B4**, I have included numerous additional features (in addition to the previous ones from **assignment B3**) while also improving on a few of the previous features and overall aesthetics of the application. The script for **assignment B4** (*BCL Shiny App (B4).R*) can be found under folder **B4** as mentioned. You can find the link to the app in the next subsection. Please read the features subsection to learn about the features added in **assignment B4**.

**AGAIN PLEASE NOTE:** *I will not be retyping the features from assignment b3. Just know that all features listed for assignment B4 are IN ADDITION to B3 features.*

### Assignment B4 App Link

You can access the Shiny App through the following link: https://halabis.shinyapps.io/assignment-b4-halabis/

### Features Added in Assignment B4 (in addition to the assignment B3 features)

**Feature 1:** I have changed the theme which was originally "flatly" in assignment B3 but now is "united" because I felt it was more aesthetically pleasing.

**Feature 2:** I have added an image to my application header using the tag img as well as the figure tag which allowed me to align my image in the center of my header. This improves "friendliness" of the app for users and visual appeal.

**Feature 3:** I have added borders near the top and the bottom of the app to better section the texts in the app. This will allow for easier reading by the users. 

**Feature 4:** I added a title to the side panel to improve user understanding of what the side panel is meant to be used for. 

**Feature 5:** I added a uiOutput function in the UI of the application, and a corresponding countryOutput in the server to render that UI to allow users to select the counrty of their choice to visualize. This allow users to further visualize the data and associations.

**Feature 6:** I added a text output option in the UI and the server which results in a text that highlights how many results there were based on the users filter selections. The statement I chose included "There are ___ number of results based on your selections". 

**Feature 7:** I added a link to the original data labelled "Click this link to see the original data set!" at the bottom of the app page. This way, if individuals do not understand how to access the data through the README (or didn't read the README at all!) will be able to access the data repository easily. 

**Feature 8:** I added a selectInput to the countryOuput in my server corresponding to **Feature 5** uiOutput. This will create a drop down selection option for participants to select country of choice to explore.

**Feature 9:** I have greatly improve my histogram by adding numerous parameters and features to it such as a clearer theme, appropriate axis and graph titles, improving text sizes, improving legend aesthetics, and more visual factors.

**Feature 10:** I have added a text output in the server that corresponds with **Feature 6**. I inputted a message so that the number of results will be outputted in a sentence format.

**More General Changes:**

* In assignment B3 I had included an option to sort the data table by price using a checkboxInput function in the UI. However, given that my datatable is interactive, you can already sort the table by increasing or decreasing price. Thus, this check box was redundant and I removed it. 

* I improved spacing in my app using br tag and I improve my description of the app.


I hope you enjoy using my app!



