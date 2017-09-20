#not working without postgresql
function install_mayak {
    install_ror
    git clone https://github.com/dymio/mayak.git
    cp -pRP  mayak/* .
#    rm -rf mayak/
    echo "gem 'sqlite3'" >> $HOME/Gemfile
    bundle install
    $HOME/bin/rake db:create db:migrate
    bin/rake db:migrate RAILS_ENV=development
    touch $HOME/tmp/restart.txt
}
