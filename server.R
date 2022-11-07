# X
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(rsconnect)
library(readr)
library(medicaldata)
library(tidyr)

shinyServer(function(input, output) {
  
  # first plot - scatter plot
  output$plot1 <- renderPlotly({
    data1 <- strep_tb %>%
      mutate(Gender = ifelse(gender == c("M"), "Male", "Female")) %>%
      mutate(Strep_control = ifelse(arm == c("Streptomycin"), "Streptomycin", "Placebo"))
    
    p1 <- ggplot(data = data1,
                 aes(
                   x = rad_num,
                   y = input$Strep_or_control,
                   col = Gender
                 )) +
      geom_point() +
      geom_jitter() +
      scale_color_manual(values=c('#FF99C9', '#6883BA'))+
      labs(x = "Numeric Rating of Chest X-ray at month 6",
           y = "Therapy",
           title = "Does gender affect the result?") +
      theme(plot.title = element_text(
        hjust = 0.5,
        size = 12
      ))
    ggplotly(p1)
  })
  
  
  # second plot - bar plot
  output$plot2 <- renderPlotly({
    data2 <- strep_tb %>%
      filter(baseline_condition == input$baseline) %>%
      mutate(Strep_control = ifelse(arm == c("Streptomycin"), "Streptomycin", "Placebo"))
    
    p2 <- ggplot(data2,
                 aes(x = radiologic_6m,
                     fill = Strep_control)) +
      geom_bar(width = 0.5) +
      labs(title = "The Radiologic Outcome of Streptomycin and Placebo Therapy after 6 months",
           x = "Radiologic outcome after 6 months",
           y = "Number of Patients") +
      scale_fill_manual(values=c('#9CC4B2', '#C98CA7'))+
      guides(fill = guide_legend(title = "Treatment")) +
      theme(plot.title = element_text(
        hjust = 0.5,
        size = 12
      ))
    ggplotly(p2)
  })
  
  
  # third plot - bar plot
  output$plot3 <- renderPlotly({
    data3 <- strep_tb %>%
      filter(dose_strep_g == input$dose_gram)
    
    p3 <- ggplot(data3,
                 aes(x = radiologic_6m,
                     fill = strep_resistance)) +
      geom_bar(width = 0.5) +
      scale_fill_manual(values=c('#878E88','#96C0B7', '#D4DFC7'))+
      labs(title = "The Relationship between Dose of Streptomycin in Grams and Radiologic outcome after 6 months",
           x = "Radiologic outcome after 6 months",
           y = "Dose of Streptomycin in Grams") +
      guides(fill = guide_legend(title = "Resistance Level")) +
      theme(plot.title = element_text(
        hjust = 0.5,
        size = 12
      ))
    ggplotly(p3)
  })
  
  
})





