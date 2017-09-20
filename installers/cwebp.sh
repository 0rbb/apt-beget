function install_cwebp {
    check_d
    echo_y "Installing Cwebp..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #download
    echo_y "Cloning repo..."
    git clone https://github.com/webmproject/libwebp.git
    if [ ! -d "$HOME/.beget/tmp/libwebp" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi

    #compile
    echo_y "Compiling..."
    cd $HOME/.beget/tmp/libwebp
    ./autogen.sh
    ./configure --prefix=$HOME/.local
    make -j $(expr $(nproc) / 4)
    make install
    if [ ! -f "$HOME/.local/bin/cwebp" ]
    then
        echo_r "Seems like compilation is failed"
        exit 1
    fi

    echo_g "Cwebp installed"
}
