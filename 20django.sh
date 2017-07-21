function install_django {
    echo_y "Installing Python 3 and Django..."
    check_d
    
    target_directory=${BASH_ARGV[0]}
    echo $target_directory
    
    if [ -z "$target_directory" ]
    then
        echo_r "А куда стовить-то? Set second parameter as target directory."
        exit 1
    fi
    
    #depencies
    echo_y "Satisfaying depencies..."
    install_python3

    #Application
    echo_y 'Creating application...'
    cd $HOME

    mkdir -p $HOME/$target_directory/public
    rm -rf $HOME/$target_directory/public_html
    ln -sf $HOME/$target_directory/public $HOME/$target_directory/public_html

    mkdir $HOME/.cache

    pip3 install django --user --ignore-installed

    cd $target_directory
    python3 $HOME/.local/bin/django-admin.py startproject HelloDjango

    echo "# -*- coding: utf-8 -*-
import os, sys
#project directory
sys.path.insert(0, '$HOME/$target_directory/HelloDjango')
sys.path.insert(1, '$HOME/.local/lib/python3.6/site-packages')
#project settings
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'HelloDjango.settings')
#start server
from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()" > $HOME/$target_directory/HelloDjango/passenger_wsgi.py

    sed -i "s/ALLOWED_HOSTS\s=\s\[\]/ALLOWED_HOSTS = \['$target_directory'\]/g" $HOME/$target_directory/HelloDjango/HelloDjango/settings.py

    echo "PassengerEnabled On
PassengerAppRoot $HOME/$target_directory/HelloDjango
PassengerPython  $HOME/.local/bin/python3" > $HOME/$target_directory/.htaccess

    mkdir -p $HOME/$target_directory/tmp
    touch    $HOME/$target_directory/tmp/restart.txt

    echo_g 'check it now'
}
