:<<=
==coproject
===NOT AN INSTALLER, JUST STUB TO CREATE INSTALLER
=
function install_coproject {
    check_ds
    echo_y "Installing coproject..."

    #depencies
    echo_y "Satisfaying depencies..."
    install_composer

    #install
    echo_y "Installing..."
    cd $HOME
    rm -rf public_html
    echo_y "Creating project..."
    composer -s stable create-project vendor/public_html public_html

    #finish
    echo_g "coproject installed"
}
