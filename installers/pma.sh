:<<=
==phpMyAdmin
===https://phpmyadmin.net/
=
function install_pma {
    check_ds
    echo_y "Installing phpMyAdmin..."

    #depencies
    echo_y "Satisfaying depencies..."
    install_composer

    #install
    echo_y "Installing..."
    cd $HOME
    rm -rf public_html
    echo_y "Creating project..."
    composer -s stable create-project phpmyadmin/phpmyadmin public_html

    #finish
    echo_g "phpMyAdmin installed"
}