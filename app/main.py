import os
import yaml
from flask import Flask, jsonify, request, make_response

from database.dao_get import select_from_database
from config import *

app = Flask(__name__)

@app.route('/')
def index():
    return "This is My Happy API"

@app.route('/api/health/', methods=['GET'])
def healthcheck():
    #Realizar consulta da aplicacao no banco de dados
    select_return = select_from_database(username, password, database_host, database)
    if select_return:
        return make_response(jsonify({'Response':True}), 200)
    else:
        return make_response(jsonify({'Response':False}), 503)


if __name__ == '__main__':
    #Host resposavel para servir o trafego alem do localhost
    app.run(debug=True, port=8888,host='0.0.0.0')