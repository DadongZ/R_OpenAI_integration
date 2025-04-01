## ChatGPT R Integration

This repository demonstrates how to integrate the OpenAI ChatGPT API with your R environment (or RStudio) to serve as a coding assistant. An example in this repo uses the built-in `iris` dataset to generate a scatter plot with **ggplot2** via a ChatGPT prompt.

### Setup

#### 1. Store Your API Key Securely

- Obtain your API Key from [OpenAI API Keys](https://platform.openai.com/api-keys).
- Create or edit your `~/.Renviron` file.
- Add the following line (replace `your_api_key_here` with your actual key) to the `~/.Renviron` file:

``` 
OPENAI_API_KEY=your_api_key_here
```

#### 2. Clone the Repository

Open your terminal and run:

```bash
git clone https://github.com/DadongZ/R_OpenAI_integration.git
```

#### 3. Run the Example

Run the `test.R` script. It should return R code for generating a scatter plot using the `iris` dataset.

