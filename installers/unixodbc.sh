:<<=
==unixodbc
===http://www.unixodbc.org/
=
function install_unixodbc {
    check_d
    echo_y "Installing unixODBC..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk http://www.unixodbc.org/unixODBC-2.3.4.tar.gz > unixODBC-2.3.4.tar.gz
    if [ ! -f "$HOME/.beget/tmp/unixODBC-2.3.4.tar.gz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar xvf unixODBC-2.3.4.tar.gz
    if [ ! -d "$HOME/.beget/tmp/unixODBC-2.3.4" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #compilation
    echo_y "Compilating..."
    cd unixODBC-2.3.4
    mkdir $HOME/.local/etc
    ./configure --prefix=$HOME/.local --sysconfdir=$HOME/etc
    make -j $(expr $(nproc) / 4)
    make install
    if [ ! -f "$HOME/.local/bin/odbc_config" ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #finish
    echo_g "unixODBC installed"
}
