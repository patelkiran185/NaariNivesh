import requests
from dotenv import load_dotenv
import os
# Load environment variables
load_dotenv()

def generate_image(prompt):
    url = "https://api-inference.huggingface.co/models/stabilityai/stable-diffusion-xl-base-1.0"

    headers = {"Authorization": f"Bearer {os.getenv('HF_API_KEY')}"}
    data = {"inputs": prompt, "parameters": {"use_cache": False}}


    response = requests.post(url, json=data, headers=headers)

    if response.status_code == 200:
        with open("generated_image.png", "wb") as f:
            f.write(response.content)
        print("Image saved as 'generated_image.png'")
    else:
        print("Error:", response.text)


prompt = "Flash flood destroys village homes"
generate_image(prompt)

