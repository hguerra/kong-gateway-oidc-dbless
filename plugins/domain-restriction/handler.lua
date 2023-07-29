local json = require "cjson"
local pl_stringx = require "pl.stringx"


local kong = kong
local log = kong.log
local decode_base64 = ngx.decode_base64
local endswith = pl_stringx.endswith


local DomainRestrictionHandler = {
  PRIORITY = 999,
  VERSION = "0.1.0",
}


local isempty
do
  local tb_isempty = require "table.isempty"

  isempty = function(t)
    return t == nil or tb_isempty(t)
  end
end


local function do_exit(status, message)
  status = status or 403
  message = message or "Domain not allowed"

  log.warn(message)

  return kong.response.error(status, message)
end


local function match_domain(list, email)
  for _, domain in ipairs(list) do
    if endswith(email, domain) then
      return true
    end
  end
  return false
end


local function do_restrict(conf)
  local headers = kong.request.get_headers()
  local header_name = conf.header_name
  local header_value = headers[header_name]

  if not header_value or header_value == ""  then
    return do_exit(403, "Cannot identify the client token")
  end

  local ok, claims = pcall(function()
    return json.decode(decode_base64(header_value))
  end)

  if not ok then
    return do_exit(403, "Invalid token")
  end

  if not claims or not claims.email or type(claims.email) ~= "string" then
    return do_exit(403, "Invalid token")
  end

  local deny = conf.deny

  if not isempty(deny) then
    local blocked = match_domain(deny, claims.email)
    if blocked then
      return do_exit()
    end
  end

  local allow = conf.allow

  if not isempty(allow) then
    local allowed = match_domain(allow, claims.email)
    if not allowed then
      return do_exit(conf.status, conf.message)
    end
  end
end


function DomainRestrictionHandler:access(conf)
  return do_restrict(conf)
end


function DomainRestrictionHandler:preread(conf)
  return do_restrict(conf)
end


return DomainRestrictionHandler
