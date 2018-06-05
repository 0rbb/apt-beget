PHP_VERSION=7.0

mkdir -p ~/.beget/tmp
cd ~/.beget/tmp
git clone git://github.com/xdebug/xdebug.git
cd ~/.beget/tmp/xdebug/
PATH=$PATH:/usr/local/php-cgi/$PHP_VERSION/bin/
phpize
./configure --enable-xdebug
make
make install
mkdir -p ~/.local/lib/php$PHP_VERSION
cp ./.libs/xdebug.so ~/.local/lib/php$PHP_VERSION
