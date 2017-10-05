:<<=
==Django
=
function install_django {
    check_ds
    echo_y "Installing Django..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_python3

    #install
    echo_y "Installing..."
    pip3 install django --user --ignore-installed

    echo_y "Creating project..."
    cd $HOME
    $HOME/.local/bin/python3 $HOME/.local/bin/django-admin.py startproject HelloDjango --verbosity 3

    echo_y "Setting up..."
    echo "# -*- coding: utf-8 -*-
import os, sys
#project directory
sys.path.insert(0, '$HOME/HelloDjango')
sys.path.insert(1, '$HOME/.local/lib/python3.6/site-packages')
#project settings
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'HelloDjango.settings')
#start server
from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()" > $HOME/HelloDjango/passenger_wsgi.py

    echo "PassengerEnabled On
PassengerAppRoot $HOME/HelloDjango
PassengerPython  $HOME/.local/bin/python3" > $HOME/.htaccess

    target_directory="$(basename $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))"
    sed -i "s/ALLOWED_HOSTS\s=\s\[\]/ALLOWED_HOSTS = \['$target_directory'\]/g" $HOME/HelloDjango/HelloDjango/settings.py
    echo_y "Edit 'ALLOWED_HOSTS' in $HOME/HelloDjango/HelloDjango/settings.py if domain name is different from"

    mkdir -p $HOME/tmp
    touch    $HOME/tmp/restart.txt

    #finish
    echo_g "Django installed"
}
