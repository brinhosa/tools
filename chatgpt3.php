<?php

// Set your OpenAI API key
$api_key = "CHANGE_HERE";

// Set the model to use (e.g. "text-davinci-003")
$model = "text-davinci-003";

// Set the prompt to use as input for the GPT-3 model
$prompt = $_POST["prompt"];

// Set the number of tokens to generate
$token_count = 2000;

// Set the temperature
$temperature = 1;

// Set the top_p value
$top_p = 1;

// Set the frequency
$frequency = 0.5;

// Set the presence
$presence = 0.5;

// Set the payload
$data = array("model" => $model, "prompt" => $prompt, "temperature" => $temperature, "top_p" => $top_p, "frequency_penalty" => $frequency, "presence_penalty" => $presence, "max_tokens" => $token_count);

// Use cURL to send the request
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, "https://api.openai.com/v1/completions");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    "Authorization: Bearer " . $api_key,
    "Content-Type: application/json"
));

$output = json_decode(curl_exec($ch), true);
curl_close($ch);

// Extract the text from the response
$output = $output['choices'][0]['text'];

// Print the output
echo $output;

?>
