:<<=
==drush
===http://www.drush.org/
=
function install_drush {
    echo_y "Installing drush..."
    if [ -z $1 ]
        then echo "Define the version"
        exit 1
    fi

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_composer

    #install
    echo_y "Installing..."
    echo_y "Version set to $1"
    composer global require "drush/drush:$1.x-dev"

    #finish
    echo_g "drush installed"
}
