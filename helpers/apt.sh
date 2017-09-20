function apt_localinstall {
    check_d

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    mkdir -p $HOME/.beget/tmp/dpkg
    cd $HOME/.beget/tmp/dpkg

    #download
    echo_y "Downloading..."
    apt-get --print-uris --yes -d --reinstall install $1 | grep ^\'http:\/\/ | awk '{print $1}'| xargs wget

    #install
    echo_y "Installing..."
    for deb in `find . -name '*.deb'`
    do
        echo $deb
        dpkg -x $deb $HOME/.beget/tmp/dpkg
    done
    
    echo_y "Setting up..."
    rsync -a $HOME/.beget/tmp/dpkg/usr/ $HOME/.local/
    echo 'LD_LIBRARY_PATH=~/.local/lib/' >> $HOME/.bashrc
}