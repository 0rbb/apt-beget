:<<=
==PhantomJS
===PhantomJS is a headless WebKit scriptable with a JavaScript API.
===http://phantomjs.org/
=
function install_phantomjs {
    echo_y "Installing default..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders
    
    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 > phantomjs-2.1.1-linux-x86_64.tar.bz2
    if [ ! -f "$HOME/.beget/tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar xvf phantomjs-2.1.1-linux-x86_64.tar.bz2
    if [ ! -d "$HOME/.beget/tmp/phantomjs-2.1.1-linux-x86_64" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #install
    echo_y "Installing..."
    mv $HOME/.beget/tmp/phantomjs-2.1.1-linux-x86_64 $HOME/.local/opt/
    ln -sf $HOME/.local/opt/phantomjs-2.1.1-linux-x86_64/bin/phantomjs $HOME/.local/bin/phantomjs
    phantomjs -h

    #finish
    echo_g "PhantomJS installed"
}
