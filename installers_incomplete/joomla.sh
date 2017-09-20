:<<=
==WIP: Joomla CMS
==joomlatools trying create database and there is no option to use existing database. So it failing at this
=
function install_joomla {
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

    echo_g "joomlatools installed"
}
