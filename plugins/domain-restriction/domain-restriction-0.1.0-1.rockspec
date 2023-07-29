local plugin_name = "domain-restriction"
local package_name = plugin_name
local package_version = "0.1.0"
local rockspec_revision = "1"

local github_account_name = "hguerra"
local github_repo_name = "kong-gateway-oidc-dbless"
local git_checkout = package_version == "dev" and "main" or package_version


package = package_name
version = package_version .. "-" .. rockspec_revision
supported_platforms = { "linux" }
source = {
  url = "git+https://github.com/"..github_account_name.."/"..github_repo_name..".git",
  branch = git_checkout,
}


description = {
  summary = "Restrict domains for OIDC",
  homepage = "https://"..github_account_name..".github.io/"..github_repo_name,
  license = "Apache 2.0",
}


dependencies = {
}


build = {
  type = "builtin",
  modules = {
    [plugin_name..".handler"] = "handler.lua",
    [plugin_name..".schema"]  = "schema.lua",
  }
}
