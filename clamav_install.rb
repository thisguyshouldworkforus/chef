# --------------------------------------------------------------
# Date:
# November 10, 2020
# --------------------------------------------------------------

# Create the ClamAV User, if missing
clam_user = case node['platform_version'].to_i
            when 6
              'clam'
            else
              'clamupdate'
            end

case node['platform_version'].to_i
when 6
  group clam_user.to_s do
    system true
    action :create
    not_if "grep #{clam_user} /etc/group"
  end
  user clam_user.to_s do
    comment 'ClamAV Anti-Virus User Account'
    system true
    gid clam_user.to_s
    home '/var/lib/clamav'
    shell '/sbin/nologin'
    action :create
    not_if "grep #{clam_user} /etc/passwd"
  end
when 7..8
  group clam_user.to_s do
    system true
    action :create
    not_if "grep #{clam_user} /etc/group"
  end
  user clam_user.to_s do
    comment 'ClamAV Anti-Virus User Account'
    system true
    home '/var/lib/clamav'
    shell '/sbin/nologin'
    gid clam_user.to_s
    action :create
    not_if "grep #{clam_user} /etc/passwd"
  end
end

# Create Splunk group, for testing
group 'splunk' do
  gid 152
  action :create
  not_if "grep 'splunk' /etc/group"
end
user 'splunk' do
  uid 152
  gid 152
  action :create
  not_if "grep 'splunk' /etc/passwd"
end

# ClamAV Log Directory
directory '/var/log/clamav' do
  owner 'root'
  group 'splunk'
  mode '2740'
  action :create
  not_if '[[ -d /var/log/clamav ]]'
end

# ClamAV Log File
file '/var/log/clamav/clam.log' do
  owner 'root'
  group 'splunk'
  mode '0740'
  action :create
  not_if '[[ -f /var/log/clamav/clam.log ]]'
end

# ClamAV Home Directory
directory '/var/lib/clamav' do
  owner clam_user.to_s
  group clam_user.to_s
  mode '0750'
  action :create
end

# Remove the existing application
case node['platform'].to_s
when 'redhat'
  case node['platform_version'].to_i
  when 6
    package 'clamav' do
      action :remove
      not_if "[[ $(rpm -q clamav) = 'clamav-0.100.3-1.el6.x86_64' ]]"
    end
  when 7
    package 'clamav' do
      action :remove
      not_if "[[ $(rpm -q clamav) = 'clamav-0.102.4-1.el7.x86_64' ]]"
    end
  when 8
    package 'clamav' do
      action :remove
      not_if "[[ $(rpm -q clamav) = 'clamav-0.102.4-1.el8.x86_64' ]]"
    end
  end

  # Remove the existing configuration
  %w(freshclam.conf clamd.conf).each do |conf|
    file "/etc/#{conf}" do
      action :delete
      only_if "[[ -f /etc/#{conf} ]]"
    end
  end
  file '/usr/local/bin/clam-scan.sh' do
    action :delete
  end

  # Install the package
  package 'clamav' do
    action :install
    not_if "rpm -q 'clamav'"
  end

  # Ruby Logic to determine Capsule
  CAPSULE = `grep -i 'hostname' /etc/rhsm/rhsm.conf | awk -F '=' '{print $2}' | tr -d '[:space:]'`.freeze
  CLAMDBURL = 'https://clamav.' + CAPSULE + ':443/'

  # Build the Update Configuration File
  file '/etc/freshclam.conf' do
    content "##############################################\n# This file generated automatically by Chef. #\n# Any local changes will be overwritten.       #\n##############################################\nPrivateMirror #{CLAMDBURL}"
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
else
  # Install the package
  package 'clamav' do
    action :install
    not_if 'rpm -q clamav'
  end

  # Build the Update Configuration File
  file '/etc/freshclam.conf' do
    content "##############################################\n# This file generated automatically by Chef. #\n# Any local changes will be overwritten.       #\n##############################################\nPrivateMirror pkgrepo.int"
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

# ClamScan Template
template '/usr/local/bin/clam-scan.sh' do
  source 'clamscript.erb'
  owner 'root'
  group 'root'
  mode  '0755'
  action :create
end

# CronJob
cron 'clam.daily' do
  hour '1'
  command 'sleep $(($RANDOM * 2)) && /usr/local/bin/clam-scan.sh'
  action :create
end
