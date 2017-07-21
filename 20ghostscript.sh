function install_ghostscript {
    echo_y "Installing Ghostscript..."

    prepare_folders
    cd $HOME/.beget/tmp

    echo_y "Downloading tarball"
    curl -Lk https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs919/ghostscript-9.19-linux-x86_64.tgz > $HOME/.beget/tmp/ghostscript-9.19-linux-x86_64.tgz
    if [ ! -f "$HOME/.beget/tmp/ghostscript-9.19-linux-x86_64.tgz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    echo_y "Unpacking tarball"
    tar xvf ghostscript-9.19-linux-x86_64.tgz
    if [ ! -d "$HOME/.beget/tmp/ghostscript-9.19-linux-x86_64" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    mv $HOME/.beget/tmp/ghostscript-9.19-linux-x86_64 $HOME/.local/opt/
    ln -sf $HOME/.local/opt/ghostscript-9.19-linux-x86_64/gs-919-linux_x86_64 $HOME/.local/bin/ghostscript
    ln -sf $HOME/.local/opt/ghostscript-9.19-linux-x86_64/gs-919-linux_x86_64 $HOME/.local/bin/gs
    echo_g "Ghostscript installed"
}
