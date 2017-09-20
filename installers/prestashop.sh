:<<=
==PrestaShop
===https://www.prestashop.com
===https://github.com/PrestaShop/PrestaShop
=
function install_prestashop {
    check_ds
    echo_y "Installing PrestaShop..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_composer

    #download
    echo_y "Cloning..."
    cd $HOME
    git clone https://github.com/PrestaShop/PrestaShop.git
    if [ ! -d "$HOME/PrestaShop" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi

    #install
    echo_y "Installing..."
    
    mkdir $HOME/.local/etc
    printf "[PHP]\ndate.timezone = Europe/Moscow\nshort_open_tag = On" > $HOME/.local/etc/php.ini
    echo "/usr/local/php-cgi/5.6/bin/php -c $HOME/.local/etc/php.ini \$@" > $HOME/.local/bin/php
    chmod +x $HOME/.local/bin/php
    
    rm -rf public_html
    mv PrestaShop public_html
    cd public_html
    composer install

    #finish
    echo_g "PrestaShop installed"
}
