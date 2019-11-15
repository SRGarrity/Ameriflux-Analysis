server <- function(input, output) {
  library(tidyverse)
  library(imputeTS)
  
  output$distPlot <- renderPlot({
    
    if(input$select == "Daily")
    {
      umbs14daily <- read_csv('umbs_daily.csv')
      dNEEdaily <- ts(umbs14daily$NEE_PI, start=c(2009,1), frequency=365)
      dNEEdaily <- na.seadec(dNEEdaily)
      plot(stl(dNEEdaily, s.window="periodic"),
           labels = c("NEE","Seasonal","Trend","Residual"), main="Daily Average")
    }
    if(input$select == "Weekly")
    {
      umbs14weekly <- read_csv('umbs_weekly.csv')
      dNEEweekly <- ts(umbs14weekly$NEE_PI, start=c(2009,1), frequency=52)
      dNEEweekly <- na.seadec(dNEEweekly)
      plot(stl(dNEEweekly, s.window="periodic"), 
           labels = c("NEE","Seasonal","Trend","Residual"), main="Weekly Average")
    }
    if(input$select == "Monthly")
    {
      umbs14monthly <- read_csv('umbs_monthly.csv')
      dNEEmonthly <- ts(umbs14monthly$NEE_PI, start=c(2009,1), frequency=12)
      dNEEmonthly <- na.seadec(dNEEmonthly)
      plot(stl(dNEEmonthly, s.window="periodic"), 
           labels = c("NEE","Seasonal","Trend","Residual"), main="Monthly Average")
    }
  })
  
}