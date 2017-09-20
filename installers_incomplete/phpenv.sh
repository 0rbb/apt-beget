#Check out phpenv into $HOME/.phpenv.
cd ~
git clone git://github.com/phpenv/phpenv.git .phpenv

#Add $HOME/.phpenv/bin to your $PATH for access to the phpenv command-line utility.
echo 'export PATH="$HOME/.phpenv/bin:$PATH"' >> $HOME/.bash_profile

#Add phpenv init to your shell to enable shims and autocompletion.
echo 'eval "$(phpenv init -)"' >> $HOME/.bash_profile

#Restart your shell so the path changes take effect. You can now begin using phpenv.
source $HOME/.bash_profile

#Rebuild the shim binaries. You should do this any time you install a new PHP binary.
phpenv rehash

#You can list the available PHP releases by running:
phpenv install --releases

#To build one of the listed releases run:
phpenv install --deep-clean php-5.5.30

PHP_BUILD_DEBUG=yes PHP_BUILD_ZTS_ENABLE=on PHP_BUILD_INSTALL_EXTENSION="pthreads=@" phpenv install --deep-clean php-5.5.30

curl -L http://git.io/phpenv-installer | bash