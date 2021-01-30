# Setting up domain for your application

## Setting up free domain using freenom.com
1. Navigate to [freenom.com](https://freenom.com) and find free domain, let's say it could be `abtest.tk`
2. Check it out, and then login back to freenom panel, and click `Services`->`My domains`
3. Next to your domain, click `Manage domain`
4. Click on `Manage Freenom DNS`
5. Add `A` record, and in `Target` specify your Linode IP address. Click `Save Changes`
6. After few minutes, try use [toolbox.googleapps.com/apps/dig/#A/](https://toolbox.googleapps.com/apps/dig/#A/) and enter your domain name to check the record was successfully propagated. The output should look like:
```
;ANSWER
<your domain name>. 3312 IN A <your IP>
```

## Next steps
* [Creating wordpress app](app-add-wordpress.md)