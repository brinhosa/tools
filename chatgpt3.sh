#!/bin/bash

#Based on https://github.com/CristiVlad25/gpt3cli

# Set your OpenAI API key
export OPENAI_API_KEY="CHANGE_HERE"

# Set the model to use (e.g. "text-davinci-003")
MODEL="text-davinci-003"

# Set the prompt to use as input for the GPT-3 model
PROMPT="$@"
echo $PROMPT

# Set the number of tokens to generate
TOKEN_COUNT=3000

# Set the temperature
TEMPERATURE=1

# Set the top_p value
TOP_P=1

# Set the frequency
FREQUENCY=0.5

# Set the presence
PRESENCE=0.5

# Generate text using the GPT-3 model
OUTPUT=$(curl -sk -X POST -H "Authorization: Bearer $OPENAI_API_KEY" -H "Content-Type: application/json" -d "{\"model\":\"$MODEL\",\"prompt\":\"$PROMPT\",\"temperature\":$TEMPERATURE,\"top_p\":$TOP_P,\"frequency_penalty\":$FREQUENCY,\"presence_penalty\":$PRESENCE,\"max_tokens\":$TOKEN_COUNT}" https://api.openai.com/v1/completions)

# Extract the text from the response
OUTPUT=$(echo "$OUTPUT" | jq -r '.choices[0].text')
# Print the output
#echo #$PROMPT > codigo_$(date +%Y%m%d%H%M%S).sh 
echo "$OUTPUT" | tee -a codigo_$(date +%Y%m%d%H%M%S).sh
chmod +x codigo_$(date +%Y%m%d%H%M%S).sh
echo nano codigo_$(date +%Y%m%d%H%M%S).sh
