:<<=
==Siege
===NOT AN INSTALLER, JUST STUB TO CREATE INSTALLER
=
function install_siege {
#    check_ds
    echo_y "Installing Siege..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_haskell

    #cloning
    echo_y "Cloning..."
    cd $HOME/.beget/tmp
    git clone https://github.com/danielwaterworth/siege.git
    if [ ! -d "$HOME/.beget/tmp/siege" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi

    #compilation
    echo_y "Compilating..."
    cd siege
    PATH=$PATH:~/.local/opt/ghc-8.0.2-x86_64/bin
    cabal configure --prefix=$HOME/.local
    cabal build

    #finish
    echo_g "Siege installed"
}
