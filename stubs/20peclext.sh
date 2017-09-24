:<<=
==peclextension
===https://pecl.php.net/package/peclextension
=
function install_peclextension {
    check_ds
    echo_y "Installing peclextension..."
    
    echo_y "Enter PHP version (default is 5.6)"
    read var
    if [[ ! $var ]]
    then
        var='5.6'
    fi

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk https://pecl.php.net/get/peclextension.tgz > peclextension.tgz
    if [ ! -f "$HOME/.beget/tmp/peclextension.tgz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar xvf peclextension.tgz
    if [ ! -d "$HOME/.beget/tmp/peclextension" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #compilation
    echo_y "Compilating..."
    PATH=$PATH:/usr/local/php-cgi/5.6/bin/

    mkdir -p $HOME/.local/php/cgi/$var/lib/php/
    
    cd $HOME/.beget/tmp/peclextension
    phpize
    ./configure --prefix=$HOME/.local/php/cgi/$var/lib/php/
    make
    make install #ignore fail
    
    cp $HOME/.beget/tmp/peclextension/modules/peclextension.so $HOME/.local/php/cgi/$var/lib/php/

    if [ ! -f $HOME/.local/php/cgi/$var/lib/php/peclextension.so ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #install
    echo_y "Installing..."
    if [ ! -f "$HOME/public_html/cgi-bin/php.ini" ]
    then
        mkdir -p $HOME/public_html/cgi-bin/
        cp /etc/php/cgi/5.6/php.ini $HOME/public_html/cgi-bin/php.ini
    fi
    sed -i 's/; EOF//g' $HOME/public_html/cgi-bin/php.ini
    printf "\n\n[PHP]\nextension = $HOME/.local/php/cgi/$var/lib/php/peclextension.so" >> $HOME/public_html/cgi-bin/php.ini

    echo '<?php phpinfo();' > $HOME/public_html/x.php

    #finish
    echo_g "peclextension installed"
    echo_g "dont forget to switch to cgi"    
}
