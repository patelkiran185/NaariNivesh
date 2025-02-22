from flask import Flask, jsonify, request
import requests
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

app = Flask(__name__)

GEMINI_API_KEY = os.getenv("GEMINI_API")

# Predefined Lessons
LESSONS = {
  "beginner": [
    {
      "title": "Understanding Money",
      "description": "Learn the basics of money, currency, and financial transactions."
    },
    {
      "title": "Creating a Budget",
      "description": "How to create a simple budget to manage income and expenses."
    },
    {
      "title": "Savings & Emergency Funds",
      "description": "Understanding the importance of savings and emergency funds."
    },
    {
      "title": "Basic Banking",
      "description": "How to open and use a bank account for financial security."
    },
    {
      "title": "Understanding Credit & Debt",
      "description": "Basics of credit, loans, and how to avoid debt traps."
    }
  ],
  "intermediate": [
    {
      "title": "Smart Spending Habits",
      "description": "How to prioritize spending and avoid unnecessary expenses."
    },
    {
      "title": "Different Types of Bank Accounts",
      "description": "Savings, current, and fixed deposit accounts explained."
    },
    {
      "title": "Introduction to Investing",
      "description": "Learn about stocks, bonds, and mutual funds."
    },
    {
      "title": "Understanding Interest Rates",
      "description": "How interest rates impact savings and loans."
    },
    {
      "title": "Managing Loans Wisely",
      "description": "How to take loans responsibly and repay efficiently."
    }
  ],
  "advanced": [
    {
      "title": "Building a Long-Term Investment Plan",
      "description": "How to create a sustainable investment strategy."
    },
    {
      "title": "Tax Planning & Benefits",
      "description": "Understanding tax structures and savings options."
    },
    {
      "title": "Stock Market Basics",
      "description": "How to analyze stocks and invest wisely."
    },
    {
      "title": "Retirement Planning",
      "description": "Planning financial security for retirement."
    },
    {
      "title": "Entrepreneurship & Financial Growth",
      "description": "How to start and manage a business financially."
    }
  ]
}


# Endpoint to Get Lessons Based on Level
@app.route("/lessons/<level>", methods=["GET"])
def get_lessons(level):
    if level not in LESSONS:
        return jsonify({"error": "Invalid level"}), 404
    return jsonify(LESSONS[level])

# Function to Generate Lesson Content Using Gemini API
def generate_lesson_content(topic):
    prompt = f"""Generate a detailed educational lesson on the topic: {topic}. Explain in simple terms, include examples and practical tips.
    Structure it as follows:
1. **Introduction**: Explain why this topic is important.
2. **Key Concepts**: Provide 3-5 key points in bullet format.
3. **Real-Life Example**: Show a practical scenario where this is useful.
4. **Conclusion & Next Steps**: Summarize key takeaways and suggest what the user should do next."""

    url = f"https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key={GEMINI_API_KEY}"
    
    headers = {"Content-Type": "application/json"}
    payload = {
        "contents": [
            {
                "parts": [{"text": prompt}]
            }
        ]
    }

    response = requests.post(url, headers=headers, json=payload)

    if response.status_code != 200:
        print("Error:", response.json())  # Debugging
        return {"error": "Error generating lesson from Gemini API"}, 500

    try:
        lesson_content = response.json()["candidates"][0]["content"]["parts"][0]["text"]
        return {"title": topic, "content": lesson_content}
    except KeyError:
        return {"error": "Unexpected response format from Gemini API"}, 500

# Endpoint to Generate a Lesson When a User Clicks a Module
@app.route("/generate_lesson/<topic>", methods=["GET"])
def generate_lesson(topic):
    return jsonify(generate_lesson_content(topic))

if __name__ == "__main__":
    app.run(debug=True)
