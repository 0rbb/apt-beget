function install_optipng {
    check_d
    echo_y "Installing optipng..."
    prepare_folders
    cd $HOME/.beget/tmp

    echo_y "Downloading tarball"
    curl -Lk https://downloads.sourceforge.net/project/optipng/OptiPNG/optipng-0.7.6/optipng-0.7.6.tar.gz > optipng-0.7.6.tar.gz
    if [ ! -f "$HOME/.beget/tmp/optipng-0.7.6.tar.gz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    echo_y "Unpacking tarball"
    tar xvf optipng-0.7.6.tar.gz
    if [ ! -d "$HOME/.beget/tmp/optipng-0.7.6" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    echo_y "Compiling..."
    cd $HOME/.beget/tmp/optipng-0.7.6/
    ./configure --prefix=$HOME/.local
    make -j $(expr $(nproc) / 21)
    make install

    echo_g "optipng installed"
}
