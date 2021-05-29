library(shiny)
library(dplyr)
library(ggplot2)


getMean <- function(tdata){
  vc = c()
  score_mean = c()
  
  for(i in 1:nrow(tdata)){
    vc = tdata[i,]
    vc = vc[!vc==0]
    
    score_mean = c(score_mean, round( ifelse(length(vc)==0, 0, sum(vc)/length(vc)) , 1) )
  }
  
  return(score_mean)
}


data <- read.csv("data.csv")

tdata = data%>%
  select(!c(grade,name))
score_mean = getMean(tdata)

data = data %>%
  select(c(grade,name)) %>%
  mutate(mean = score_mean)


ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("sgrade", "Which Grade Teacher You Want To Select", choices=c("1", "2", "3", "4", "5", "6"))
      
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("The Summary plot ", plotOutput("summary")),
        tabPanel("The Average Grades ", tableOutput("gdscore")),
        tabPanel("The Analyse plot", plotOutput("gdplot"))
      )
    )
  )
)

server <- function(input, output, session) {
  output$summary <- renderPlot({
    tdata = data %>%
      group_by(grade) %>%
      summarise(mean(mean))
    colnames(tdata) = c("grade", "mean")
    
    
    ggplot(tdata, aes(x=grade,y=mean) )+ 
      geom_bar(stat="identity")

  })
  
  output$gdscore <- renderTable({
    tgrade = input$sgrade
    tdata = data[data$grade==tgrade,]
  })
  
  output$gdplot <- renderPlot({
    tgrade = input$sgrade
    tdata = data%>%
      filter(grade == tgrade) %>%
      select(c(name, mean))
    ggplot(tdata, aes(x=name, y=mean)) + geom_bar(stat="identity")
  })
}

shinyApp(ui, server)
