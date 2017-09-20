function install_ncdu {
    check_d
    echo_y "Installing default..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk http://dev.yorhel.nl/download/ncdu-1.12.tar.gz > ncdu-1.12.tar.gz
    if [ ! -f "$HOME/.beget/tmp/ncdu-1.12.tar.gz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar xvf ncdu-1.12.tar.gz
    if [ ! -d "$HOME/.beget/tmp/ncdu-1.12" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #compilation
    echo_y "Compilating..."
    cd ncdu-1.12
    aclocal
    autoconf
    autoheader
    automake --add-missing
    ./configure --prefix=$HOME/.local
    make -j $(expr $(nproc) / 4)
    make install
    if [ ! -f "$HOME/.local/bin/ncdu" ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #finish
    echo_g "NCDU installed"
}
