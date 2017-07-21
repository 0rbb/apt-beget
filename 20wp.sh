:<<=
==WP CLI
===http://wp-cli.org/
=
function install_wpcli {
    echo_y "Installing WP CLI..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_composer
    
    #download
    echo_y "Downloading..."
    mkdir $HOME/.local/opt/wpcli/
    cd $HOME/.local/opt/wpcli/
    curl -Lk https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > wp-cli.phar
    curl -Lk https://github.com/wp-cli/wp-cli/raw/master/utils/wp-completion.bash > wp-completion.bash
    if [ ! -f "$HOME/.local/opt/wpcli/wp-cli.phar" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi
    if [ ! -f "$HOME/.local/opt/wpcli/wp-completion.bash" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #install
    echo_y "Installing..."
    echo "/usr/local/php-cgi/5.6/bin/php $HOME/.local/opt/wpcli/wp-cli.phar \$@" > $HOME/.local/bin/wp
    chmod +x $HOME/.local/bin/wp
    printf "\n\nsource $HOME/.local/opt/wpcli/wp-completion.bash" >> $HOME/.bash_profile

    #finish
    echo_g "WP CLI installed"
}

:<<=
==wordpress
=
function install_wp {
    check_ds
    echo_y "Installing wp..."

    #depencies
    echo_y "Satisfaying depencies..."
    install_wpcli

    #install
    echo_y "Installing..."
    cd $HOME/public_html
    wp core install

    #finish
    echo_g "wp installed"
}
