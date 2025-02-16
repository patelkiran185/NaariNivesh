import json
import google.generativeai as genai
from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()

app = Flask(__name__)
CORS(app)

# Get the API key from environment variables
GENAI_API_KEY = os.getenv("GENAI_API_KEY")
if not GENAI_API_KEY:
    raise ValueError("Missing Gemini API key.")

genai.configure(api_key=GENAI_API_KEY)

questions = [
    {"question": "What is compound interest?", "difficulty": "Medium", "points": 10},
    # Add more questions here
]

def evaluate_answer(user_answer, correct_question):
    """Uses Gemini API to evaluate user responses."""
    model = genai.GenerativeModel("gemini-pro")

    prompt = f"""
    You are an AI evaluator. Given a question and a user's answer, return a score out of 10.
    Format the response strictly as JSON: {{"score": <integer_score>}}

    Question: {correct_question}
    User's Answer: {user_answer}
    """

    try:
        response = model.generate_content(prompt)
        result_text = response.text.strip()

        # Ensure response is valid JSON
        score_data = json.loads(result_text)
        return score_data.get("score", 0)

    except Exception as e:
        print("Error parsing response:", e)
        return 0  # Default to 0 in case of failure

@app.route("/evaluate", methods=["POST"])
def evaluate():
    data = request.get_json()
    user_answer = data.get("answer", "").strip()
    question = data.get("question", "").strip()

    if not user_answer or not question:
        return jsonify({"error": "Invalid input"}), 400

    score = evaluate_answer(user_answer, question)
    return jsonify({"points": score})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)