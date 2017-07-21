:<<=
==pngout
===https://ru.wikipedia.org/wiki/PNGOUT
===http://advsys.net/ken/utils.htm
===http://www.jonof.id.au/kenutils
=
function install_pngout {
    check_d
    echo_y "Installing pngout..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders
  
    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk http://static.jonof.id.au/dl/kenutils/pngout-20150319-linux-static.tar.gz > pngout-20150319-linux-static.tar.gz
    if [ ! -f "$HOME/.beget/tmp/pngout-20150319-linux-static.tar.gz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar -xvf pngout-20150319-linux-static.tar.gz
    if [ ! -d "$HOME/.beget/tmp/pngout-20150319-linux-static" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #install
    echo_y "Installing..."
    mv pngout-20150319-linux-static $HOME/.local/opt/
    ln $HOME/.local/opt/pngout-20150319-linux-static/x86_64/pngout-static $HOME/.local/bin/pngout

    #finish
    echo_g "pngout installed"
}
