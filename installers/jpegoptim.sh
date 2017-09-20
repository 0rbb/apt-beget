:<<=
==jpegoptim
===https://github.com/tjko/jpegoptim
=
function install_jpegoptim {
    check_d
    echo_y "Installing jpegoptim..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #cloning
    echo_y "Cloning..."
    cd $HOME/.beget/tmp
    git clone https://github.com/tjko/jpegoptim.git
    if [ ! -d "$HOME/.beget/tmp/jpegoptim" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi

    #compilation
    echo_y "Compilating..."
    cd jpegoptim
    ./configure --prefix=$HOME/.local
    make -j $(expr $(nproc) / 4)
    make strip
    make install
    if [ ! -f "$HOME/.local/bin/jpegoptim" ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #finish
    echo_g "jpegoptim installed"
}
