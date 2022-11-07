# Xuyang Liu - DS 1 - Data Challenge 4
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
# Define UI for application that draws the second plot
shinyUI(
  # Use a fluid Bootstrap layout
  fluidPage(
    # Give the page a title
    titlePanel("Streptomycin for TB Dataset Analysis"),
    
    # Description of the dataset
    h4(strong(
      "1. Description of Streptomycin Data for TB Dataset"
    )),
    p(
      strong("Background:"),
      "This data set is reconstructed from a study published on October 30, 1948 in the British Medical Journal, reported by the Tuberculosis Trials Committee of the MRC. 
      The Streptomycin for Tuberculosis trial in 1948 is considered the first modern randomized, placebo-controlled clinical trial, 
      which could be done in part because there were very limited supplies of streptomycin in the UK after World War II. 
      The randomized trial was helpful to prevent rationing and black market selling of streptomycin, 
      and helped with allocation of limited hospital isolation beds for bedrest therapy (the control arm, and standard of care at the time)."
    ),
    p(
      strong("Abstract:"),
      "This data set contains reconstructed records of 107 participants with pulmonary tuberculosis. 
      In 1948, collapse therapy (collapsing the lung by puncturing it with a needle) and bedrest in sanitariums were the standard of care.
      This is the first modern report of a randomized clinical trial. 
      While patients on streptomycin often improved rapidly, streptomycin resistance developed, and many participants relapsed. 
      There was still a significant difference in the death rate between the two arms. 
      A similar effect was seen with PAS, another new therapy for tuberculosis, and the authors rapidly figured out that combination therapy was needed, 
      which was tested in two subsequent trials, which were published in 1952. "
    ),
    p(
      strong("Study Design:"),
      "Prospective, Randomized, Multicenter Placebo-Controlled Clinical Trial"
    ),
    
    p(
      strong("Subjects:"),
      "107 participants with pulmonary tuberculosis were assigned to 1 of 2 treatments:"),
      p("- Streptomycin 2 g by mouth daily"),
      p("- Control therapy - bed rest"),
    # variables
    p(strong("Variables:"),),
    p(code("patient_id"), ":Participant ID"),
    p(code("arm"), ":Study Arm"),
    p(code("dose_strep_g"), ":Dose of Streptomycin in Grams"),
    p(code("dose_PAS_g"), ":Dose of Para-Amino-Salicylate in Grams"),
    p(code("gender"), ":Gender (M = Male, F = Female)"),
    p(code("baseline_condition"), ":Condition of the Patient at Baseline (1_Good, 2_Fair, 3_Poor)"),
    p(code("baseline_temp"), ":Oral Temperature at Baseline (1_98-98.9F, 2_99-99.9F, 3_100-100.9F, 4_100F+)"),
    p(code("baseline_esr"), ":Erythrocyte Sedimentation Rate at baseline (1_1-10, 2_11-20, 3_21-50, 4_51+)"),
    p(code("baseline_cavitation"),":Cavitation of the Lungs on chest X-ray at baseline (Yes/No)"),
    p(code("strep_resistance"), ":Resistance to Streptomycin at 6m (1_sens_0-8, 2_mod_8-99, 3_resist_100+)"),
    p(code("radiologic_6m"),":Radiologic outcome at 6m (1_Death, 2_Considerable Deterioration,3_Moderate_deterioration, 4_No_change, 5_Moderate_improvement,6_Considerable_improvement)"),
    p(code("radnum"), ":Numeric Rating of Chest X-ray at month 6"),
    p(code("improved"),":Dichotomous Outcome of Improved (TRUE/FALSE)"),
    
    
    # Description of how my app works in the Shiny app
    h4(strong("2. 3 plots for this Shiny app")),
    p(
      strong(
        "Plot 1: Dot Plot: The relationship between gender and numeric rating result of Chest X-ray after 6 months with taking the two treatments."
      )
    ),
    p(
      "From the dot plot we can see the relationship between the numeric rating result of Chest X-ray for both female and male groups after 6 months 
      for taking the two treatments: Streptomycin therapy or Placebo therapy."
    ),
    p(
      strong(
        "Plot 2: Bar Plot: the radiologic outcome of Streptomycin and Placebo Therapy after 6 months based on different patient's baseline condition."),
      p("Filter the patient's baseline condition in: Good, Fair, Poor, and see the radiologic outcome after 6 months of taking Streptomycin or Placebo Therapy."
      )),
    p(
      strong(
        "Plot 3: Bar Plot: The relationship between dose of Streptomycin in grams and radiologic outcome after 6 months."
      )
    ),
    p(
      "From the bar plot, we can see that the relationship between taking dose of Streptomycin in 0 g or 2g and the radiologic outcome from 1 (Death) to 6 (considerable improvement)."
    ),
    
  # sidebar:
    sidebarLayout(
      sidebarPanel(
        # for plot 1:
        selectInput(
          inputId = "Strep_or_control",
          label = "Treatments:",
          list(
            "Therapy" = list("Streptomycin therapy: 2g by mouth daily","Control therapy: bed rest")
          )
        ),
        
        helpText(strong(
          "To see if gender affects on the study result with the two treatments: Streptomycin therapy or Placebo therapy."
        )),
        helpText(
          "The dot plot is filtered by the two treatments on the y-axis: Streptomycin and Placebo Therapy.",
          "From the dot plot we can see the numeric rating result of Chest X-ray for both female and male groups after 6 months
          for taking these two therapy."),
        helpText(
            "The x-axis represents the numeric rating of chest x-ray from the range 1-6:",
            "1 = Death, 2 = Considerable Deterioration, 3 = Moderate deterioration,
            4 = No change, 5 = Moderate improvement, 6 = Considerable improvement"
        ),
      
      
      # for plot 2:
      radioButtons(
        inputId = "baseline",
        label = "Patient's Baseline Condition:",
        choices = c("Poor" = "3_Poor", "Fair" = "2_Fair", "Good" = "1_Good")
      ),
      helpText(
        strong("To see the radiologic outcome of Streptomycin and Placebo Therapy after 6 months based on different patient's baseline condition.")),
      helpText(
        "We can filter the patient's baseline condition in: Good, Fair, Poor, and see the radiologic outcome after 6 months of taking Streptomycin or Placebo Therapy.
          Overall, it's obvious that compared with the Placebo Therapy, taking Streptomycin therapy could effectively help their recovery and improvement."
      ),
      
      
      # for plot 3:
      radioButtons(
        inputId = "dose_gram",
        label = "Dose of Streptomycin in Grams:",
        choices = c("2 g" = 2,
                    "0 g" = 0)
      ),
      
      helpText(
        strong(
          "To see if resistance to streptomycin plays an effect on the radiologic outcome."
        )
      ),
      helpText(
        "We can filter the dose of streptomycin in 0 gram and 2 grams. 
        While patients on streptomycin often improved rapidly, streptomycin resistance developed, and many participants relapsed. 
        There was still a significant difference in the death rate between the two arms. 
        And the plot shows how the resistance to Streptomycin changes after taking 2g streptomycin daily."
      ),
      
      ),
      
      
      # output plot:
      mainPanel(
        plotlyOutput("plot1"),
        plotlyOutput("plot2"),
        plotlyOutput("plot3")
      )
    )
  )
)
