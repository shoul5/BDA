# Shiny app for Bad Dog Agility Power 60
# Data created in 1_Data.R

library(tidyverse)
library(shiny)
library(plotly)

load('AgilityData.RData')

dataDF$Height <- as.factor(dataDF$Height)
dataDF$Placing <- as.factor(as.numeric(dataDF$Placing))
colnames(dataDF)[6]<-"YPS.JWW"
colnames(dataDF)[8]<-"YPS.STD"
dataDF$YPS.JWW <- as.numeric(dataDF$YPS.JWW)


# Define UI for application
ui <- pageWithSidebar(
   
   # Application title
   headerPanel("Power 60 Data - 2018"),
   
   # Sidebar with input for dog's jump height, quarter and class type 
      sidebarPanel(
         selectInput(inputId = "Heights",
                     label = "Dog Jump Height:",
                     choices=c("16","20","24"),
                     selected = c("20")),
         radioButtons(inputId = "Quarter",
                      label = "Choose Quarter",
                      choices = c("Q1","Q2"),
                      selected = c("Q2")),
         radioButtons(inputId = "Type",
                            label = "Jumpers With Weaves or Standard",
                            choices = c("YPS.JWW","YPS.STD"),
                            selected = "YPS.JWW")
      ),
      
      # Show a plotly (interactive plot)
      mainPanel(
         plotlyOutput("plot")
      )
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$plot <- renderPlotly({
      # filter data based on inputs for height and quarter from ui.R
      x    <- dataDF %>% 
          filter(Height == input$Heights & Quarter == input$Quarter) 
      # Create plotly selecting for class type as y variable
      print(ggplotly(ggplot(x, aes_string("Placing", input$Type)) 
                     + geom_point(col="blue") + theme_classic()))
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

