cd .beget/tmp/
wget http://mirrors.kernel.org/ubuntu/pool/main/u/unixodbc/unixodbc-dev_2.2.14p2-5ubuntu3_amd64.deb
dpkg-deb -R unixodbc-dev_2.2.14p2-5ubuntu3_amd64.deb unixodbc-dev
pip install pyodbc --user --ignore-installed --quiet --global-option=build_ext --global-option="-I/home/i/inteftlh/.beget/tmp/unixodbc-dev/usr/include/" --global-option="-L/home/i/inteftlh/.beget/tmp/unixodbc-dev/usr/lib/" --global-option="-L/home/i/inteftlh/.local/lib/"
