
rm(list = ls())
library(httr)
library(jsonlite)
source("src/func.R")

scatter_prompt <- paste(
  "Provide R code using ggplot2 to create a scatter plot of",
  "Sepal.Length vs. Sepal.Width using the built-in iris dataset.",
  "Include comments explaining each step."
)

scatter_code <- chatgpt_query(scatter_prompt)

cat("ChatGPT Suggested Code for Scatter Plot:\n")
cat(scatter_code, "\n")



