:<<=
==phalcon
===NOT AN INSTALLER, JUST STUB TO CREATE INSTALLER
=
function install_phalcon {
    check_ds
    echo_y "Installing phalcon..."

    echo_y "Enter PHP version (default is 7.1)"
    read var
    if [[ ! $var ]]
    then
        var='7.1'
    fi

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."

    #cloning
    echo_y "Cloning..."
    cd $HOME/.beget/tmp
    git clone --depth=1 "git://github.com/phalcon/cphalcon.git"
    if [ ! -d "$HOME/.beget/tmp/cphalcon" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi
    

    #compilation
    echo_y "Compilating..."
    cd $HOME/.beget/tmp/cphalcon/build
    PATH=$PATH:/usr/local/php-cgi/$var/bin/
    ./install
    if [ ! -f "$HOME/.beget/tmp/cphalcon/build/php7/64bits/modules/phalcon.so" ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #install
    echo_y "Installing..."
    mkdir -p "$HOME/.local/php/cgi/$var/lib/php/"
    cp "$HOME/.beget/tmp/cphalcon/build/php7/64bits/modules/phalcon.so" "$HOME/.local/php/cgi/$var/lib/php/"

    if [ ! -f "$HOME/public_html/cgi-bin/php.ini" ]
    then
        mkdir -p $HOME/public_html/cgi-bin/
        cp /etc/php/cgi/$var/php.ini $HOME/public_html/cgi-bin/php.ini
    fi
    sed -i 's/; EOF//g' $HOME/public_html/cgi-bin/php.ini
    printf "\n\n[PHP]\nextension = $HOME/.local/php/cgi/$var/lib/php/phalcon.so" >> $HOME/public_html/cgi-bin/php.ini

    echo '<?php phpinfo();' > $HOME/public_html/x.php

    #finish
    echo_g "phalcon installed"
}
