#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

load('AgilityData.RData')

dataDF$Height <- as.factor(dataDF$Height)
dataDF$JWWW.YPS <- as.numeric(dataDF$JWWW.YPS)
colnames(dataDF)[6]<-"JWWW.YPS"

# Define UI for application that draws a histogram
ui <- pageWithSidebar(
   
   # Application title
   headerPanel("Power 60 Data - 2018 Q2"),
   
   # Sidebar with a slider input for number of bins 
      sidebarPanel(
         selectInput(inputId = "Heights",
                     label = "Dog Jump Height:",
                     choices=c("16","20","24"),
                     selected = c("20"))
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("plot")
      )
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$plot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- dplyr::filter(dataDF, Height == input$Heights)
      #heights <- levels(dataDF$Height)
      
      # draw the histogram with the specified number of bins
      plot(x[,1],x[,6],col = 'darkgray', border = 'white')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

