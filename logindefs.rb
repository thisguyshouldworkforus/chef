# --------------------------------------------------------------
# Date:
# February 17, 2021
# --------------------------------------------------------------

replace_or_add 'SYS_UID_MIN' do
  path '/etc/login.defs'
  pattern '(SYS_UID_MIN)(\s+)([0-9]{3})'
  line 'SYS_UID_MIN 401'
end

replace_or_add 'SYS_UID_MAX' do
  path '/etc/login.defs'
  pattern '(SYS_UID_MAX)(\s+)([0-9]{3})'
  line 'SYS_UID_MAX 899'
end

replace_or_add 'SYS_GID_MIN' do
  path '/etc/login.defs'
  pattern '(SYS_GID_MIN)(\s+)([0-9]{3})'
  line 'SYS_GID_MIN 401'
end

replace_or_add 'SYS_GID_MAX' do
  path '/etc/login.defs'
  pattern '(SYS_GID_MAX)(\s+)([0-9]{3})'
  line 'SYS_GID_MAX 899'
end
