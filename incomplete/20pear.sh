#unfinished
function install_pear {
    mkdir -p $HOME/.local/opt/pear/
    cd $HOME/.beget/tmp
    wget http://pear.php.net/go-pear.phar
    if [ -f "$HOME/.beget/tmp/go-pear.phar" ]
    then
        /usr/local/php-cgi/5.6/bin/php go-pear.phar
        echo 'PATH=$PATH:/usr/local/php-cgi/5.6/bin' > $HOME/.local/bin/pear
        echo '$HOME/pear/bin/pear $@' >> $HOME/.local/bin/pear
        chmod +x $HOME/.local/bin/pear
    else
        exit 1
    fi
}
