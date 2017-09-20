:<<=
==libxslt
=
function install_libxslt {
    check_ds
    echo_y "Installing Git..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #cloning
    echo_y "Cloning..."
    cd $HOME/.beget/tmp
    git clone https://git.gnome.org/browse/libxslt
    if [ ! -d "$HOME/.beget/tmp/libxslt" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi
    
    #compilation
    echo_y "Compilating..."
    cd libxslt
    ./autogen.sh --prefix=$HOME/.local --disable-shared
    ./configure --prefix=$HOME/.local
    make
    make install
    if [ ! -f "$HOME/.local/bin/xsltproc" ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #finish
    echo_g "default installed"
}
