echo '#!/usr/bin/env bash' > apt-beget.sh

for package_name in `find . -regex '\.\/[1-2]0\w*\.sh' | sort`
do
	cat $package_name >> apt-beget.sh
    printf "\n\n" >> apt-beget.sh
done 

cat 30launcher.sh >> apt-beget.sh