chatgpt_query_with_history <- function(new_prompt, history = NULL, model = "gpt-3.5-turbo") {
  # Initialize history if not provided
  if (is.null(history)) {
    history <- list(list(role = "system", content = "You are a helpful coding assistant in R."))
  }
  
  # Append the new user prompt to the conversation history
  history <- append(history, list(list(role = "user", content = new_prompt)))
  
  api_key <- Sys.getenv("OPENAI_API_KEY")
  if (api_key == "") {
    stop("Please set your OPENAI_API_KEY environment variable.")
  }
  
  endpoint <- "https://api.openai.com/v1/chat/completions"
  headers <- add_headers(
    Authorization = paste("Bearer", api_key),
    "Content-Type" = "application/json"
  )
  
  body <- list(
    model = model,
    messages = history
  )
  
  result <- tryCatch({
    response <- POST(endpoint, headers, body = toJSON(body, auto_unbox = TRUE))
    if (response$status_code != 200) {
      error_message <- content(response, "text", encoding = "UTF-8")
      stop("API request failed with status code: ", response$status_code, ". Error: ", error_message)
    }
    parsed <- content(response, "parsed")
    answer <- parsed$choices[[1]]$message$content
    
    # Append the assistant's response to the conversation history
    history <- append(history, list(list(role = "assistant", content = answer)))
    
    list(answer = answer, history = history)
  }, error = function(e) {
    cat("An error occurred: ", e$message, "\n")
    list(answer = NULL, history = history)
  })
  
  return(result)
}

extract_r_code <- function(text) {
  # Use the (?s) flag to make . match newlines
  pattern <- "(?s)```[Rr]?\\s*\\n(.*?)\\n```"
  matches <- regexec(pattern, text, perl = TRUE)
  captured <- regmatches(text, matches)
  
  if (length(captured) > 0 && length(captured[[1]]) > 1) {
    return(captured[[1]][2])
  } else {
    message("No R code block found. Returning the original text.")
    return(text)
  }
}

conversation_history <- list(
  list(role = "system", content = "You are a helpful coding assistant in R.")
)
