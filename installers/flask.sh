:<<=
==flask
=
function install_flask {
    check_ds
    echo_y "Installing flask..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_python3

    #install
    echo_y "Installing..."
    pip3 install flask --user --ignore-installed
    
    echo_y "Creating project..."
    mkdir -p $HOME/HelloFlask    
    echo "# -*- coding: utf-8 -*-
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello Flask!'

if __name__ == '__main__':
    app.run()" > $HOME/HelloFlask/__init__.py

    echo "# -*- coding: utf-8 -*-
import os, sys
#project directory
sys.path.insert(0, '$HOME/Helloflask')
sys.path.insert(1, '$HOME/.local/lib/python3.6/site-packages')

from HelloFlask import app as application # когда Flask стартует, он ищет application. Если не указать 'as application', сайт не заработает
from werkzeug.debug import DebuggedApplication # Опционально: подключение модуля отладки
application.wsgi_app = DebuggedApplication(application.wsgi_app, True) # Опционально: включение модуля отадки
application.debug = False  # Опционально: True/False устанавливается по необходимости в отладке" > $HOME/passenger_wsgi.py

    echo_y "Setting up..."
    echo "PassengerEnabled On
PassengerPython  $HOME/.local/bin/python3" > $HOME/.htaccess

    ln -s public_html public    
    
    mkdir -p $HOME/tmp
    touch    $HOME/tmp/restart.txt

    #finish
    echo_g "flask installed"
}