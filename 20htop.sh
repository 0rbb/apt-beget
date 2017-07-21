:<<=
==htop
===https://github.com/hishamhm/htop
=
function install_htop {
    echo_y "Installing Htop..."

    #prepare folders
    prepare_folders
    rm -rf $HOME/.beget/tmp/htop
    cd $HOME/.beget/tmp

    #download
    echo_y "Cloning repo"
    git clone https://github.com/hishamhm/htop.git
    if [ ! -d "$HOME/.beget/tmp/htop" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi

    #compile
    echo_y "Compiling..."
    cd $HOME/.beget/tmp/htop
    ./autogen.sh
    ./configure --prefix=$HOME/.local
    make -j $(expr $(nproc) / 4)
    make install
    if [ -f "$HOME/.local/bin/htop" ]
    then
        echo_g "htop installed"
    else
        echo_r "Seems like compilation is failed"
        exit 1
    fi
}
