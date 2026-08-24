
from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# A simple GET endpoint that returns a greeting
@app.route('/mybankbalance', methods=['GET'])
def my_bank_balance():
    return jsonify({"message": "Your bank balance is $1,000."}), 200




if __name__ == '__main__':
    app.run(debug=True)