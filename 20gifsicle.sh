:<<=
==gifsicle
===https://github.com/kohler/gifsicle
=
function install_gifsicle {
    check_d
    echo_y "Installing gifsicle..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk http://www.lcdf.org/gifsicle/gifsicle-1.88.tar.gz > gifsicle.tar.gz
    if [ ! -f "$HOME/.beget/tmp/gifsicle.tar.gz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar xvf gifsicle.tar.gz
    if [ ! -d "$HOME/.beget/tmp/gifsicle-1.88" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #compilation
    echo_y "Compilating..."
    cd $HOME/.beget/tmp/gifsicle-1.88
    aclocal
    automake --add-missing
    autoconf
    ./configure --prefix=$HOME/.local
    make -j $(expr $(nproc) / 4)
    make install
    if [ ! -f "$HOME/.local/bin/gifsicle" ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #finish
    echo_g "gifsicle installed"
}
