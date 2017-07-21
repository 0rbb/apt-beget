:<<=
==asciidoc
=
function install_asciidoc {
    check_d
    echo_y "Installing asciidoc..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders
    
    #depencies
    echo_y "Satisfaying depencies..."
    install_libxml2
    install_libxslt

    #cloning
    echo_y "Cloning..."
    cd $HOME/.beget/tmp
    git clone https://github.com/asciidoc/asciidoc.git
    if [ ! -d "$HOME/.beget/tmp/asciidoc" ]
    then
        echo_r "Seems like cloning is failed"
        exit 1
    fi
    
    #compilation
    echo_y "Compilating..."
    cd asciidoc
    autoconf
    ./configure --prefix=$HOME/.local
    sed -i 's/\-\-nonet\s\-\-noout/\-\-noout/g' ./a2x.py
    make
    make install
    if [ ! -f "$HOME/.local/bin/asciidoc" ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #finish
    echo_g "default installed"
}
