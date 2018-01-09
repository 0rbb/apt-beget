:<<=
==tideways
===NOT AN INSTALLER, JUST STUB TO CREATE INSTALLER
=
function install_tideways {
    check_ds
    echo_y "Installing tideways..."

    #collecting install information
    echo_y "ENTER PHP version (default is 5.6)"
    read php_ver
    if [[ ! $php_ver ]]
    then
        echo_r "PHP version required"
        exit 1
    fi

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    wget -O tideways-php.tar.gz "https://s3-eu-west-1.amazonaws.com/tideways/extension/4.1.4/tideways-php-4.1.4-x86_64.tar.gz"
    if [ ! -f "$HOME/.beget/tmp/tideways-php.tar.gz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar xvf tideways-php.tar.gz
    if [ ! -d "$HOME/.beget/tmp/tideways-php" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #install
    echo_y "Installing..."
    cd tideways-php-4.1.4
    bash install.sh
    cat ~/.beget/tmp/tideways-php-4.1.4/tideways.ini > ~/public_html/cgi-bin/php.ini
    cp -vf ~/.beget/tmp/tideways-php-4.1.4/tideways-php-$php_ver.so  ~/public_html/cgi-bin/
    export lib_path="$(cd ~ && pwd)/public_html/cgi-bin/tideways-php-$php_ver.so"
    /opt/ruby/2.3/bin/ruby -e 'z=ENV["HOME"]+"/public_html/cgi-bin/php.ini"; a=File.open(z, "rb"); b=a.read; c=b.sub("extension=tideways.so","extension="+ENV["lib_path"]); File.write(z, c)'


    #finish
    echo_g "tideways installed"
}
