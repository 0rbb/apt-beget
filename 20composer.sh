:<<=
==Composer
===Dependency Manager for PHP
===https://getcomposer.org
===https://github.com/composer/composer
=
function install_composer {
    echo_y "Installing Composer..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #install
    echo_y "Installing..."
    mkdir $HOME/.local/opt/composer/
    cd $HOME/.local/opt/composer/
    curl -sS https://getcomposer.org/installer | /usr/local/php-cgi/5.6/bin/php
    if [ -f "$HOME/.local/opt/composer/composer.phar" ]
    then
        echo "/usr/local/php-cgi/5.6/bin/php -dshort_open_tag=On -ddate.timezone='Europe/Moscow' $HOME/.local/opt/composer/composer.phar \$@" > $HOME/.local/bin/composer
        chmod +x $HOME/.local/bin/composer
        composer config -g github-oauth.github.com  3f1c1a81d81f714de917e068b309e76df908cadf
    else
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #finish
    echo_g "Composer installed"
}
