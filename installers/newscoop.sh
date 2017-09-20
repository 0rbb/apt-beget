:<<=
==newscoop
===Newscoop is the open content management system for professional journalists
===https://www.sourcefabric.org/en/newscoop/
===https://github.com/sourcefabric/Newscoop/
=
function install_newscoop {
    check_ds
    echo_y "Installing newscoop..."

    #depencies
    echo_y "Satisfaying depencies..."
    install_composer

    #install
    echo_y "Installing..."
    cd $HOME
    rm -rf public_html
    echo_y "Creating project..."
    composer create-project sourcefabric/newscoop ~/newscoop -s dev
    
    cd newscoop/newscoop/
    composer install
    
    #echo_y "ENTER DATABASE NAME"
    #read dname
    #echo_y "ENTER DATABASE PASSWORD"
    #read dpw
    #mkdir -p ~/newscoop/newscoop/cache/prod/annotations
    #chmod 777 ~/newscoop/newscoop/cache/prod/annotations
    #/usr/local/php-cgi/5.6/bin/php application/console newscoop:install --fix --database_name $dname --database_user $dname --database_password $dpw --database_override
    
    cd $HOME
    rm -rf public_html
    ln -s newscoop/newscoop public_html
    
    #finish
    echo_g "newscoop installed"
    echo_y "Just downloaded, go to site for manual install"
    echo_y "Install script does not asking you for administrator login. Is always 'admin'"
}