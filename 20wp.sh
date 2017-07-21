:<<=
==WP CLI
===http://wp-cli.org/
=
function install_wpcli {
    echo_y "Installing WP CLI..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_composer
    
    #download
    echo_y "Downloading..."
    mkdir $HOME/.local/opt/wpcli/
    cd $HOME/.local/opt/wpcli/
    curl -Lk https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > wp-cli.phar
    curl -Lk https://github.com/wp-cli/wp-cli/raw/master/utils/wp-completion.bash > wp-completion.bash
    if [ ! -f "$HOME/.local/opt/wpcli/wp-cli.phar" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi
    if [ ! -f "$HOME/.local/opt/wpcli/wp-completion.bash" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #install
    echo_y "Installing..."
    echo "/usr/local/php-cgi/5.6/bin/php $HOME/.local/opt/wpcli/wp-cli.phar \$@" > $HOME/.local/bin/wp
    chmod +x $HOME/.local/bin/wp
    printf "\n\nsource $HOME/.local/opt/wpcli/wp-completion.bash" >> $HOME/.bash_profile

    #finish
    echo_g "WP CLI installed"
}

:<<=
==Wordpress
=
function install_wordpress {
    check_ds
    echo_y "Installing wordpress..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_wpcli
  
    #download
    echo_y "Downloading..."

    wp_dl_cmd='wp core download --path=. '

    echo "ENTER WORDPRESS LANGUAGE (default is ru_RU)"
    read wp_localization
    if [[ $wp_localization ]]
    then
        wp_dl_cmd="$wp_dl_cmd --locale=$wp_localization"
    else
        wp_dl_cmd="$wp_dl_cmd --locale=ru_RU"
    fi

    echo "ENTER WORDPRESS VERSION (default is latest)"
    read wp_version
    if [[ $wp_version ]]
    then
        wp_dl_cmd="$wp_dl_cmd --version=$wp_version"
    fi

    wp_dl_cmd="$wp_dl_cmd --force"

    cd $HOME/public_html
    eval $wp_dl_cmd

    #install
    echo_y "Setting up database..."
    echo "ENTER HOSTING ACCOUNT LOGIN"
    read account
    export account

    echo "ENTER HOSTING ACCOUNT PASSWORD"
    read password
    export password

    db_suffix=`/usr/local/php-cgi/5.6/bin/php -r '$p="";for($l=0;$l<5;$l++) {$p.=chr(rand(97,122));}echo $p;'` #there is no pwgen in docker
    export db_suffix

    db_password=`/usr/local/php-cgi/5.6/bin/php -r '$p="";for($l=0;$l<8;$l++) {$p.=chr(rand(97,122));}echo $p;'`
    export db_password

    admin_password=`/usr/local/php-cgi/5.6/bin/php -r '$p="";for($l=0;$l<8;$l++) {$p.=chr(rand(97,122));}echo $p;'`

    mkdb_url=`/usr/local/php-cgi/5.6/bin/php -r '$url="https://api.beget.ru/api/mysql/addDb?";

    $a=[];
    $a["login"]=getenv("account");
    $a["passwd"]=getenv("password");
    #$a["input_format"]="json";
    $a["input_format"]="json";
    $a["input_data"]=json_encode(["suffix"=>getenv("db_suffix"),"password"=>getenv("db_password")]);

    $url.=http_build_query($a);

    echo($url);'`


    curl -Lk $mkdb_url
    echo ''
    sleep 5 #database is not creating immediatelly, need to wait some seconds
    echo "wp core config --dbname=${account}_${db_suffix} --dbuser=${account}_${db_suffix} --dbpass=${db_password} --dbhost=localhost --dbcharset=utf8 --dbcollate=utf8_general_ci"

    wp core config --dbname=${account}_${db_suffix} --dbuser=${account}_${db_suffix} --dbpass=${db_password} --dbhost=localhost --dbcharset=utf8 --dbcollate=utf8_general_ci

    echo_y "Setting up wp..."
    echo "ENTER SITE URL"
    read siteurl
    export siteurl

    echo "ENTER ADMIN EMAIL"
    read admin_email
    export admin_email

    wp core install --url=${siteurl} --title='' --admin_user=${account} --admin_password=${admin_password} --admin_email=${admin_email}

    echo "${siteurl}/wp-login.php"
    echo $account
    echo $admin_password



    #finish
    echo_g "WordPress installed"
}
