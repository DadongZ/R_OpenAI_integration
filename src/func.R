
chatgpt_query <- function(prompt, model = "gpt-3.5-turbo") {
  # Retrieve API key from environment
  api_key <- Sys.getenv("OPENAI_API_KEY")
  if (api_key == "") {
    stop("Please set your OPENAI_API_KEY environment variable.")
  }
  
  # Define endpoint and headers
  endpoint <- "https://api.openai.com/v1/chat/completions"
  headers <- add_headers(
    Authorization = paste("Bearer", api_key),
    "Content-Type" = "application/json"
  )
  
  # Build request body with customizable prompt
  body <- list(
    model = model,
    messages = list(
      list(role = "system", content = "You are a helpful coding assistant in R."),
      list(role = "user", content = prompt)
    )
  )
  
  # Execute the API request with error handling
  tryCatch({
    response <- POST(endpoint, headers, body = toJSON(body, auto_unbox = TRUE))
    
    if (response$status_code != 200) {
      error_message <- content(response, "text", encoding = "UTF-8")
      stop("API request failed with status code: ", response$status_code, ". Error: ", error_message)
    }
    
    result <- content(response, "parsed")
    answer <- result$choices[[1]]$message$content
    return(answer)
  }, error = function(e) {
    cat("An error occurred: ", e$message, "\n")
    return(NULL)
  })
}
