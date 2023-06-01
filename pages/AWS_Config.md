---
title: AWS Config
layout: default
---

# AWS Config

## AWS Local Config

In `~/.aws/config`:

```
[profile YOUR_PROFILE_NAME]
region = eu-central-1
```


## Saml2AWS Config

In `~/.saml2aws`:

```
[default]
name                    = default
app_id                  =
url                     = YOUR_ADFS_URL
username                = YOUR_USERNAME // propably e-mail
provider                = ADFS
mfa                     = Auto
skip_verify             = false
timeout                 = 0
aws_urn                 = urn:amazon:webservices
aws_session_duration    = 3600
aws_profile             = YOUR_LOCAL_AWS_PROFILE // From ~/.aws/config
resource_id             =
subdomain               =
role_arn                =
region                  =
http_attempts_count     =
http_retry_delay        =
credentials_file        =
saml_cache              = false
saml_cache_file         =
target_url              =
disable_remember_device = false
disable_sessions        = false
```
