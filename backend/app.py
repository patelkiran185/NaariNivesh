from flask import Flask, jsonify, request
from flask_cors import CORS
import google.generativeai as genai
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Initialize Flask app
app = Flask(__name__)
CORS(app)

# Configure Gemini API
genai.configure(api_key=os.getenv('GOOGLE_API_KEY'))
model = genai.GenerativeModel('gemini-pro')

# Predefined scenarios for different levels

SCENARIOS = {
    1: {
        "scenario": "You are cooking when a sudden fire breaks out in the kitchen. The flames are spreading quickly, and your children are in another room.",
        "choices": [
            "Immediately leave the house with your children and call for help.",
            "Try to put out the fire with water or a cloth.",
            "Grab some valuables before evacuating.",
            "Run outside and wait for someone else to help."
        ]
    },
    2: {
        "scenario": "You have been working at a local shop for two years, but today your employer informs you that the shop is closing, and you have lost your job.",
        "choices": [
            "Use your emergency savings to cover basic needs while searching for a new job.",
            "Take a loan immediately to manage household expenses.",
            "Wait and see if another opportunity comes up without taking action.",
            "Spend on essentials but avoid unnecessary expenses while looking for a new job."
        ]
    },
    3: {
        "scenario": "You suddenly feel unwell and visit a clinic. The doctor tells you that you need urgent medical treatment, but it is expensive.",
        "choices": [
            "Use your health insurance or savings for medical emergencies.",
            "Take a high-interest loan to cover the costs immediately.",
            "Delay treatment and hope your condition improves naturally.",
            "Sell valuable assets like jewelry to pay for the treatment."
        ]
    },
    4: {
        "scenario": "Your family member has a medical emergency in the middle of the night, and you need to arrange funds quickly.",
        "choices": [
            "Use emergency savings or a community support fund if available.",
            "Borrow from friends or family who can help without high interest.",
            "Take a loan from a moneylender with very high interest.",
            "Ignore the situation and hope it gets better by morning."
        ]
    },
    5: {
        "scenario": "A cyclone warning has been issued for your village, and evacuation orders have been given.",
        "choices": [
            "Pack important documents, food, and essentials before leaving.",
            "Stay at home and wait to see if the cyclone actually hits.",
            "Leave without preparing anything in a hurry.",
            "Ignore the warning and continue daily activities as usual."
        ]
    }
}



@app.route('/scenario/<int:level>', methods=['GET'])
def get_scenario(level):
    """Endpoint to get scenario for a specific level"""
    if level not in SCENARIOS:
        return jsonify({"error": "Invalid level"}), 404
    return jsonify(SCENARIOS[level])

@app.route('/evaluate', methods=['POST'])
def evaluate_choice():
    """Endpoint to evaluate user's choice using Gemini"""
    data = request.get_json()
    level = data.get('level')
    choice = data.get('choice')
    if not choice:
        return jsonify({"error": "Invalid choice"}), 400
    if not level or level not in SCENARIOS:
        return jsonify({"error": "Invalid level"}), 400
    
    scenario = SCENARIOS[level]["scenario"]
    
    # Prompt for Gemini
    prompt = f"""As a crisis management expert, evaluate this response to an emergency scenario:

Scenario: {scenario}

User's Response: {choice}

Provide a brief, constructive feedback (2-3 sentences) on this choice. Consider:
1. The immediate safety impact
2. The long-term consequences
3. Best practices in emergency response

Format your response to the user (this is a crisis readness planner everything is a simulation), focus on what they did well and/or how they could improve their response. Keep it educational and encouraging. Tell them to try again if it's the wrong answer"""

    try:
        # Generate response using Gemini
        response = model.generate_content(prompt)
        feedback = response.text
        
        # Clean and format the feedback
        feedback = feedback.strip()
        if len(feedback) > 500:  # Truncate if too long
            feedback = feedback[:497] + "..."
            
        return jsonify({"feedback": feedback})
    
    except Exception as e:
        print(f"Error generating feedback: {str(e)}")
        return jsonify({
            "error": "Failed to generate feedback",
            "feedback": "We're having trouble evaluating your response. Please try again."
        }), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True) 