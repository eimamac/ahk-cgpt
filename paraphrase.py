import requests
import json
import sys
import os

user_content = sys.argv[1] if len(sys.argv) > 1 else "No content provided."

url = "https://api.openai.com/v1/chat/completions"
headers = {
    "Content-Type": "application/json",
    "Authorization": f"Bearer {os.getenv('OPENAI_KEY')}"
}
data = {
    "model": "gpt-3.5-turbo",
    "messages": [
        {
            "role": "system",
            "content": "Paraphrase the given text to sound more fluent. Do not add any additional sentences, just convert the existing text."
        },
        {
            "role": "user",
            "content": user_content
        }
    ]
}

response = requests.post(url, headers=headers, data=json.dumps(data))
response_json = response.json()
content = response_json["choices"][0]["message"]["content"]
print(content)

