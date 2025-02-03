import yfinance as yf
import flask
from flask import jsonify
from datetime import datetime

# Flask app setup
app = flask.Flask(__name__)

# Function to fetch data for a stock over the past year
def fetch_stock_data(symbol):
    stock = yf.Ticker(symbol)
    data = stock.history(period="1y")  # Last 1 year data
    data = data[['Close']]  # We are interested in the 'Close' price
    data['Date'] = data.index
    data.reset_index(drop=True, inplace=True)
    return data[['Date', 'Close']].to_dict(orient="records")

# Endpoint to fetch stock data for top 3 Nifty50 stocks
@app.route('/get_top_stocks_data', methods=['GET'])
def get_top_stocks_data():
    top_stocks = ['RELIANCE.NS', 'TCS.NS', 'INFY.NS']  # Top 3 Nifty50 Stocks
    stock_data = {}

    for stock in top_stocks:
        stock_data[stock] = fetch_stock_data(stock)

    return jsonify(stock_data)

# Run the server on port 5000
if __name__ == '__main__':
    app.run(debug=True, port=5000)
