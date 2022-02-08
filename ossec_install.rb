# --------------------------------------------------------------
# Date:
# August 28, 2020
# --------------------------------------------------------------

# Create System Group
group 'Create Group' do
  group_name 'ossec'
  system true
  action :create
  not_if 'id -g ossec'
end

# Create System Users
%w(ossec ossecr ossecm ossece).each do |ossec_user|
  user ossec_user.to_s do
    system true
    comment "System #{ossec_user} User"
    home '/var/ossec'
    shell '/sbin/nologin'
    gid 'ossec'
    action :create
    not_if "id -u #{ossec_user}"
  end
end

case node['platform']
when 'centos'
  yum_repository 'EWS-3rd-party-repo' do
    description 'EWS 3rd party rpms'
    baseurl 'https://sba.tc/artifactory/third-party-rpms/el/$releasever/$basearch/'
    gpgcheck false
    sslverify false
    action :create
    metadata_expire '10'
  end
  yum_repository 'CentOS-Epel' do
    description 'CentOS-$releasever - Epel'
    baseurl 'https://sba.tc/artifactory/CentOS-Main-EPEL/$releasever/$basearch/'
    gpgcheck false
    sslverify false
    action :create
  end
end

package 'GeoIP' do
  action :install
end
package 'ossec-hids-server' do
  action :install
end

execute 'change_mode' do
  command 'chmod -R 770 /var/ossec'
  only_if 'rpm -qa | grep ossec-hids-server'
end
execute 'change_group' do
  command 'chgrp -R ossec /var/ossec'
  only_if 'rpm -qa | grep ossec-hids-server'
end

if File.exist?('/etc/chef/client.rb') && !File.readlines('/etc/chef/client.rb').grep(/chef12corp/).empty?
  cookbook_file '/var/ossec/etc/ossec-server.conf' do
    source 'ossec.conf'
    mode '644'
    owner 'root'
    group 'root'
    only_if 'rpm -qa | grep ossec-hids-server'
  end
elsif File.exist?('/etc/chef/client.rb') && !File.readlines('/etc/chef/client.rb').grep(/chef12prod/).empty?
  cookbook_file '/var/ossec/etc/ossec-server.conf' do
    source 'ossec.conf.prod'
    mode '644'
    owner 'root'
    group 'root'
    only_if 'rpm -qa | grep ossec-hids-server'
  end
end

cookbook_file '/var/ossec/bin/.process_list' do
  source '.process_list'
  mode '644'
  owner 'root'
  group 'root'
  only_if 'rpm -qa | grep ossec-hids-server'
end
cookbook_file '/var/ossec/rules/local_rules.xml' do
  source 'local_rules.xml'
  mode '644'
  owner 'root'
  group 'root'
  only_if 'rpm -qa | grep ossec-hids-server'
end
service 'ossec-hids' do
  pattern 'ossec-hids'
  supports status: true, start: true, stop: true, restart: true
  action [:enable, :start]
  only_if 'rpm -qa | grep ossec-hids-server'
end
