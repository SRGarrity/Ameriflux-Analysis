server <- function(input, output) {
  library(tidyverse)
  library(imputeTS)
  umbs14daily <- read_csv('umbs_daily.csv')
  
  dNEEdaily <- ts(umbs14daily$NEE_PI, start=umbs14daily$timestamp[1], frequency=365)
  dNEEdaily <- na.seadec(dNEEdaily)
  
  output$distPlot <- renderPlot({
    
    if(input$select == "365 days")
    {
      plot(stl(dNEEdaily, s.window="periodic", t.window=365),labels = c("NEE","Seasonal","Trend","Residual"))
    }
    if(input$select == "731 days")
    {
      plot(stl(dNEEdaily, s.window="periodic", t.window=731),labels = c("NEE","Seasonal","Trend","Residual"))
    }
  })
  
}