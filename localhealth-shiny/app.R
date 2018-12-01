library(shiny)
library(ggplot2)

# This part to be replaced by the cleaned up data!
sample_data = read.csv(text="Area Code,Area Name,Indicator 1,Indicator 2,delta_Lab
E05000026,Abbey,10,123,5
E05000027,Alibon,15,98,-7
E05000028,Becontree,12,101,10")


indicator_columns = names(sample_data)[3:4]
plot_name_list <- paste("indicator_plot_", 1:length(indicator_columns), sep="")


ui <- fluidPage(
  titlePanel("Healthcare"),
  
  sidebarLayout(
    sidebarPanel(
    ),
    mainPanel(
      #uiOutput("indicator_plots") # TODO: Didn't get this part working.
      
      plotOutput("indicator_plot_1"),
      plotOutput("indicator_plot_2")
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
        
        ggplot(sample_data, aes(x=sample_data[[indicator_columns[[my_i]]]], y=delta_Lab)) +
          geom_point() +
          geom_smooth(method='lm') +
          labs(x=indicator_columns[[my_i]], title=indicator_columns[[my_i]])
        
      })
    })
  }
  
}



shinyApp(ui = ui, server = server)


