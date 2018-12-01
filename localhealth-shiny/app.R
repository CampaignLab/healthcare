library(shiny)
library(ggplot2)

health_vote_data <- read.csv("../localhealth/health_data_merged_with_election_results.csv")


indicator_columns = names(health_vote_data)[4:74]
plot_name_list <- paste("indicator_plot_", 1:length(indicator_columns), sep="")


vote_info_columns <- names(health_vote_data)[77:97]



ui <- fluidPage(
  titlePanel("Healthcare"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId="vote_info_col_chosen",
                  label="Vote information to plot",
                  choices=vote_info_columns,
                  selected="delta_Lab")
    ),
    mainPanel(
      #uiOutput("indicator_plots") # TODO: Didn't get this part working.
      
      plotOutput("indicator_plot_1"),
      plotOutput("indicator_plot_2"),
      plotOutput("indicator_plot_3"),
      plotOutput("indicator_plot_4"),
      plotOutput("indicator_plot_5"),
      plotOutput("indicator_plot_6"),
      plotOutput("indicator_plot_7"),
      plotOutput("indicator_plot_8"),
      plotOutput("indicator_plot_9"),
      plotOutput("indicator_plot_10"),
      plotOutput("indicator_plot_11"),
      plotOutput("indicator_plot_12"),
      plotOutput("indicator_plot_13"),
      plotOutput("indicator_plot_14"),
      plotOutput("indicator_plot_15"),
      plotOutput("indicator_plot_16"),
      plotOutput("indicator_plot_17"),
      plotOutput("indicator_plot_18"),
      plotOutput("indicator_plot_19"),
      plotOutput("indicator_plot_20"),
      plotOutput("indicator_plot_21"),
      plotOutput("indicator_plot_22"),
      plotOutput("indicator_plot_23"),
      plotOutput("indicator_plot_24"),
      plotOutput("indicator_plot_25"),
      plotOutput("indicator_plot_26"),
      plotOutput("indicator_plot_27"),
      plotOutput("indicator_plot_28"),
      plotOutput("indicator_plot_29"),
      plotOutput("indicator_plot_30"),
      plotOutput("indicator_plot_31"),
      plotOutput("indicator_plot_32"),
      plotOutput("indicator_plot_33"),
      plotOutput("indicator_plot_34"),
      plotOutput("indicator_plot_35"),
      plotOutput("indicator_plot_36"),
      plotOutput("indicator_plot_37"),
      plotOutput("indicator_plot_38"),
      plotOutput("indicator_plot_39"),
      plotOutput("indicator_plot_40"),
      plotOutput("indicator_plot_41"),
      plotOutput("indicator_plot_42"),
      plotOutput("indicator_plot_43"),
      plotOutput("indicator_plot_44"),
      plotOutput("indicator_plot_45"),
      plotOutput("indicator_plot_46"),
      plotOutput("indicator_plot_47"),
      plotOutput("indicator_plot_48"),
      plotOutput("indicator_plot_49"),
      plotOutput("indicator_plot_50"),
      plotOutput("indicator_plot_51"),
      plotOutput("indicator_plot_52"),
      plotOutput("indicator_plot_53"),
      plotOutput("indicator_plot_54"),
      plotOutput("indicator_plot_55"),
      plotOutput("indicator_plot_56"),
      plotOutput("indicator_plot_57"),
      plotOutput("indicator_plot_58"),
      plotOutput("indicator_plot_59"),
      plotOutput("indicator_plot_60"),
      plotOutput("indicator_plot_61"),
      plotOutput("indicator_plot_62"),
      plotOutput("indicator_plot_63"),
      plotOutput("indicator_plot_64"),
      plotOutput("indicator_plot_65"),
      plotOutput("indicator_plot_66"),
      plotOutput("indicator_plot_67"),
      plotOutput("indicator_plot_68"),
      plotOutput("indicator_plot_69"),
      plotOutput("indicator_plot_70"),
      plotOutput("indicator_plot_71")
    )
  )
)


server <- function(input, output) {
  
  # Dynamically create the plots, one per indicator.
  # https://stackoverflow.com/questions/31686773/shiny-dynamic-number-of-output-elements-plots
  # https://gist.github.com/wch/5436415/
  # TODO: Couldn't get this part working.
  #output$indicator_plots <- renderUI({
  #  for (x in plot_name_list) {
  #    print(x)
  #    plotOutput(x)
  #  }
  #  tagList(plot_name_list)
  #})
  
  for (i in 1:length(indicator_columns)) {
    local({
      my_i <- i
      plot_name <- plot_name_list[[my_i]]
      #print(plot_name)
      
      output[[plot_name]] <- renderPlot({
        
        ggplot(health_vote_data, aes(x=health_vote_data[[indicator_columns[[my_i]]]], y=health_vote_data[[input$vote_info_col_chosen]])) +
          geom_point() +
          geom_smooth(method='lm') +
          labs(x=indicator_columns[[my_i]], y=input$vote_info_col_chosen, title=indicator_columns[[my_i]])
        
      })
    })
  }
  
}



shinyApp(ui = ui, server = server)


