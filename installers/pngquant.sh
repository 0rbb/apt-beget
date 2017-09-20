function install_pngquant {
    echo_y "Installing pngquant..."

    #prepare folders
    prepare_folders
    rm -rf $HOME/.beget/tmp/pngquant
    cd $HOME/.beget/tmp

    #download
    echo_y "Cloning repo"
    git clone https://github.com/pornel/pngquant.git
    if [ ! -d "$HOME/.beget/tmp/pngquant" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi

    #compile
    echo_y "Compiling..."
    cd $HOME/.beget/tmp/pngquant
    ./configure --prefix=$HOME/.local
    make -j $(expr $(nproc) / 4)
    make install
    if [ -f "$HOME/.local/bin/pngquant" ]
    then
        echo_g "pngquant installed"
    else
        echo_r "Seems like compilation is failed"
        exit 1
    fi
}
