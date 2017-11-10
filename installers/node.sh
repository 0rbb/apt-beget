:<<=
==nodejs
===https://nodejs.org/
===https://github.com/nodejs/node/
=
function install_nodejs {
    #depencies
    echo_y "Satisfaying depencies..."
    install_nodejs_lts
}

:<<=
==nodejs 0.12
===https://nodejs.org/
===https://github.com/nodejs/node/
=
function install_nodejs012 {
    check_d
    echo_y "Installing nodejs 0.12..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #download
    echo_y "Downloading..."
    cd $HOME/.beget/tmp
    curl -Lk https://nodejs.org/dist/v0.12.7/node-v0.12.7.tar.gz > $HOME/.beget/tmp/node-v0.12.7.tar.gz
    if [ ! -f "$HOME/.beget/tmp/node-v0.12.7.tar.gz" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    cd $HOME/.beget/tmp
    tar xvf node-v0.12.7.tar.gz
    if [ ! -d "$HOME/.beget/tmp/node-v0.12.7" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #compilation
    echo_y "Compilating..."
    cd $HOME/.beget/tmp/node-v0.12.7
    ./configure --dest-os=linux --prefix=$HOME/.local
    make -j $(expr $(nproc) / 21)
    make install
    if [ ! -f "$HOME/.local/bin/node" ]
    then
        echo_r 'seems like compilation is failed'
        exit 1
    fi

    #install
    echo_y "Setting up..."
    nodejs_npm

    #finish
    echo_g "Node.JS 0.12 installed"
}

:<<=
==nodejs (latest lts)
===https://nodejs.org/
===https://github.com/nodejs/node/
=
function install_nodejs_lts {
    echo_y "Installing Node.js LTS..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #download
    echo_y "Downloading..."

    url=`/usr/local/php-cgi/5.6/bin/php -r '$a=file_get_contents("https://nodejs.org/dist/index.json");$a=json_decode($a, true);foreach($a as $b){if($b["lts"]!=false){echo("https://nodejs.org/dist/latest-".strtolower($b["lts"])."/node-".$b["version"]."-linux-x64.tar.gz"); break;}}'`
    filename="${url##*/}"
    extracted_dir_name="${filename%.*.*}"

    cd $HOME/.beget/tmp
    curl -Lk $url > $HOME/.beget/tmp/$filename
    if [ ! -f "$HOME/.beget/tmp/$filename" ]
    then
        echo_r "Seems like downloading is failed"
        exit 1
    fi

    #unpack
    echo_y "Unpacking..."
    tar xvf $filename
    if [ ! -d "$HOME/.beget/tmp/$extracted_dir_name" ]
    then
        echo_r "Seems like unpacking is failed"
        exit 1
    fi

    #install
    echo_y "Setting up..."
    mv $HOME/.beget/tmp/$extracted_dir_name $HOME/.local/opt/
    ln -sf $HOME/.local/opt/$extracted_dir_name/bin/node $HOME/.local/bin/node
    ln -sf $HOME/.local/opt/$extracted_dir_name/bin/npm $HOME/.local/bin/npm
    nodejs_npm

    #finish
    echo_g "Node.JS LTS installed"
}

function nodejs_npm {
    NPM_PACKAGES="$HOME/.local/npm-packages"
    mkdir -p "$NPM_PACKAGES"
    echo "prefix = $NPM_PACKAGES" > $HOME/.npmrc

    $HOME/.local/opt/$extracted_dir_name/lib/node_modules/npm/bin/npm-cli.js install npm@latest -g
    rm $HOME/.local/bin/npm
    ln -sf $HOME/.local/npm-packages/bin/npm $HOME/.local/bin/npm
    npm version
    npm install bower -g
    ln -sf $HOME/.local/npm-packages/bin/bower $HOME/.local/bin/bower
    bower --version
}

:<<=
==helloworld for Node.js
=
function install_nodejs_helloworld {
    check_ds
    echo_y "Installing Node.JS with hello-world..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_nodejs

    #install
    echo_y "Installing..."
    echo_y "Creating project..."
    cd $HOME

    mkdir -p $HOME/public
    rm -rf public_html
    ln -sf public public_html

    APPLICATION_PATH="$HOME/helloworld4nodejs/"
    mkdir $APPLICATION_PATH

    echo "PassengerNodejs $HOME/.local/bin/node
        PassengerAppRoot $APPLICATION_PATH
        PassengerAppType node
        PassengerStartupFile app.js" > $HOME/.htaccess

    echo "var http = require('http');
        var server = http.createServer(function(req, res) {
            res.writeHead(200, { 'Content-Type': 'text/plain' });
            res.end('Hello node.js!');
        });
        server.listen(3000);" > $APPLICATION_PATH/app.js

    mkdir -p $HOME/tmp
    touch $HOME/tmp/restart.txt

    #finish
    echo_g "hello-world installed"
}
