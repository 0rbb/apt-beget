:<<=
==phpbrew
===https://github.com/phpbrew/phpbrew/
===useful info and howtos - https://github.com/phpbrew/phpbrew/wiki/Cookbook
=
function install_phpbrew {
    check_d
    echo_y "Installing phpbrew..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk https://github.com/phpbrew/phpbrew/raw/master/phpbrew > $HOME/.local/bin/phpbrew
    
    if [ ! -f "$HOME/.local/bin/phpbrew" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #install
    echo_y "Installing..."
    chmod +x $HOME/.local/bin/phpbrew

    #finish
    echo_g "phpbrew installed"
}

function install_php52 {
    phpbrew install php-5.2 +default
    phpbrew use php-5.2
}

function install_php53 {
    phpbrew install php-5.3 +default
    phpbrew use php-5.3
}

function install_php54 {
    phpbrew install php-5.4 +default
    phpbrew use php-5.4
}

function install_php56 {
    phpbrew install php-5.6 +default
    phpbrew use php-5.6
}
