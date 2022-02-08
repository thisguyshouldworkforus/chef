# --------------------------------------------------------------
# Date:
# December 11, 2020
# --------------------------------------------------------------

# Delete System Users
##
user 'ossece' do
  action :remove
  only_if "(test $(id -u ossece) = 286 || test $(id -u ossece) = 300) || (test $(id -g ossec) = 299 || test $(id -g ossec) = 995)"
end
##
user 'ossecr' do
  action :remove
  only_if "(test $(id -u ossecr) = 286 || test $(id -u ossecr) = 300) || (test $(id -g ossec) = 299 || test $(id -g ossec) = 995)"
end
##
user 'ossecm' do
  action :remove
  only_if "(test $(id -u ossecm) = 286 || test $(id -u ossecm) = 300) || (test $(id -g ossec) = 299 || test $(id -g ossec) = 995)"
end
##
user 'ossec' do
  action :remove
  only_if "(test $(id -u ossec) = 286 || test $(id -u ossece) = 300) || (test $(id -g ossec) = 299 || test $(id -g ossec) = 995)"
end

# Delete OSSEC Group
group 'ossec' do
  action :remove
  only_if 'test $(id -g ossec) = 299 || test $(id -g ossec) = 995'
end
