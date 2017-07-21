:<<=
==Instant Client
===http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html
=
function install_instant_client {
    check_ds
    echo_y "Installing Instant Client..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."

    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk http://download.oracle.com/otn/linux/instantclient/122010/instantclient-basic-linux.x64-12.2.0.1.0.zip?AuthParam=1496156495_25fb50b3ef12506a8cd3194cd54c9f38 > instantclient-basic-linux.x64-12.2.0.1.0.zip
    if [ ! -f "$HOME/.beget/tmp/instantclient-basic-linux.x64-12.2.0.1.0.zip" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    curl -Lk http://download.oracle.com/otn/linux/instantclient/122010/instantclient-sdk-linux.x64-12.2.0.1.0.zip?AuthParam=1496157472_8c27b44212baf43003c9647aa21c0b66 > instantclient-sdk-linux.x64-12.2.0.1.0.zip
    if [ ! -f "$HOME/.beget/tmp/instantclient-sdk-linux.x64-12.2.0.1.0.zip" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    unzip instantclient-sdk-linux.x64-12.2.0.1.0.zip
    if [ ! -d "$HOME/.beget/tmp/instantclient_12_2" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #install
    echo_y "Installing..."
    mv $HOME/.beget/tmp/instantclient_12_2 $HOME/.local/opt

    #finish
    echo_g "Instant Client installed"
}

:<<=
==oci8
===http://php.net/manual/ru/oci8.installation.php
===https://pecl.php.net/package/oci8/1.4.10
=
function install_oci8 {
    check_ds
    echo_y "Installing oci8..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_instant_client

    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    #/usr/local/php-cgi/5.6/bin/pecl download oci8-1.4.10
    curl -Lk https://pecl.php.net/get/oci8-1.4.10.tgz > oci8-1.4.10.tgz
    if [ ! -f "$HOME/.beget/tmp/oci8-1.4.10.tgz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar xvf oci8-1.4.10.tgz
    if [ ! -d "$HOME/.beget/tmp/oci8-1.4.10" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #compilation
    echo_y "Compilating..."
    PATH=$PATH:/usr/local/php-cgi/5.6/bin/
    ln -sf $HOME/.local/opt/instantclient_12_2/libclntsh.so.12.1 $HOME/.local/opt/instantclient_12_2/libclntsh.so
    
    cd $HOME/.beget/tmp/oci8-1.4.10
    phpize
    ./configure --prefix=$HOME/.local/lib/php/56/ -with-oci8=instantclient,$HOME/.local/opt/instantclient_12_2
    make install
    
    mkdir -p $HOME/.local/lib/php/56/
    cp modules/oci8.so $HOME/.local/lib/php/56/

    if [ ! -f $HOME/.local/lib/php/56/oci8.so ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #install
    echo_y "Installing..."
    if [ ! -f "$HOME/public_html/cgi-bin/php.ini" ]
    then
        mkdir -p $HOME/public_html/
        cp /etc/php/cgi/5.6/php.ini $HOME/public_html/cgi-bin/php.ini
    fi
    sed -i 's/; EOF//g' $HOME/public_html/cgi-bin/php.ini
    printf "\n\n[PHP]\nextension = $HOME/.local/lib/php/56/oci8.so" >> $HOME/public_html/cgi-bin/php.ini

    #finish
    echo_g "oci8 installed"
    echo_g "dont forget to switch to cgi"    
}
