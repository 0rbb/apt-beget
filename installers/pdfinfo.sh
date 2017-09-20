function install_pdfinfo {
    echo_y "Installing pdfinfo..."
    prepare_folders
    cd $HOME/.beget/tmp

    echo_y "Downloading tarball"
    wget ftp://ftp.foolabs.com/pub/xpdf/xpdfbin-linux-3.04.tar.gz -O $HOME/.beget/tmp/xpdfbin-linux-3.04.tar.gz
    if [ ! -f "$HOME/.beget/tmp/xpdfbin-linux-3.04.tar.gz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    echo_y "Unpacking tarball"
    tar xvf xpdfbin-linux-3.04.tar.gz
    if [ ! -d "$HOME/.beget/tmp/xpdfbin-linux-3.04" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    mv $HOME/.beget/tmp/xpdfbin-linux-3.04 $HOME/.local/opt/
    for f in $HOME/.local/opt/xpdfbin-linux-3.04/bin64/*; do ln -sf $f $HOME/.local/bin/$(basename $f); done

    echo_g "pdfinfo installed"
}
