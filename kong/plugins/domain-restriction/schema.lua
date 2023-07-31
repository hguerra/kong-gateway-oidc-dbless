local typedefs = require "kong.db.schema.typedefs"


return {
  name = "domain-restriction",
  fields = {
    {
      -- this plugin will only be applied to Services or Routes
      consumer = typedefs.no_consumer
    },
    {
      -- this plugin will only run within Nginx HTTP module
      protocols = typedefs.protocols_http
    },
    {
      config = {
        type = "record",
        fields = {
          {
            allow = {
              type = "array",
              elements = typedefs.host,
            },
          },
          {
            deny = {
              type = "array",
              elements = typedefs.host,
            },
          },
          {
            header_name = {
              type = "string",
              default = "X-ID-Token",
              required = false,
            },
          },
          {
            cookie_name = {
              type = "string",
              default = "oidc_session",
              required = false,
            },
          },
        },
      },
    },
  },
  entity_checks = {
    { at_least_one_of = { "config.allow", "config.deny" }, },
  },
}
