:<<=
==Ghost
===Something like wordpress, but built with node.js
===https://ghost.org/
=
function install_ghost {
    check_ds
    echo_y "Installing Ghost..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_nodejs_6_lts

    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -L https://ghost.org/zip/ghost-latest.zip -o ghost.zip
    if [ ! -f "$HOME/.beget/tmp/ghost.zip" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    mkdir $HOME/ghost
    unzip -uo ghost.zip -d $HOME/ghost
    if [ ! -d "$HOME/ghost" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #install
    echo_y "Installing..."
    echo "PassengerNodejs $HOME/.local/opt/node-v6.9.4-linux-x64/bin/node
PassengerAppRoot $HOME/ghost
PassengerAppType node
PassengerStartupFile app.js" > $HOME/.htaccess 
    cd $HOME/ghost
    npm install -g grunt-cli
    npm install --production
    npm start --production
    mkdir -p $HOME/tmp
    touch $HOME/tmp/restart.txt

    #finish
    echo_g "Ghost installed"
}
