function install_magento_ce {
    check_ds
    cd $HOME
    echo_y "Installing Magento Community Edition"
    rm -rf public_html
    install_composer
    echo '
{
    "http-basic": {
        "repo.magento.com": {
            "username": "64340d061f552490037f32bca3312fe9",
            "password": "f10a4560fe116e464496e77f56b4e2f3"
        }
    }
}' > $HOME/.composer/auth.json
    composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition public_html
    curl -Lk 'http://api.beget.ru/api/domain/changePhpVersion?login=ford153&passwd=password&full_fqdn=1.ce.2.magento.ford153.bget.ru&php_version=5.6&is_cgi=0&output_format=json'
    curl -Lk 'http://api.beget.ru/api/domain/addDirectives?login=ford153&passwd=password&input_format=json&output_format=json&input_data={"full_fqdn":"1.ce.2.magento.ford153.bget.ru","directives_list":[{"name":"php_admin_value","value":"always_populate_raw_post_data -1"}]}'

    echo_g "Files downloaded, now go to site and launch installation"
}

function install_magento_ee {
    check_ds
    cd $HOME
    echo_y "Installing Magento Enterprise Edition"
    echo_y "\n\nUse 64340d061f552490037f32bca3312fe9 for login and f10a4560fe116e464496e77f56b4e2f3 for password" # via https://marketplace.magento.com # login - support@beget.ru # password - BeGet120686
    rm -rf public_html
    install_composer
    composer create-project --repository-url=https://repo.magento.com/ magento/project-enterprise-edition public_html
    echo_g "Files downloaded, now go to site and launch installation"
}
