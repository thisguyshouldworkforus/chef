# Chef

[![logo](https://github.com/chef/chef/blob/main/omnibus/resources/chef/pkg/background.png)](https://chef.io/)  

### A repository to hold Chef recipes I've written over the years, for various needs.

## License

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)

## ClamAV Install

[![ ](https://img.shields.io/badge/Minimally%20Compatible-Chef%20v12-blue)](https://chef.io)

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

