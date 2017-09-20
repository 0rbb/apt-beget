function install_jpegtran {
    check_d
    echo_y "Installing Jpegtran..."

    #prepare folders
    prepare_folders
    rm -rf $HOME/.beget/tmp/jpegtran
    cd $HOME/.beget/tmp

    #download
    echo_y "Cloning repo"
    git clone https://github.com/cloudflare/jpegtran.git
    if [ ! -d "$HOME/.beget/tmp/jpegtran" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi

    #compile
    echo_y "Compiling..."
    cd $HOME/.beget/tmp/jpegtran
    ./configure --prefix=$HOME/.local
    make -j $(expr $(nproc) / 4)
    make install
    if [ -f "$HOME/.local/bin/jpegtran" ]
    then
        echo_g "jpegtran installed"
    else
        echo_r "Seems like compilation is failed"
        exit 1
    fi
}
