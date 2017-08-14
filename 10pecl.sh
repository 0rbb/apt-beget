:<<=
==install any extension from pecl
===https://pecl.php.net/
=
function install_from_pecl {
    check_ds
    echo_y "Installing $1..."

    #collect info
    if [ -z $1 ]
    then
        echo_r "Define extension (format: extension-0.0.0.tgz)"
        exit 1
    fi

    if [[ "$1" =~ ^[a-z]+\-[0-9]+\.[0-9]+\.[0-9]+.*\.tgz$ ]]
    then
        true
    else
        echo_r "Define extension (format: extension-0.0.0.tgz)"
        exit 1
    fi

    if [ -z $2 ]
    then
        echo_r "Define PHP version (format 5.6)"
        exit 1
    fi

    if [[ $2 =~ ^[0-9]\.[0-9]$ ]]
    then
        true
    else
        echo_r "Define PHP version (format 5.6)"
        exit 1
    fi

    ext_name=`/usr/local/php-cgi/5.6/bin/php -r '$a=explode("-",$argv[1]);print_r($a[0]);' $1`
    ext_ver=`/usr/local/php-cgi/5.6/bin/php -r '$a=explode("-",$argv[1]);print_r(pathinfo($a[1])["filename"]);' $1`

    prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk "https://pecl.php.net/get/$1" > $1
    if [ ! -f "$HOME/.beget/tmp/$1" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar xvf $1
    if [ ! -d "$HOME/.beget/tmp/$ext_name-$ext_ver" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #compilation
    echo_y "Compilating..."
    PATH=$PATH:/usr/local/php-cgi/$2/bin/

    mkdir -p $HOME/.local/lib/php/$2/
    
    cd "$HOME/.beget/tmp/$ext_name-$ext_ver"
    phpize
    ./configure --prefix=$HOME/.local/lib/php/$2/
    make
    make install #ignore fail
    
    cp -f "$HOME/.beget/tmp/$ext_name-$ext_ver/modules/$ext_name.so" $HOME/.local/lib/php/$2/

    if [ ! -f "$HOME/.local/lib/php/$2/$ext_name.so" ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #install
    echo_y "Installing..."
    if [ ! -f "$HOME/public_html/cgi-bin/php.ini" ]
    then
        mkdir -p $HOME/public_html/cgi-bin/
        cp /etc/php/cgi/$2/php.ini $HOME/public_html/cgi-bin/php.ini
    fi
    sed -i 's/; EOF//g' $HOME/public_html/cgi-bin/php.ini
    printf "\n\n[PHP]\nextension = $HOME/.local/lib/php/$2/$ext_name.so" >> $HOME/public_html/cgi-bin/php.ini

    echo '<?php phpinfo();' > $HOME/public_html/x.php

    #finish
    echo_g "Extension $ext_name installed"
    echo_g "Dont forget to switch PHP to cgi"    
}
