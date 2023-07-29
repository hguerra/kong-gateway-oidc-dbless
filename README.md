# Kong DB-less Example with OIDC

The purpose of this repository is to configure Kong with OIDC (OpenID Connect). In this scenario, the login is performed using Google.

A plugin was also built to block invalid domains. For instance, imagine that your company has a Google Workspace domain. You could authenticate with Google, restricting access to only the email domain of your company, for example, `myemail@example.com`.


## Install

This repo uses [Task](https://taskfile.dev/). Task is a task runner / build tool that aims to be simpler and easier to use than, for example, GNU Make.


## Development

```
cp .env.example .env

task download

task config

task up
```


## Reference

https://github.com/revomatico/kong-oidc

https://github.com/revomatico/docker-kong-oidc

https://docs.konghq.com/gateway/latest/kong-plugins/authentication/oidc/google/
