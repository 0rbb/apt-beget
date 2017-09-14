:<<=
==Default
===NOT AN INSTALLER, JUST STUB TO CREATE INSTALLER
=
function install_default {
    check_ds
    echo_y "Installing default..."

    #collecting install information
    echo_y "ENTER parametr (default is VERSION)"
    read var
    if [[ $var ]]
    then
        var='VERSION'
    else
        var='VERSION'
    fi
    
    if [[ ! $var ]]
    then
        var='VERSION'
    fi

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."

    #cloning
    echo_y "Cloning..."
    cd $HOME/.beget/tmp
    git clone https://github.com/project/default.git
    if [ ! -d "$HOME/.beget/tmp/default" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi
    
    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk http://example.com/default.tar.gz > default.tar.gz
    if [ ! -f "$HOME/.beget/tmp/default.tar.gz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar xvf default.tar.gz
    if [ ! -d "$HOME/.beget/tmp/default" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #compilation
    echo_y "Compilating..."
    cd default
    ./configure --prefix=$HOME/.local
    make -j $(expr $(nproc) / 4)
    make install
    if [ ! -f "$HOME/.local/bin/default" ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #install
    echo_y "Installing..."
    echo_y "Creating project..."
    echo_y "Setting up..."
    mkdir -p $HOME/tmp
    touch $HOME/tmp/restart.txt

    #finish
    echo_g "default installed"
}
