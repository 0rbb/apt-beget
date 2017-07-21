function install_opencart {
    check_ds
    cd ~
    git clone https://github.com/opencart/opencart.git
    if [ -d "$HOME/opencart/upload" ]
    then
        rm -rf public_html
        ln -sf opencart/upload public_html
        mv $HOME/public_html/config-dist.php $HOME/public_html/config.php
        mv $HOME/public_html/admin/config-dist.php $HOME/public_html/admin/config.php
        echo_g "Opencart installed"
    else
        echo_r "Seems like cloning is failed"
        exit 1
    fi

}

function install_opencart1 {
    curl -Lk https://codeload.github.com/opencart/opencart/zip/1.5.6.4 > opencart-1.5.6.4.zip
    rm -rf public_html/
    unzip opencart-1.5.6.4.zip 
    mv opencart-1.5.6.4 opencart
    ln -sf opencart/upload public_html
    mv $HOME/public_html/config-dist.php $HOME/public_html/config.php
    mv $HOME/public_html/admin/config-dist.php $HOME/public_html/admin/config.php
    echo_g "Opencart installed"
}
