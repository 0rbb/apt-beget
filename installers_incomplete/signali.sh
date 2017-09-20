:<<=
==Signali
===https://github.com/obshtestvo/signali
===WIP
=
function install_signali {
    check_ds
    echo_y "Installing signali..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_python3
    install_nodejs_core

    #download
    echo_y "Cloning..."
    cd $HOME/.beget/tmp
    git clone https://github.com/obshtestvo/signali.git
    if [ ! -d "$HOME/.beget/tmp/signali" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi

    #install
    echo_y "Creating project..."
    cd $HOME
    shopt -s dotglob nullglob
    mv $HOME/.beget/tmp/signali/* $HOME
    rm -rf $HOME/.beget/tmp/signali
    python3 -m venv $HOME/env/.virtualenv
    source $HOME/env/.virtualenv/bin/activate
    sed -i '/psycopg2/d' env/requirements.txt
    pip3 install --upgrade setuptools
    pip3 install -r env/requirements.txt

    cd $HOME/themes/
    git clone https://github.com/obshtestvo/signali-theme.git
    if [ ! -d "$HOME/themes/signali-theme" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi
    cd $HOME/themes/signali-theme/
    npm run provision

    cd $HOME
    cp env/.django-sample env/.django
    echo_r "Now edit .django to your needs"
    exit 0
    export PYTHONPATH=$PWD/src
    python manage.py migrate
    bash env/utils/load_dev_fixtures.sh
    python manage.py runserver

    echo_g "signali installed"
}
