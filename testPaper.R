library(shiny)
library(dplyr)

data <- read.csv("data.csv")


getEvaluatingNum <- function(data, tname, tgrade){
  evaluating = 0
  if (tgrade %in% data$grade){
    data = data %>%
      filter(grade == tgrade)
    
    if (tname %in% colnames(data)) {
      evaluating = -1
    }
    else if(tname %in% data$name){
      evaluating = sum(data$grade==tgrade)
    }
  }
  
  return(evaluating)
}


ui <- fluidPage(
  titlePanel(h1("Assessment Of Teachers' Ability")),
  sidebarLayout(
    sidebarPanel(
      strong("Welcome to participate in the assessment, 
             every teacher should be careful when selecting the score,
             because it is related to your year-end bonus."),
      br(),
      br(),
      actionButton("nextpg", "Next Page")
    ),
    mainPanel(
          textInput("name", "Enter your name:", "A2"),
          textInput("grade", "Enter your grade", "1"),
          br(),
          uiOutput("ui"),
          br(),
          br(),
          br(),
          br(),
          uiOutput("ui2")
          
    )
  )

)

server <- function(input, output, session) {

  re_nextpg <- eventReactive(input$nextpg, {
    evaluating = getEvaluatingNum(data, input$name, input$grade)
    
    if (evaluating == 0){
      strong(paste("you don't enter the correct grade or name!"))
    }
    else if(evaluating == -1){
      strong(paste("you have finished the assessment, please don't write again!"))
    }
    else {
      tdata = data %>%
        filter(data$grade==input$grade)
      list(
        lapply(1:evaluating, function(i){
          sliderInput(paste0("score", i), paste("give your assessment to", tdata$name[i]), min=1, max=10, value=5)
        }),
        actionButton("submit", "Submit your assessment")
      )
    }
  })

  re_submit <- eventReactive(input$submit, {
    evaluating = getEvaluatingNum(data, input$name, input$grade)
    
    if (evaluating == 0){
      strong(paste("there is something wrong, please close the window and open again!"))
    }
    else {
      score = rep(0,nrow(data))
      data = cbind(data, score)
      tscore = unlist( lapply(1:evaluating, function(i){ input[[paste0("score", i)]] }) )
      
      data[data$grade==input$grade,]$score = tscore

      colnames(data)[ncol(data)] = input$name
      
      # you can get the detail result about "data"
      print(paste0("evaluating=",evaluating))
      print(tscore)
      print(data)
      
      write.csv(data,"data.csv", row.names = FALSE)
    }
  })
  
  output$ui <- renderUI({
    re_nextpg()
  })
  
  output$ui2 <- renderUI({
    re_submit()
    list(
      strong(paste("Thank you for your attending!")),
      h2(paste("Now, you can close the window!"))
    )
    
    
  })
}

shinyApp(ui, server)

# readRDS("C:/Users/Administrator/Desktop/123/data.rds")