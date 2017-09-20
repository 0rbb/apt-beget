:<<=
==Haskell Platform
===NOT AN INSTALLER, JUST STUB TO CREATE INSTALLER
=
function install_haskell {
#    check_ds
    echo_y "Installing Haskell Platform..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."

    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk https://haskell.org/platform/download/8.0.2/haskell-platform-8.0.2-unknown-posix--minimal-x86_64.tar.gz > haskell.tar.gz
    if [ ! -f "$HOME/.beget/tmp/haskell.tar.gz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar xvf haskell.tar.gz
    if [ ! -f "$HOME/.beget/tmp/install-haskell-platform.sh" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi
    tar xvf hp-usr-local.tar.gz
    if [ ! -d "$HOME/.beget/tmp/usr" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #install
    echo_y "Installing..."
    mv $HOME/.beget/tmp/usr/local/haskell/ghc-8.0.2-x86_64 $HOME/.local/opt/
    ln -sf $HOME/.local/opt/ghc-8.0.2-x86_64/bin/cabal $HOME/.local/bin/cabal
    ln -sf $HOME/.local/opt/ghc-8.0.2-x86_64/bin/ghc $HOME/.local/bin/ghc

    #finish
    echo_g "Haskell Platform installed"
}
