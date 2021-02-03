# Setting up https 

## Setting up the domain registration for your app:
If you don't have the domain name registered, which resolves to your host IP, follow [Setting up domain](app-domain.md) tutorial

## Obtain free SSL certificate using certbot:
*Step 1*. Login to your VM via SSH

*Step 2*. Execute docker image of certbot:

!!! hint
    If you use `1: Spin up a temporary webserver (standalone)` certbot option - then make sure that your webapp is stopped, and not using ports 80 and 443 before running certbot.
```bash
docker run -it --rm --name certbot \
      -p 80:80 -p 443:443 \
      -v "/etc/letsencrypt:/etc/letsencrypt" \
      -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
      certbot/certbot certonly
```

*Step 3*. Follow the prompts of certbot and at the end you should get your certificates located under `/etc/letsencrypt/live/`

*Step 4*. Copy certificates to nginx-accessible area: (`-L` is required to resolve symlinks):
```bash
cp -rL /etc/letsencrypt/live/ /ab/sites/certs/
```

## Create the app which works with https
With Abberit all the web apps are behind nginx reverse proxy, which simplifies https configuration for the whole server. The nginx component will handle all the https-related tasks, while the actual web app (NodeJS app, WordPress app and others) need to handle http-only and remain fully protected.

To setup the https connection to the app, follow these steps:

1. Start creating the web app through the Abberit admin panel
2. Specify `Domain name` to exact same name as used in certificate provisioning step
3. Click `Advanced` and in advanced settings specify `Application https port on the host` (typically - 443)
4. Once https port is specified, the settings to specify the path to the SSL certificate and to the key will be displayed. Enter following values:
    * `Certificate public key path`: `/ab/sites/certs/<your domain name>/cert.pem`
    * `Certificate private key path`: `/ab/sites/certs/<your domain name>/privkey.pem`
5. Click `Add` and the app with https settings will be shortly created


# Additional Guides:
1. [SSL certificate guides](https://www.linode.com/docs/guides/security/ssl/)
2. [Installing certbot](https://www.linode.com/docs/guides/how-to-install-certbot-on-ubuntu-18-04/)