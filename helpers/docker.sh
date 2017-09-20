function check_d {
    if [ `cat /proc/self/cgroup | grep cpuset | grep docker -c` -ne 1 ]
    then
         echo_r "Please launch this script in docker"
         exit 1
    fi
}

function check_s {
    if [ `whoami | grep _ -c` == 0 ]
    then
        echo_r "Please launch this script in siteuser"
        exit 1
    fi
}

function check_ds {
    check_d
    check_s
}
