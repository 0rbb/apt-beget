<<=
==libxml2
=
function install_libxml2 {
    check_ds
    echo_y "Installing Git..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #cloning
    echo_y "Cloning..."
    cd $HOME/.beget/tmp
    git clone git://git.gnome.org/libxml2
    if [ ! -d "$HOME/.beget/tmp/libxml2" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi
    
    #compilation
    echo_y "Compilating..."
    cd libxml2
    ./autogen.sh --prefix=$HOME/.local --disable-shared
    ./configure --prefix=$HOME/.local
    make
    make install
    if [ ! -f "$HOME/.local/bin/xmllint" ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #finish
    echo_g "default installed"
}
