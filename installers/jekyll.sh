:<<=
==Jekyll
=
function install_jekyll {
    check_ds
    echo_y "Installing Jekyll..."

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
    gem install jekyll bundler
    echo "gem 'execjs'" >> $HOME/Gemfile
    echo "gem 'therubyracer'" >> $HOME/Gemfile
    bundle install

    jekyll new source
    jekyll build --source ~/source/ --destination ~/public_html/
    echo 'jekyll build --source ~/source/ --destination ~/public_html/' > ~/build.sh

    main_acc=$(ruby -e 'print `whoami`.gsub(/__[a-z0-9_]+$/, "")')
    echo "ssh $main_acc@localhost -p 222 /opt/rubies/2.3/bin/ruby \$@" > ~/.local/bin/ruby
    chmod +x ~/.local/bin/ruby
    ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa
    ssh-copy-id -i ~/.ssh/id_rsa.pub "$main_acc@localhost -p 222"

    #finish
    echo_g "Jekyll installed"
}
