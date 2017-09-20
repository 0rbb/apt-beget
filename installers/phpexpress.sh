function install_phpexpress {
    echo_y "Installing PhpExpress 3.1"
    prepare_folders
    cd $HOME/.beget/tmp
    
    curl -Lk http://download.nusphere.com/customer/download/files/NuSphere-PhpExpress-3.1.zip > $HOME/.beget/tmp/NuSphere-PhpExpress-3.1.zip
    if [ ! -f "$HOME/.beget/tmp/NuSphere-PhpExpress-3.1.zip" ]
    then
        echo_r 'download is failed'
        exit 1
    fi
    unzip NuSphere-PhpExpress-3.1.zip
    tar -xvf NuSphere-PhpExpress/phpexpress-3.1-Linux.tar.gz
    
    mkdir -p $HOME/.local/lib/php/53/
    cp $HOME/.beget/tmp/phpexpress-3.1-Linux/x86_64/phpexpress-php-5.3.so $HOME/.local/lib/php/53/phpexpress-php-5.3.so
    
    printf "\n\n[PHP]\nextension = $HOME/.local/lib/php/53/phpexpress-php-5.3.so" >> $HOME/public_html/cgi-bin/php.ini
    
    echo_g "PhpExpress installed"
    echo_y "Don't forget to switch php version to PHP 5.3 CGI!"
}