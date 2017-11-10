:<<=
==Default
===NOT AN INSTALLER, JUST STUB TO CREATE INSTALLER
=
function install_default {
    check_ds
    echo_y "Installing default..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    apt_localinstall 'gawk g++ zlib1g-dev libyaml-dev libsqlite3-dev autoconf libgmp-dev libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev libgmp-dev libreadline6-dev libssl-dev libmysqlclient-dev'
    install_nodejs

    #install
    echo_y "Installing..."
    export LD_LIBRARY_PATH=~/.local/lib/:~/.local/lib/x86_64-linux-gnu
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable --ruby --rails

    echo 'source $HOME/.rvm/scripts/rvm' >> ~/.bashrc

    #finish
    echo_g "default installed"
}









