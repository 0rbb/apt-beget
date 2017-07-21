function install_python3 {
    echo_y 'Installing Python 3'
    check_d

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #Download
    echo_y 'Downloading...'
    curl -Lk https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz > $HOME/.beget/tmp/Python-3.6.1.tgz
    if [ ! -f "$HOME/.beget/tmp/Python-3.6.1.tgz" ]
    then
        echo_r 'download is failed'
        exit 1
    fi

    #Unpacking
    cd $HOME/.beget/tmp
    echo_y 'Unpacking...'
    tar xvf Python-3.6.1.tgz
    if [ ! -d "$HOME/.beget/tmp/Python-3.6.1" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #Compiling
    echo_y "Compiling..."
    cd Python-3.6.1
    ./configure --prefix $HOME/.local
    make -j $(expr $(nproc) / 4)
    make install
    if [ ! -f "$HOME/.local/bin/pip3" ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    pip3 install --upgrade pip

    #finish
    echo_g "Python 3 installed"
}
