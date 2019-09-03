library(ggplot2)
library(shiny)

dataset = read.csv('ShinyData.csv')
ui <- fluidPage(
  
  h2("Shiny App"),
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      hr(),
      
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins",
                  label = "Select the year",
                  min = min(dataset$Year),
                  max = max(dataset$Year),
                  value = length(dataset$Year),
                  step =1),
      hr(),
      
      h5("Please Select a Year using slider")
        ),
    
    
  
  mainPanel(
  
  tabsetPanel(type = "tabs",
              tabPanel("BarPlot", plotOutput("plot")),
             tabPanel("Stacked Barplot", plotOutput("plot2")),
              tabPanel("Filter Barplot", plotOutput("plot3"))
  )
)
)
)

server <- function(input, output) {
  output$plot <- renderPlot({
    ggplot(data=dataset, aes(x=Year, y=Dtl_val)) +
         geom_bar(stat="identity", fill="steelblue")
  })
  
  output$plot2 <- renderPlot({
    ggplot(data=dataset, aes(x=Year, y=Dtl_val, fill=Dtl_nm)) +
      geom_bar(stat="identity")
  })
  
  
  output$plot3 <- renderPlot({
    X = dataset[dataset$Year == input$bins,]
    ggplot(data=X, aes(x=Dtl_nm, y=Dtl_val)) +
      geom_bar(stat="identity", fill="steelblue")
  })
}

shinyApp(ui, server)

