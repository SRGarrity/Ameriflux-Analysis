library(shiny)

ui <- fluidPage(
  
  # App title ----
  titlePanel("Ecosystem CO2 Flux Decomposition"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      #Copy the line below to make a select box 
      selectInput("select", label = h3("Choose Averaging Period"), 
                  choices = list("Daily", "Weekly", "Monthly"), 
                  selected = 1),
      hr(),
      fluidRow(column(3, verbatimTextOutput("value")))
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "distPlot")
      
    )
  )
)