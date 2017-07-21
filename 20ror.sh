function install_ror {
    #curl -sSL https://rvm.io/mpapis.asc | gpg --import -
    #curl -sSL https://get.rvm.io | bash -s stable --ruby --gems=rails,rb-readline,execjs,therubyracer
    check_ds
    chruby ruby-2.2.2
    echo 2.2.2 > $HOME/.ruby-version
    cd $HOME
    ls -la | grep -v beget_install | awk '{print $9}'| xargs rm -rf # delete all exept myself
    gem install rails --no-rdoc --no-ri
    rails new .
    ln -sf public public_html
    echo "gem 'rb-readline'
    gem 'execjs'
    gem 'therubyracer'
    gem 'sqlite3'" >> $HOME/Gemfile
    bundle install
    echo "RailsEnv development
        PassengerUploadBufferDir `pwd`/tmp
        PassengerRuby /opt/rubies/ruby-2.2.2/bin/ruby
        PassengerAppRoot `pwd`
        SetEnv GEM_HOME $HOME/.gem/ruby/2.2.2/:/opt/rubies/ruby-2.2.2/lib/ruby/gems/2.2.0/" >> $HOME/.htaccess
    echo "ENV['GEM_HOME'] = '$HOME/.gem/ruby/2.2.2/'
ENV['GEM_PATH'] = '$HOME/.gem/ruby/2.2.2/'
require 'bundler/setup'" >> $HOME/config/setup_load_paths.rb
    mkdir $HOME/tmp
    touch $HOME/tmp/restart.txt
}
