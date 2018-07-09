shopt -s dotglob
cd $HOME
rm -rf *
composer-php7.1 create-project symfony/website-skeleton tmp
mv tmp/* .
ln -s public public_html
rm -rf tmp/
