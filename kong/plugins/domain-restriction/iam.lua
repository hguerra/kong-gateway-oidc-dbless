local roles = require "kong.plugins.domain-restriction.roles"
local users = require "kong.plugins.domain-restriction.users"


local _M = {}


function _M.sum(x1, x2)
  return x1 + x2
end


function _M.roles()
  return roles
end


function _M.users()
  return users
end


return _M
