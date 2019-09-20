#!/usr/bin/python3.7
import os
import getpass
import sys
from pip import main as pipmain
import subprocess
import re
import tempfile
from urllib.parse import urlparse
import wget
import apt_inst

class Helpers():
    @staticmethod
    def prepare_folders() -> None:
        """
        create common folders that we are will store temporary files and end result
        """
        Helpers.Print.warning('Preparing folders...')
        os.removedirs(os.path.expanduser("~/.beget/tmp"))

        for path in ["~/.beget/tmp", "~/.local/opt", "~/.local/bin"]:
            os.makedirs(os.path.expanduser(path), 0o700, True)

        os.chdir(os.path.expanduser("~/.beget/tmp"))
    
    class CheckEnvironment():
        @staticmethod
        def is_docker() -> bool:
            with open("/proc/self/cgroup",'r') as fin:
                for line in fin:
                    if (line.find('cpuset') > -1 and line.find('docker') > -1):
                        return True
            
            print("Please launch this script in Docker")
            sys.exit(1)
        
        @staticmethod
        def is_site_user() -> bool:
            if (getpass.getuser().find('_') > -1):
                return True
            else:
                print("Please launch this script as Site User")
                sys.exit(1)
    
    class Print():
        @staticmethod
        def error(message: str) -> None:
            print('\x1b[1m\x1b[48;5;1m ' + message + ' \x1b[0m')
        @staticmethod
        def success(message: str) -> None:
            print('\x1b[1m\x1b[48;5;28m ' + message + ' \x1b[0m')
        @staticmethod
        def warning(message: str) -> None:
            print('\x1b[1m\x1b[48;5;11m\x1b[30m ' + message + ' \x1b[0m')
    
    class Apt():
        @staticmethod
        def local_install(package_name):
            Helpers.prepare_folders()
            pipmain(['install', 'setuptools'])
            pipmain(['install', 'wget'])
            tmp_folder_4_downloads = tempfile.mkdtemp()
            tmp_folder_4_extracted = tempfile.mkdtemp()
            apt_output = subprocess.check_output('apt-get --print-uris --yes -d --reinstall --no-install-recommends install '+package_name, shell=True)
            package_links = re.findall(r'http:\/\/[\w\d\.\-\/]+\.deb', str(apt_output))
            for link in package_links:
                print(f"Getting {link}...")
                package_filename = os.path.basename(urlparse(link).path)
                target_path = os.path.join(tmp_folder_4_downloads, package_filename)
                wget.download(link, target_path)
                apt_inst.deb_extract_archive(target_path, tmp_folder_4_extracted)
    
    class Pecl():
        @staticmethod
        def install(ext_name: str, php_version: str) -> None:
            wget.download(f"https://pecl.php.net/get/{ext_name}", f"/tmp/{ext_name}.tgz")
            
class Installers():
    @staticmethod
    def cwebp():
        Helpers.prepare_folders()

def main():
    # Helpers.CheckEnvironment.is_docker()

    Helpers.Print.error('Ford Focus')
    Helpers.Print.success('Ford Focus')
    Helpers.Print.warning('Ford Focus')

if __name__ == '__main__':
    main()
