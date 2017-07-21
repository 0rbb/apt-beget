:<<=
==pthreads
===https://pecl.php.net/package/pthreads
=
function install_pthreads {
    check_ds
    echo_y "Installing pthreads..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk https://pecl.php.net/get/pthreads-2.0.10.tgz > pthreads-2.0.10.tgz
    if [ ! -f "$HOME/.beget/tmp/pthreads-2.0.10.tgz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar xvf pthreads-2.0.10.tgz
    if [ ! -d "$HOME/.beget/tmp/pthreads-2.0.10" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #compilation
    echo_y "Compilating..."
    PATH=$PATH:/usr/local/php-cgi/5.5/bin/

    mkdir -p $HOME/.local/lib/php/55/
    
    cd $HOME/.beget/tmp/pthreads-2.0.10
    phpize
    ./configure --prefix=$HOME/.local/lib/php/55/
    make
    make install #ignore fail
    
    cp $HOME/.beget/tmp/pthreads/modules/pthreads.so $HOME/.local/lib/php/56/

    if [ ! -f $HOME/.local/lib/php/56/pthreads.so ]
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
    printf "\n\n[PHP]\nextension = $HOME/.local/lib/php/56/pthreads.so" >> $HOME/public_html/cgi-bin/php.ini

    cd $HOME/public_html
    echo '<?php phpinfo();' > x.php

    #finish
    echo_g "pthreads installed"
    echo_g "dont forget to switch to cgi"    
}
