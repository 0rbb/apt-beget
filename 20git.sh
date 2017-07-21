:<<=
==Git
=
function install_git {
    check_ds
    echo_y "Installing Git..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders
    
    #depencies
    echo_y "Satisfaying depencies..."

    #cloning
    echo_y "Cloning..."
    cd $HOME/.beget/tmp
    git clone https://github.com/git/git
    if [ ! -d "$HOME/.beget/tmp/git" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi
    
    #compilation
    echo_y "Compilating..."
    cd git
    make configure
    ./configure --prefix=$HOME/.local
    make install
    if [ ! -f "$HOME/.local/bin/git" ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #finish
    echo_g "Git installed"
}
