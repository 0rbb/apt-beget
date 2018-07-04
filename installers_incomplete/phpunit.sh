cd ~/.local/bin/

wget -O phpunit https://phar.phpunit.de/phpunit-7.phar

echo 'PATH=/usr/local/php-cgi/7.1/bin/:$PATH /usr/local/php-cgi/7.1/bin/php -ddisplay_startup_errors=on -ddisplay_errors=on -dhtml_errors=on -dlog_errors=off -dignore_repeated_errors=off -dignore_repeated_source=off -dreport_memleaks=on -dtrack_errors=on -ddocref_root=0 -ddocref_ext=0 -derror_reporting=2047 ~/.local/opt/phpunit $@' > ~/.local/bin/phpunit

chmod +x ~/.local/bin/phpunit
chmod +x ~/.local/opt/phpunit

phpunit --version
