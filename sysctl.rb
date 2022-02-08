# --------------------------------------------------------------
# Date:
# February 03, 2021
# --------------------------------------------------------------

###
# Remove IPv6 and Multicast Forwarding Entries
case node['platform'].to_s
when 'redhat'
  case node['platform_version'].to_i
  when 7..8
    execute 'Remove IPv6 and Multicast Forwarding Entries' do
      command "sed -ri '/ipv6|mc_forwarding/d' /etc/sysctl.conf"
      action :run
    end
  end
end
###

###
if !File.exist?('/proc/sys/net/ipv4/tcp_timestamps') || !File.stat('/proc/sys/net/ipv4/tcp_timestamps').writable?
  bash 'remove_net.ipv4.tcp_timestamps' do
    code <<-EOH
      sed -i '/net.ipv4.tcp_timestamps/d' /etc/sysctl.conf
      EOH
  end
end
if File.exist?('/proc/sys/net/ipv4/tcp_timestamps') && File.stat('/proc/sys/net/ipv4/tcp_timestamps').writable?
  bash 'remove_net.ipv4.tcp_timestamps_2' do
    code <<-EOH
      sed -i '/net.ipv4.tcp_timestamps/d' /etc/sysctl.conf
      EOH
    only_if "((grep -qE '(net.ipv4.tcp_timestamps)(\s)?(=)(\s)?(1)' /etc/sysctl.conf)"
  end
end
if File.exist?('/proc/sys/net/ipv4/tcp_timestamps') && File.stat('/proc/sys/net/ipv4/tcp_timestamps').writable?
  execute 'add_net.ipv4.tcp_timestamps' do
    command "echo 'net.ipv4.tcp_timestamps=0' >> /etc/sysctl.conf"
    not_if "grep 'net.ipv4.tcp_timestamps=0' /etc/sysctl.conf"
    action :run
  end
end
###

###
if !File.exist?('/proc/sys/net/ipv4/conf/all/accept_source_route') || !File.stat('/proc/sys/net/ipv4/conf/all/accept_source_route').writable?
  bash 'remove_net.ipv4.conf.all.accept_source_route' do
    code <<-EOH
      sed -i '/net.ipv4.conf.all.accept_source_route/d' /etc/sysctl.conf
      EOH
  end
end
if File.exist?('/proc/sys/net/ipv4/conf/all/accept_source_route') && File.stat('/proc/sys/net/ipv4/conf/all/accept_source_route').writable?
  bash 'remove_net.ipv4.conf.all.accept_source_route_2' do
    code <<-EOH
      sed -i '/net.ipv4.conf.all.accept_source_route/d' /etc/sysctl.conf
      EOH
    only_if "((grep -qE '(net.ipv4.conf.all.accept_source_route)(\s)?(=)(\s)?(1)' /etc/sysctl.conf)"
  end
end
if File.exist?('/proc/sys/net/ipv4/conf/all/accept_source_route') && File.stat('/proc/sys/net/ipv4/conf/all/accept_source_route').writable?
  execute 'add_net.ipv4.conf.all.accept_source_route' do
    command "echo 'net.ipv4.conf.all.accept_source_route=0' >> /etc/sysctl.conf"
    not_if "grep 'net.ipv4.conf.all.accept_source_route=0' /etc/sysctl.conf"
    action :run
  end
end
###

###
if !File.exist?('/proc/sys/net/ipv4/conf/all/forwarding') || !File.stat('/proc/sys/net/ipv4/conf/all/forwarding').writable?
  bash 'remove_net.ipv4.conf.all.forwarding' do
    code <<-EOH
      sed -i '/net.ipv4.conf.all.forwarding/d' /etc/sysctl.conf
      EOH
  end
end
if File.exist?('/proc/sys/net/ipv4/conf/all/forwarding') && File.stat('/proc/sys/net/ipv4/conf/all/forwarding').writable?
  bash 'remove_net.ipv4.conf.all.forwarding_2' do
    code <<-EOH
      sed -i '/net.ipv4.conf.all.forwarding/d' /etc/sysctl.conf
      EOH
    only_if "((grep -qE '(net.ipv4.conf.all.forwarding)(\s)?(=)(\s)?(1)' /etc/sysctl.conf)"
  end
end
if File.exist?('/proc/sys/net/ipv4/conf/all/forwarding') && File.stat('/proc/sys/net/ipv4/conf/all/forwarding').writable?
  execute 'add_net.ipv4.conf.all.forwarding' do
    command "echo 'net.ipv4.conf.all.forwarding=0' >> /etc/sysctl.conf"
    not_if "grep 'net.ipv4.conf.all.forwarding=0' /etc/sysctl.conf"
    action :run
  end
end
###

###
if !File.exist?('/proc/sys/net/ipv4/conf/all/accept_redirects') || !File.stat('/proc/sys/net/ipv4/conf/all/accept_redirects').writable?
  bash 'remove_net.ipv4.conf.all.accept_redirects' do
    code <<-EOH
      sed -i '/net.ipv4.conf.all.accept_redirects/d' /etc/sysctl.conf
      EOH
  end
