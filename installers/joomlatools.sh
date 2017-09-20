:<<=
==analog of wp-cli for Joomla
==https://github.com/joomlatools/joomlatools-console
=
function install_joomlatools {
    echo_y "Installing joomlatools..."

    #prepare folders
    prepare_folders

    #depencies
    install_composer

    #download
    composer global require joomlatools/console

    #install
    printf "\n\nPATH=$PATH:~/.composer/vendor/bin\n" >> $HOME/.bashrc
    source $HOME/.bashrc
    echo_y 'Now execute `source $HOME/.bashrc`'

    echo_g "joomlatools installed"
}
