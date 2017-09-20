:<<=
==drush
===http://www.drush.org/
=
function install_drush {
    echo_y "Installing drush..."

    #collecting install information
    echo_y "Choose the version..."
    composer show -a "drush/drush" | grep versions
    read drush_version
    if [[ ! $drush_version ]]
    then
        drush_version='dev-master'
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
    composer global require "drush/drush:$drush_version"

    #finish
    echo_g "drush installed"
}
