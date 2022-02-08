# Chef

[![logo](https://github.com/chef/chef/blob/main/omnibus/resources/chef/pkg/background.png)](https://chef.io/)  

### A repository to hold Chef recipes I've written over the years, for various needs.

## License

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)

## ClamAV Remove
###### This recipe was written to resolve UID/GID conflicts

[![ ](https://img.shields.io/badge/Minimally%20Compatible-Chef%20v12-blue)](https://chef.io)

[clamav_remove.rb](clamav_remove.rb)

- This reciepe will:
  - Define a variable `clam_user` populated with two different values, depending on OS Version
  - Delete the `clam_user` USER, but only if:
    - The "$UID" of the `clam_user` is 286 or 300
    - The "$GID" of the `clam_user` is 299 or 995
  - Delete the `clam_user` GROUP, but only if:
    - The "$GID" of the `clam_user` is 299 or 995


## OSSEC Remove
###### This recipe was written to resolve UID/GID conflicts

[![ ](https://img.shields.io/badge/Minimally%20Compatible-Chef%20v12-blue)](https://chef.io)

[ossec_remove.rb](ossec_remove.rb)

- This reciepe will:
  - Delete System USER:
    - `ossece`, `ossecr`, `ossecm`, `ossec` - only if:
      - The "$UID" is 286 or 300
      - The "$GID" is 299 or 995
  - Delete System GROUP:
    - `ossec` - only if:
      - The "$GID" is 299 or 995


## Login Defs
###### This recipe was written to resolve UID/GID conflicts

[![ ](https://img.shields.io/badge/Minimally%20Compatible-Chef%20v12-blue)](https://chef.io)

[logindefs.rb](logindefs.rb)

- This reciepe will:
  - Set the `SYS_UID_MIN` to `401`
  - Set the `SYS_UID_MAX` to `899`
  - Set the `SYS_GID_MIN` to `401`
  - Set the `SYS_GID_MAX` to `899`


## ClamAV Install

[![ ](https://img.shields.io/badge/Minimally%20Compatible-Chef%20v12-blue)](https://chef.io)

[clamav_install.rb](clamav_install.rb)

- This reciepe will:
  - Define a variable `clam_user` populated with two different values, depending on OS Version
  - Create a User/Group named the dynamic value of `clam_user`
  - Create a ClamAV log directory (`/var/log/clamav`)
  - Initialize a ClamAV log file (`/var/log/clamav/clam.log`)
  - Create a ClamAV home directory (`/var/lib/clamav`)
    - When RedHat Enterprise Linux
      - Remove the existing application, if it is lesser than a predefined version number
      - Remove the existing configuration files `%w(freshclam.conf clamd.conf)`
      - Install the package version we desire
      - Determine the RedHat Capsule to use: `CAPSULE = grep -i 'hostname' /etc/rhsm/rhsm.conf | awk -F '=' '{print $2}' | tr -d '[:space:]'.freeze`
      - Build the Update Configuration File
    - When **NOT** RedHat Enterprise Linux
      - Install the package
      - Build the Update Configuration File
  - Create a [clam-scan.sh](https://github.com/thisguyshouldworkforus/bash/blob/master/clamav_scan.bash) file from an ERB Template
  - Setup a daily `cronjob` to run `ClamAV`


## OSSEC Install

[![ ](https://img.shields.io/badge/Minimally%20Compatible-Chef%20v12-blue)](https://chef.io)

[ossec_install.rb](ossec_install.rb)

- This reciepe will:
  - Create a system group `ossec`, not if the group `ossec` already exists (_Chef Guard_)
  - Create system users `%w(ossec ossecr ossecm ossece).each do |ossec_user|`
  - Setup 3rd party repos, only on CentOS
  - Install `GeoIP` as a dependency
  - Install the `ossec-hids-server` (_the ossec_server comes in with this as a dependency_)
  - Change the permissions on `/var/ossec` to `770`, only if the `ossec-hids-server` was installed properly
  - Change group on `/var/ossec` to `ossec`, only if the `ossec-hids-server` was installed properly
  - Lay down ossec configuration file
  - Lay down `.process_list`, `local_rules.xml`
  - Enable/Start `systemd` service


## Sysctl
###### This recipe was written to satisfy security concerns around Linux Hardening

[![ ](https://img.shields.io/badge/Minimally%20Compatible-Chef%20v12-blue)](https://chef.io)

[sysctl.rb](sysctl.rb)

- This reciepe will:
  - Remove IPv6 and Multicast Forwarding Entries (`"sed -ri '/ipv6|mc_forwarding/d' /etc/sysctl.conf"`)
  
- If `/proc/sys/net/ipv4/tcp_timestamps` **DOES NOT** exist, or **IS NOT WRITABLE** then remove `net.ipv4.tcp_timestamps` from `/etc/sysctl.conf`
- If `/proc/sys/net/ipv4/tcp_timestamps` **DOES** exist, and **IS WRITABLE** then remove `net.ipv4.tcp_timestamps` from `/etc/sysctl.conf`
- If `/proc/sys/net/ipv4/tcp_timestamps` **DOES** exist, and **IS WRITABLE** then add `net.ipv4.tcp_timestamps=0` to `/etc/sysctl.conf`

- If `/proc/sys/net/ipv4/conf/all/accept_source_route` **DOES NOT** exist, or **IS NOT WRITABLE** then remove `net.ipv4.conf.all.accept_source_route` from `/etc/sysctl.conf`
- If `/proc/sys/net/ipv4/conf/all/accept_source_route` **DOES** exist, and **IS WRITABLE** then remove `net.ipv4.conf.all.accept_source_route` from `/etc/sysctl.conf`
- If `/proc/sys/net/ipv4/conf/all/accept_source_route` **DOES** exist, and **IS WRITABLE** then add `net.ipv4.conf.all.accept_source_route=0` to `/etc/sysctl.conf`

- If `/proc/sys/net/ipv4/conf/all/forwarding` **DOES NOT** exist, or **IS NOT WRITABLE** then remove `net.ipv4.conf.all.forwarding` from `/etc/sysctl.conf`
- If `/proc/sys/net/ipv4/conf/all/forwarding` **DOES** exist, and **IS WRITABLE** then remove `net.ipv4.conf.all.forwarding` from `/etc/sysctl.conf`
- If `/proc/sys/net/ipv4/conf/all/forwarding` **DOES** exist, and **IS WRITABLE** then add `net.ipv4.conf.all.forwarding=0` to `/etc/sysctl.conf`

- If `/proc/sys/net/ipv4/conf/all/accept_redirects` **DOES NOT** exist, or **IS NOT WRITABLE** then remove `net.ipv4.conf.all.accept_redirects` from `/etc/sysctl.conf`
- If `/proc/sys/net/ipv4/conf/all/accept_redirects` **DOES** exist, and **IS WRITABLE** then remove `net.ipv4.conf.all.accept_redirects` from `/etc/sysctl.conf`
- If `/proc/sys/net/ipv4/conf/all/accept_redirects` **DOES** exist, and **IS WRITABLE** then add `net.ipv4.conf.all.accept_redirects=0` to `/etc/sysctl.conf`

- If `/proc/sys/net/ipv4/conf/all/secure_redirects` **DOES NOT** exist, or **IS NOT WRITABLE** then remove `net.ipv4.conf.all.secure_redirects` from `/etc/sysctl.conf`
- If `/proc/sys/net/ipv4/conf/all/secure_redirects` **DOES** exist, and **IS WRITABLE** then remove `net.ipv4.conf.all.secure_redirects` from `/etc/sysctl.conf`
- If `/proc/sys/net/ipv4/conf/all/secure_redirects` **DOES** exist, and **IS WRITABLE** then add `net.ipv4.conf.all.secure_redirects=0` to `/etc/sysctl.conf`

- If `/proc/sys/net/ipv4/conf/all/send_redirects` **DOES NOT** exist, or **IS NOT WRITABLE** then remove `net.ipv4.conf.all.send_redirects` from `/etc/sysctl.conf`
- If `/proc/sys/net/ipv4/conf/all/send_redirects` **DOES** exist, and **IS WRITABLE** then remove `net.ipv4.conf.all.send_redirects` from `/etc/sysctl.conf`
- If `/proc/sys/net/ipv4/conf/all/send_redirects` **DOES** exist, and **IS WRITABLE** then add `net.ipv4.conf.all.send_redirects=0` to `/etc/sysctl.conf`

- If `/proc/sys/net/ipv4/conf/default/send_redirects` **DOES NOT** exist, or **IS NOT WRITABLE** then remove `net.ipv4.conf.default.send_redirects` from `/etc/sysctl.conf`
- If `/proc/sys/net/ipv4/conf/default/send_redirects` **DOES** exist, and **IS WRITABLE** then remove `net.ipv4.conf.default.send_redirects` from `/etc/sysctl.conf`
- If `/proc/sys/net/ipv4/conf/default/send_redirects` **DOES** exist, and **IS WRITABLE** then add `net.ipv4.conf.default.send_redirects=0` to `/etc/sysctl.conf`

- Set VM Swappiness Globally (`"echo 'vm.swappiness=10' >> /etc/sysctl.conf"`), but not if `vm.swapiness` is already defined.

