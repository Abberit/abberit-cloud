# Setting web app for https

## Setting up the domain registration for your app:
If you don't have the domain name registered, which resolves to your host IP, follow [Setting up domain](app-domain.md) tutorial

## Obtain free SSL certificate using certbot:
1. Login to your VM via SSH
2. Execute docker image of certbot: `docker run -it --rm --name certbot -p 80:80 -p 443:443 -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" certbot/certbot certonly`
 a. Hint: If you use `1: Spin up a temporary webserver (standalone)` option: Make sure that your webapp is stopped, and not using ports 80 and 443 before running the docker run command
 b. Follow the steps and at the end you should get your certificates located under `/etc/letsencrypt/live/`
3. Copy certificates to nginx-accessible area: `cp -rL /etc/letsencrypt/live/ /ab/sites/certs/` (`-L` is required to resolve symlinks)

## Create the app which works with https
With Abberit all the web apps are behind nginx reverse proxy, which makes https configuration https-agnostic. The nginx app will handle all the https-related tasks, while the actual web app (NodeJS app, WordPress app and others) will remain http-only and fully protected. To allow the https connections to the app, follow those steps:
1. Start creating the web app through the Abberit admin panel
2. Specify `Domain name` to exact same name as used in certificate provisioning step
3. Click `Advanced` and in advanced settings specify `Application https port on the host` (typically - 443)
4. Once https port is specified, the settings to specify the path to the SSL certificate and to the key will be displayed. Enter following values:
  a. `Certificate public key path`: `/ab/sites/certs/<your domain name>/cert.pem`
  b. `Certificate private key path`: `/ab/sites/certs/<your domain name>/privkey.pem`
5. Click `Add` and the app with https settings will be shortly created


# Additional Guides:
1. [ssl certificate guides](https://www.linode.com/docs/guides/security/ssl/)
2. [Installing certbot](https://www.linode.com/docs/guides/how-to-install-certbot-on-ubuntu-18-04/)