#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

# Load R packages
#install.packages("bslib")
#install.packages("htmltools")
#install.packages("sass")
library(fastmap)
library(shiny)
library(shinythemes)
library(bslib)

#Set Puzzle list
puzzle_words <- c("Word 1", "Word 2", "Word 3", "Word 4", "Word 5", "Word 6", "Word 7", "Word 8", "Word 9")
is_blank <- c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)
puzzle_frame <- data.frame(puzzle_words, is_blank)

# Define UI for application
ui <- page_fillable( # can run this instead to fill entire page 
#ui <- fluidPage(
  
  # Populate 3x3 Grid with Puzzle Words
  layout_columns(
    #Cell 1 Code
    if (puzzle_frame$is_blank[1] == TRUE) {
      card(textInput("word1_answer", "Answer1:"))
    }
    else {
      card(puzzle_words[1])
    },
    #Cell 2 Code
    if (puzzle_frame$is_blank[2] == TRUE) {
      card(textInput("word2_answer", "Answer1:"))
    }
    else {
      card(puzzle_words[2])
    },
    
    #Cell 3 Code
    if (puzzle_frame$is_blank[3] == TRUE) {
      card(textInput("word3_answer", "Answer1:"))
    }
    else {
      card(puzzle_words[3])
    }
  ),
  layout_columns(
    #Cell 4 Code
    if (puzzle_frame$is_blank[4] == TRUE) {
      card(textInput("word4_answer", "Answer1:"))
    }
    else {
      card(puzzle_words[4])
    },
    #Cell 5 Code
    if (puzzle_frame$is_blank[5] == TRUE) {
      card(textInput("word5_answer", "Answer1:"))
    }
    else {
      card(puzzle_words[5])
    },
    
    #Cell 6 Code
    if (puzzle_frame$is_blank[6] == TRUE) {
      card(textInput("word6_answer", "Answer1:"))
    }
    else {
      card(puzzle_words[6])
    }
  ),
  layout_columns(
    #Cell 7 Code
    if (puzzle_frame$is_blank[7] == TRUE) {
      card(textInput("word7_answer", "Answer1:"))
    }
    else {
      card(puzzle_words[7])
    },
    
    #Cell 8 Code
    if (puzzle_frame$is_blank[8] == TRUE) {
      card(textInput("word8_answer", "Answer1:"))
    }
    else {
      card(puzzle_words[8])
    },
    
    #Cell 9 Code
    if (puzzle_frame$is_blank[9] == TRUE) {
      card(textInput("word9_answer", "Answer1:"))
    }
    else {
      card(puzzle_words[9])
    }
  )
  
  
  # Need to create a card that instead of being static, starts blank and accepts user input and checks if answer is correct
)

# Define server logic
server <- function(input, output) {

  #stuff will go here at some point
}

# Run the application 
shinyApp(ui = ui, server = server)
