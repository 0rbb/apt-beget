:<<=
==Laravel
=
function install_laravel {
    check_ds
    echo_y "Installing Laravel..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_composer
#    install_nodejs

    #install
    echo_y "Installing..."
    cd ~
    rm -rf ~/public_html

    echo "/usr/local/php-cgi/7.1/bin/php -c $HOME/.local/etc/php.ini \$@" > $HOME/.local/bin/php
    chmod +x $HOME/.local/bin/php

#    composer create-project --prefer-dist laravel/laravel public_html
    composer global require "laravel/installer"
    PATH=$PATH:~/.composer/vendor/bin/
    laravel new . --force
    ln -s public public_html
    cp .env.example .env
    ./artisan key:generate
    ./artisan config:clear

    #finish
    echo_g "Laravel installed"
}
