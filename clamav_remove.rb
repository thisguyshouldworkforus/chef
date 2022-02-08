# --------------------------------------------------------------
# Date:
# December 11, 2020
# --------------------------------------------------------------

# Determine the proper ClamAV User
clam_user = case node['platform_version'].to_i
            when 6
              'clam'
            else
              'clamupdate'
            end

# Delete ClamAV User
user clam_user.to_s do
  action :remove
  only_if "(test $(id -u #{clam_user}) = 286 || test $(id -u #{clam_user}) = 300) || (test $(id -g #{clam_user}) = 299 || test $(id -g #{clam_user}) = 995)"
end

# Delete ClamAV Group
group clam_user.to_s do
  action :remove
  only_if "test $(id -g #{clam_user}) = 299 || test $(id -g #{clam_user}) = 995"
end
##
