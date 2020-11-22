#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Predicting Birth Weight"),
    
    # Sidebar with controls to select a dataset and specify the number
    # of observations to view
    sidebarPanel(
        # Birth weight (g) = gestational age (days) x (9.38 + 0.264 x fetal sex + 0.000233 x maternal height [cm] x maternal weight at 26.0 weeks [kg] + 4.62 x 3rd-trimester maternal weight gain rate [kg/d]] x [number of previous births + 1]).
        #x = ga*(9.38 + 0.264*fetal_sex + 0.000233*mat_height*mat_weight_26wk + 4.62*trim3_weightgain_rate + (num_prev_births + 1))
        selectInput("fetal_sex", "Choose gender:", 
                    choices = c("male", "female", "unknown")),
        numericInput("ga", "Gestational Age (days):", 250),
        numericInput("mat_height", "Mother's height (cm):", 175),
        numericInput("mat_weight_26wk", "Mother's weight at 26 weeks (kg):", 55),
        numericInput("trim3_weightgain_rate", "3rd trimester weight gain rate (kg/day):", 0.1),
        numericInput("num_prev_births", "Number of previous births:", 1)
        
    ),
    
    # Show a summary of the dataset and an HTML table with the requested
    # number of observations
    mainPanel(
        verbatimTextOutput("birthweight"),
        plotOutput("distPlot")
    )
))



# Birth weight (g) = gestational age (days) x (9.38 + 0.264 x fetal sex + 0.000233 x maternal height [cm] x maternal weight at 26.0 weeks [kg] + 4.62 x 3rd-trimester maternal weight gain rate [kg/d]] x [number of previous births + 1]).
# https://www.webmd.com/baby/news/20020926/you-can-predict-your-newborns-weight#1