end
if File.exist?('/proc/sys/net/ipv4/conf/all/accept_redirects') && File.stat('/proc/sys/net/ipv4/conf/all/accept_redirects').writable?
  bash 'remove_net.ipv4.conf.all.accept_redirects_2' do
    code <<-EOH
      sed -i '/net.ipv4.conf.all.accept_redirects/d' /etc/sysctl.conf
      EOH
    only_if "((grep -qE '(net.ipv4.conf.all.accept_redirects)(\s)?(=)(\s)?(1)' /etc/sysctl.conf)"
  end
end
if File.exist?('/proc/sys/net/ipv4/conf/all/accept_redirects') && File.stat('/proc/sys/net/ipv4/conf/all/accept_redirects').writable?
  execute 'add_net.ipv4.conf.all.accept_redirects' do
    command "echo 'net.ipv4.conf.all.accept_redirects=0' >> /etc/sysctl.conf"
    not_if "grep 'net.ipv4.conf.all.accept_redirects=0' /etc/sysctl.conf"
    action :run
  end
end
###

###
if !File.exist?('/proc/sys/net/ipv4/conf/all/secure_redirects') || !File.stat('/proc/sys/net/ipv4/conf/all/secure_redirects').writable?
  bash 'remove_net.ipv4.conf.all.secure_redirects' do
    code <<-EOH
      sed -i '/net.ipv4.conf.all.secure_redirects/d' /etc/sysctl.conf
      EOH
  end
end
if File.exist?('/proc/sys/net/ipv4/conf/all/secure_redirects') && File.stat('/proc/sys/net/ipv4/conf/all/secure_redirects').writable?
  bash 'remove_net.ipv4.conf.all.secure_redirects_2' do
    code <<-EOH
      sed -i '/net.ipv4.conf.all.secure_redirects/d' /etc/sysctl.conf
      EOH
    only_if "((grep -qE '(net.ipv4.conf.all.secure_redirects)(\s)?(=)(\s)?(1)' /etc/sysctl.conf)"
  end
end
if File.exist?('/proc/sys/net/ipv4/conf/all/secure_redirects') && File.stat('/proc/sys/net/ipv4/conf/all/secure_redirects').writable?
  execute 'add_net.ipv4.conf.all.secure_redirects' do
    command "echo 'net.ipv4.conf.all.secure_redirects=0' >> /etc/sysctl.conf"
    not_if "grep 'net.ipv4.conf.all.secure_redirects=0' /etc/sysctl.conf"
    action :run
  end
end
###

###
if !File.exist?('/proc/sys/net/ipv4/conf/all/send_redirects') || !File.stat('/proc/sys/net/ipv4/conf/all/send_redirects').writable?
  bash 'remove_net.ipv4.conf.all.send_redirects' do
    code <<-EOH
      sed -i '/net.ipv4.conf.all.send_redirects/d' /etc/sysctl.conf
      EOH
  end
end
if File.exist?('/proc/sys/net/ipv4/conf/all/send_redirects') && File.stat('/proc/sys/net/ipv4/conf/all/send_redirects').writable?
  bash 'remove_net.ipv4.conf.all.send_redirects_2' do
    code <<-EOH
      sed -i '/net.ipv4.conf.all.send_redirects/d' /etc/sysctl.conf
      EOH
    only_if "((grep -qE '(net.ipv4.conf.all.send_redirects)(\s)?(=)(\s)?(1)' /etc/sysctl.conf)"
  end
end
if File.exist?('/proc/sys/net/ipv4/conf/all/send_redirects') && File.stat('/proc/sys/net/ipv4/conf/all/send_redirects').writable?
  execute 'add_net.ipv4.conf.all.send_redirects' do
    command "echo 'net.ipv4.conf.all.send_redirects=0' >> /etc/sysctl.conf"
    not_if "grep 'net.ipv4.conf.all.send_redirects=0' /etc/sysctl.conf"
    action :run
  end
end
###

###
if !File.exist?('/proc/sys/net/ipv4/conf/default/send_redirects') || !File.stat('/proc/sys/net/ipv4/conf/default/send_redirects').writable?
  bash 'remove_net.ipv4.conf.default.send_redirects' do
    code <<-EOH
      sed -i '/net.ipv4.conf.default.send_redirects/d' /etc/sysctl.conf
      EOH
  end
end
if File.exist?('/proc/sys/net/ipv4/conf/default/send_redirects') && File.stat('/proc/sys/net/ipv4/conf/default/send_redirects').writable?
  bash 'remove_net.ipv4.conf.default.send_redirects_2' do
    code <<-EOH
      sed -i '/net.ipv4.conf.default.send_redirects/d' /etc/sysctl.conf
      EOH
    only_if "((grep -qE '(net.ipv4.conf.default.send_redirects)(\s)?(=)(\s)?(1)' /etc/sysctl.conf)"
  end
end
if File.exist?('/proc/sys/net/ipv4/conf/default/send_redirects') && File.stat('/proc/sys/net/ipv4/conf/default/send_redirects').writable?
  execute 'add_net.ipv4.conf.default.send_redirects' do
    command "echo 'net.ipv4.conf.default.send_redirects=0' >> /etc/sysctl.conf"
    not_if "grep 'net.ipv4.conf.default.send_redirects=0' /etc/sysctl.conf"
    action :run
  end
end
###

###
# Set VM Swappiness Globally
execute 'vm.swappiness' do
  command "echo 'vm.swappiness=10' >> /etc/sysctl.conf"
  not_if 'grep vm.swappiness /etc/sysctl.conf'
end
###
