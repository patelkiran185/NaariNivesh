from flask import Flask, request, jsonify
from flask_cors import CORS
import numpy as np
from models import RiskProfileAssessment, PortfolioOptimization, MarketAnalysis, RecommendationEngine

app = Flask(__name__)
CORS(app)

# Initialize AI models
risk_model = RiskProfileAssessment()
portfolio_optimizer = PortfolioOptimization()
market_analyzer = MarketAnalysis()
recommendation_engine = RecommendationEngine()

@app.route('/api/profile/analyze', methods=['POST'])
def analyze_profile():
    user_data = request.json
    
    # Generate risk assessment
    risk_score = risk_model.predict(user_data)
    
    # Analyze market conditions
    market_conditions = market_analyzer.get_current_conditions()
    
    return jsonify({
        'riskScore': float(risk_score),
        'marketConditions': market_conditions
    })

@app.route('/api/recommendations', methods=['POST'])
def get_recommendations():
    data = request.json
    profile = data['profile']
    risk_score = data['riskScore']
    
    # Generate portfolio optimization
    optimal_portfolio = portfolio_optimizer.optimize(
        risk_tolerance=risk_score,
        current_portfolio=profile['existingInvestments'],
        market_conditions=market_analyzer.get_current_conditions()
    )
    
    # Generate personalized recommendations
    recommendations = recommendation_engine.generate_recommendations(
        user_profile=profile
    )
    
    return jsonify({
        'optimalPortfolio': optimal_portfolio,
        'recommendations': recommendations
    })

if __name__ == '__main__':
    app.run(debug=True)


#    {
#      "age": 30,
#      "location": "Mumbai",
#      "occupation": "Software Engineer",
#      "income": 1500000,
#      "expenses": 800000,
#      "existingInvestments": {
#        "stocks": 200000,
#        "mutualFunds": 300000,
#        "fixedDeposits": 200000
#      },
#      "financialGoals": ["Retirement", "House"],
#      "taxBracket": 30,
#      "experienceLevel": 2,
#      "familyObligations": {
#        "dependents": 2,
#        "loans": {"homeLoan": 2000000}
#      }
#    }