:<<=
==DRUPAL CONSOLE
===https://drupalconsole.com/
=
function install_drupalconsole {
    check_ds
    echo_y "Installing default..."

    #download
    echo_y "Downloading..."
    cd $HOME/.local/opt/
    curl -Lk https://drupalconsole.com/installer -o drupal.phar
    if [ ! -f "$HOME/.local/opt/drupal.phar" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #install
    echo_y "Installing..."
    echo "/usr/local/php-cgi/5.6/bin/php -dshort_open_tag=On -ddate.timezone='Europe/Moscow' $HOME/.local/opt/drupal.phar \$@" > $HOME/.local/bin/drupal
    chmod +x $HOME/.local/bin/drupal
    drupal self-update
    drupal

    #finish
    echo_g "default installed"
}
