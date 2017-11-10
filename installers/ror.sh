:<<=
==Ruby On Rails
=
function install_ror {
    check_ds
    echo_y "Installing Ruby On Rails..."

    #prepare folders
    echo_y "Preparing folders..."
    prepare_folders

    #depencies
    echo_y "Satisfaying depencies..."
    install_nodejs

    #install
    echo_y "Installing..."
    chruby ruby-2.3
    echo '2.3' > $HOME/.ruby-version
    cd $HOME
    gem install rails --no-rdoc --no-ri
    gem install rb-readline --no-rdoc --no-ri
    rails new .
    ln -sf public public_html
    echo "gem 'rb-readline'
gem 'execjs'
gem 'therubyracer'" >> $HOME/Gemfile
    bundle install

    echo_y "Setting up..."
    echo "RailsEnv development
PassengerUploadBufferDir `pwd`/tmp
PassengerRuby /opt/rubies/ruby-2.3/bin/ruby
PassengerAppRoot `pwd`
SetEnv GEM_HOME $HOME/.gem/ruby/2.3.1/:/opt/rubies/ruby-2.3/lib/ruby/gems/2.3.0/" >> $HOME/.htaccess
    echo "ENV['GEM_HOME'] = '$HOME/.gem/ruby/2.3.1/'
ENV['GEM_PATH'] = '$HOME/.gem/ruby/2.3.1/'
require 'bundler/setup'" >> $HOME/config/setup_load_paths.rb
    mkdir $HOME/tmp
    touch $HOME/tmp/restart.txt

    main_acc=$(ruby -e 'print `whoami`.gsub(/__[a-z0-9_]+$/, "")')
    echo "ssh $main_acc@localhost -p 222 /opt/rubies/2.3/bin/ruby \$@" > ~/.local/bin/ruby
    chmod +x ~/.local/bin/ruby
    ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa
    ssh-copy-id -i ~/.ssh/id_rsa.pub "$main_acc@localhost -p 222"

    #finish
    echo_g "Ruby On Rails installed"
}
