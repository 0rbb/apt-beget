:<<=
==Drupal 7
===https://www.drupal.org/
=
function install_drupal_7 {
    check_s
    echo_y "Installing Drupal 7..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_drush_7
    PATH=$PATH:/usr/local/php-cgi/5.6/bin

    #install
    echo_y "Installing..."
    cd ~
    folder_name=${PWD##*/}
    echo_y "Creating project..."
    drush dl drupal --drupal-project-rename='public_html'
    echo_y "Setting up..."
    cd public_html
    #drush site-install standard --locale=ru --db-url='sqlite://../db.sqlite' --site-name="$folder_name" --account-name=`whoami` --account-pass=fordfocus

    #finish
    echo_g "Drupal 8 installed"
}

:<<=
==Drupal 8
===https://www.drupal.org/
=
function install_drupal_8 {
    check_s
    echo_y "Installing Drupal 8..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_drush_8
    PATH=$PATH:/usr/local/php-cgi/5.6/bin

    #install
    echo_y "Installing..."
    cd ~
    folder_name=${PWD##*/}
    echo_y "Creating project..."
    drush dl drupal --drupal-project-rename='public_html'
    echo_y "Setting up..."
    cd public_html
    #drush site-install standard --locale=ru --db-url='sqlite://../db.sqlite' --site-name="$folder_name" --account-name=`whoami` --account-pass=fordfocus

    #finish
    echo_g "Drupal 8 installed"
}
