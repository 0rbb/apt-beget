function install_libsmbclient {
    check_ds
    prepare_folders
    
    cd $HOME/.beget/tmp
    
    apt-get --print-uris --yes install libsmbclient-dev | grep ^\' | cut -d\' -f2 | xargs wget
    find . -name '*.deb' -exec ar vx {} \; && tar -xvf data* -C $HOME/.local/
    
    git clone git://github.com/eduardok/libsmbclient-php.git
    cd libsmbclient-php
    /usr/local/php-cgi/5.6/bin/phpize
    sed -i "s/for i in \/usr\/local\/include/for i in ~\/.local\/usr\/include \/usr\/local\/include/g" ./configure

    
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.local/usr/lib/x86_64-linux-gnu/
    export LIBRARY_PATH=$LIBRARY_PATH:$HOME/.local/usr/lib/x86_64-linux-gnu/      
    LD_LIBRARY_PATH=$HOME/.local/usr/lib/x86_64-linux-gnu/ ./configure --with-php-config=/usr/local/php-cgi/5.6/bin/php-config
    make -j $(expr $(nproc) / 4)
    make install INSTALL_ROOT=$HOME/.local
    printf "\n\n[PHP]\nextension = `find $HOME -name 'smbclient.so'|grep cgi|head -n 1`" >> $HOME/public_html/cgi-bin/php.ini
    printf "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.local/usr/lib/x86_64-linux-gnu/\nexport LIBRARY_PATH=$LIBRARY_PATH:$HOME/.local/usr/lib/x86_64-linux-gnu/" >> $HOME/.profile
}
