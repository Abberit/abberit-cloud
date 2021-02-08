# Hosting multiple wordpress applications on a single Linode VM instance

When it comes to hosting multiple WordPress instances on the same VM, it is possible now with a few click on Linode with a help by Abberit admin panel.

## Assumptions
Hosting multiple apps on a single VM, means that the apps should be available externally and be accessible either by different ports, different host names (domain names), or by different url sub-paths. In this guide I'll be setting different domain names for the same VM instance, and differentiate based on url used to access the VM.

WordPress uses MySQL as its database management system. For this guide I'll use one MySQL instance per WordPress app, since it provides better isolation between the applications, easier management, and conviniently - less steps to provision.

## Step by step instructions
1. Create a Linode VM with Abberit admin panel, using stackscript: Navigate to [Abberit StackScript on Linode](https://cloud.linode.com/linodes/create?type=StackScripts&subtype=Community&stackScriptID=759545), click the button "Deploy New Linode" and follow UX prompts to install Abberit Admin Panel automatically.
    * Provide new credentials for admin panel. Take a note of those - you'll need them in order to access the admin panel
    * Choose the rest of values as usual
2. Procure 2 domains using `freenom.com` or your preferred domain provider
    * Navigate to [freenom.com](https://freenom.com)
    * Find free available domain, let's say it could be `my-wp-01.tk`. Click `Get it now`
    * Search for second domain, for example: `my-wp-02.tk`. Click `Get it now`
    * Start checking it out
    * Click `Use DNS` on both domains and paste your IP address (copy from Linode page) into all four fields (two A records per domain). By using the same IP address, you are making the same VM to server requests for different domain names.
    * Choose desired period and click `continue`, then `check out`.
3. Navigate to your admin panel at [http://&lt;your vm ip&gt;:8081](http://your vm ip:8081){target=_blank} and create WordPress app for the first domain:
    * Click `Add new App` on the right side of app list
    * Choose `WordPress`
    * Type in `Application name`, for example: `my-wp-01_tk`
    * Type in the `Domain name`, in my case: `my-wp-01.tk`
    * Leave the rest of the fields as is, and click `Add`
4. Create the second app on the same VM by following step for and setting different values for `Application name` and for `Domain name`. I choose `my-wp-02_tk` and `my-wp-02.tk` accordingly.
5. Now all the required steps are finished, but sometimes you need to wait for domain records to propogate, so that you can use your newly created domain names to access your WordPress instances. I use [toolbox.googleapps.com/apps/dig/#A/](https://toolbox.googleapps.com/apps/dig/#A/) and enter domain name to check the records were successfully propagated. The output should look like:
```
;ANSWER
<your domain name>. 3312 IN A <your IP>
```

Navigate to your newly created applications using your domains. Those domain names resolve to the same IP address, but to two different WordPress instances.

## Next steps
* [Configure https:// access to your websites](app-https.md)
