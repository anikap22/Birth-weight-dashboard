#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# to run: runApp("C:/Users/Anika/Documents/GradSchool/Misc/LearnShiny/BirthWeightPredictor")

library(shiny)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
    # Birth weight (g) = gestational age (days) x (9.38 + 0.264 x fetal sex + 0.000233 x maternal height [cm] x maternal weight at 26.0 weeks [kg] + 4.62 x 3rd-trimester maternal weight gain rate [kg/d]] x [number of previous births + 1]).
    #x = ga*(9.38 + 0.264*fetal_sex + 0.000233*mat_height*mat_weight_26wk + 4.62*trim3_weightgain_rate + (num_prev_births + 1))
    
    # Return the requested dataset
    fetal_sex <- reactive({
        switch(input$fetal_sex,
               "male" = 1,
               "female" = -1,
               "unknown" = 0)
    })
    
    # Generate birth weight
    output$birthweight <- renderPrint({
        birthweight <- input$ga*(9.38 + 0.264*fetal_sex() + 0.000233*input$mat_height*input$mat_weight_26wk + 4.62*input$trim3_weightgain_rate + (input$num_prev_births + 1))
        print(paste0("predicted birth weight: ", birthweight, " grams"))
    })
    
    # plot point on histogram of average birth weights
    # stats from: https://www.healthknowledge.org.uk/public-health-textbook/research-methods/1b-statistical-methods/statistical-distributions
    # average = 3390 grams, SD = 550
    output$distPlot <- renderPlot({
        birthweight <- input$ga*(9.38 + 0.264*fetal_sex() + 0.000233*input$mat_height*input$mat_weight_26wk + 4.62*input$trim3_weightgain_rate + (input$num_prev_births + 1))
        x <- seq(1740,5040,length=500)
        plot(x,dnorm(x,mean=3390, sd=500),type = "l",lty=1,lwd=3,col="blue",main="Distribution of birth weights",ylab="Density", xlab="Weight (g)") #ylim=c(0,0.5),xlim=c(-6,6),
        abline(v = birthweight, col="green")
    })
    
    
})
