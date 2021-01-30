# Setting web app for https

## Setting up free domain using freenom.com
1. Navigate to http://freenom.com and find free domain, let's say it could be `abtest.tk`
2. Check it out, and then login back to freenom panel, and click `Services`->`My domains`
3. Next to your domain, click `Manage domain`
4. Click on `Manage Freenom DNS`
5. Add `A` record, and in `Target` specify your Linode IP address. Click `Save Changes`
6. After few minutes, try use https://toolbox.googleapps.com/apps/dig/#A/ and enter your domain name to check the record was successfully propagated. The output should look like:
```
;ANSWER
<your domain name>. 3312 IN A <your IP>
```

## Setting up free SSL using certbot
## Obtain free SSL certificate:
1. Login to your VM via SSH
2. Execute docker image of certbot: `docker run -it --rm --name certbot -p 80:80 -p 443:443 -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" certbot/certbot certonly`
 a. Hint: If you use `1: Spin up a temporary webserver (standalone)` option: Make sure that your webapp is stopped, and not using ports 80 and 443 before running the docker run command 
## Update your application to use the SSL certificate:
```javascript
const dir = "/etc/letsencrypt/live/" + <your domain name>
const options = {
  key: fs.readFileSync(`${dir}/privkey.pem`),
  cert: fs.readFileSync(`${dir}/cert.pem`)
};
const httpsServer = options !== null ? https.createServer(options, requestListener) : undefined;
httpsServer.listen(httpsPort, hostname, () => {
  console.log(`Server running at https://${hostname}:${httpsPort}/. Access via https://localhost:${httpsPort}`);
});
```

# Additional Guides:
1. [ssl certificate guides](https://www.linode.com/docs/guides/security/ssl/)
2. [Installing certbot](https://www.linode.com/docs/guides/how-to-install-certbot-on-ubuntu-18-04/)