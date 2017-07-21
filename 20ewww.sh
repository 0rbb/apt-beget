:<<=
==EWWW utils and patch
===https://wordpress.org/plugins/ewww-image-optimizer/
=
function install_ewww {
    check_ds
    echo_y "Installing EWWW utils and patch..."

    #depencies
    echo_y "Satisfaying depencies..."
    install_jpegtran
    install_optipng
    install_pngout #optional dep
    install_gifsicle
    install_cwebp

    #install
    echo_y "Setting up..."
    cp $HOME/public_html/wp-content/plugins/ewww-image-optimizer/unique.php $HOME/public_html/wp-content/plugins/ewww-image-optimizer/unique.php.bak

    ##turn off updater
    str=$(grep -n 'function ewww_image_optimizer_install_tools() {' $HOME/public_html/wp-content/plugins/ewww-image-optimizer/unique.php | /usr/local/php-cgi/5.6/bin/php -r '$t1=trim(fgets(STDIN));$t2=explode(":",$t1);$t3=$t2[0];$t4=(int)$t3+1;echo($t4);')
    sed -i $str'i\        return false;\' $HOME/public_html/wp-content/plugins/ewww-image-optimizer/unique.php

    ##put `~/.local/bin` instead of all
    str=$(grep -n 'ewww_image_optimizer_tool_found( $binary, $switch )' $HOME/public_html/wp-content/plugins/ewww-image-optimizer/unique.php | /usr/local/php-cgi/5.6/bin/php -r '$t1=trim(fgets(STDIN));$t2=explode(":",$t1);$t3=$t2[0];echo($t3);')
    sed -i $str'i\        return $_SERVER["DOCUMENT_ROOT"]."/../.local/bin/".$binary;\' $HOME/public_html/wp-content/plugins/ewww-image-optimizer/unique.php

    ln -sf $HOME/.local/bin/pngout $HOME/.local/bin/pngout-static #wp-content/plugins/ewww-image-optimizer/unique.php:785

    #finish
    echo_g "EWWW utils and patch installed"
}
