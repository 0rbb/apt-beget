:<<=
==Yii
===http://www.yiiframework.com/
=
function install_yii {
    check_ds
    echo_y "Installing Yii..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_composer
    install_nodejs

    #install
    echo_y "Installing..."
    cd ~
    composer global require "fxp/composer-asset-plugin:^1.2.0"
    echo_y "Creating project..."
    rm -rf _yii_tmp
    composer create-project -s stable yiisoft/yii2-app-basic _yii_tmp
    shopt -s dotglob
    mv _yii_tmp/* .   
    rm -rf _yii_tmp 

    rm -rf public_html
    ln -s web public_html

    #finish
    echo_g "Yii installed"
}
