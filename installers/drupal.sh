:<<=
==Drupal 7
===https://www.drupal.org/
=
function install_drupal_7 {
    check_s
    echo_y "Installing Drupal 7..."

    #collecting install information
    echo_y 'ENTER admin account mail (default is "admin@example.com")'
    read account_mail
    if [[ ! $account_mail ]]
    then
        account_mail=`whoami`
    fi

    echo_y 'ENTER admin account name (default is current account login)'
    read account_name
    if [[ ! $account_name ]]
    then
        account_name=`whoami`
    fi

    echo_y 'ENTER account pass (default is "fordfocus")'
    read account_pass
    if [[ ! $account_pass ]]
    then
        account_pass='fordfocus'
    fi

    echo_y 'ENTER database name (default is "root")'
    read db_name
    if [[ ! $db_name ]]
    then
        db_name=`whoami`
    fi

    echo_y 'ENTER database pass (default is "fordfocus")'
    read db_pass
    if [[ ! $db_pass ]]
    then
        db_pass='fordfocus'
    fi

    echo_y 'ENTER site mail (for outgoing mail) (default is "admin@example.com")'
    read site_mail
    if [[ ! $site_mail ]]
    then
        site_mail='admin@example.com'
    fi

    echo_y 'ENTER site name (default is "My site")'
    read site_name
    if [[ ! $site_name ]]
    then
        site_name='My site'
    fi

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_drush 7.x-dev

    #install
    PATH=$PATH:/usr/local/php-cgi/5.6/bin
    PATH=$PATH:~/.composer/vendor/bin/

    echo_y "Installing..."
    cd $HOME
    folder_name=${PWD##*/}

    echo_y "Creating project..."
    rm -rf ~/public_html/
    drush dl drupal-7.x --drupal-project-rename='public_html'

    echo_y "Setting up..."
    cd public_html
    #drush site-install standard --locale=ru --db-url='sqlite://../db.sqlite' --site-name="$site_name" --account-name=`whoami` --account-pass=fordfocus
    drush site-install standard \
        --account-mail="$account_mail" --account-name="$account_name" --account-pass="$account_pass" \
        --db-url="mysql://$db_name:$db_pass@localhost/$db_name" --locale=ru-RU \
        --site-mail="$site_mail" --site-name="$site_name"

    #finish
    echo_g "Drupal 7 installed"
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
    install_drush 8.x-dev
    PATH=$PATH:/usr/local/php-cgi/7.1/bin

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
