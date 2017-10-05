:<<=
==gmagick
===http://www.graphicsmagick.org/index.html
===https://pecl.php.net/package/gmagick
=
function install_gmagick {
    check_ds
    echo_y "Installing gmagick..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders
   
    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk https://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/1.3.25/GraphicsMagick-1.3.25.tar.gz > GraphicsMagick-1.3.25.tar.gz
    if [ ! -f "$HOME/.beget/tmp/GraphicsMagick-1.3.25.tar.gz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar xvf GraphicsMagick-1.3.25.tar.gz 
    if [ ! -d "$HOME/.beget/tmp/GraphicsMagick-1.3.25" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #compilation
    echo_y "Compilating..."
    cd GraphicsMagick-1.3.25
    export CXXFLAGS="$CXXFLAGS -fPIC"
    ./configure --prefix=$HOME/.local --enable-shared
    make -j $(expr $(nproc) / 21)
    make install
    make check
    if [ ! -f "$HOME/.local/bin/gm" ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk curl https://pecl.php.net/get/gmagick-1.1.7RC3.tgz > gmagick-1.1.7RC3.tgz
    if [ ! -f "$HOME/.beget/tmp/gmagick-1.1.7RC3.tgz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar xvf gmagick-1.1.7RC3.tgz
    if [ ! -d "$HOME/.beget/tmp/gmagick-1.1.7RC3" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #compilation
    echo_y "Compilating..."
    PATH=$PATH:/usr/local/php-cgi/5.6/bin/
    mkdir -p $HOME/.local/lib/php/56/
    cd gmagick-1.1.7RC3/
    phpize
    ./configure --prefix=$HOME/.local/lib/php/56/ --with-gmagick=$HOME/.local
    make -j $(expr $(nproc) / 21)
    cp modules/gmagick.so $HOME/.local/lib/php/56/
    if [ ! -f $HOME/.local/lib/php/56/gmagick.so ]
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
    printf "\n\n[PHP]\nextension = $HOME/.local/lib/php/56/gmagick.so" >> $HOME/public_html/cgi-bin/php.ini

    #finish
    echo_g "gmagick installed"
}
