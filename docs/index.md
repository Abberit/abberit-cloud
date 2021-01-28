# Installation

To install Abberit Admin Panel on your Linux server you could follow automated installation or manual. We recommend to use automated installation whenever possible.

## Automated installation

Currently automated installation is supported on Linode Linux servers.

Go to Linode Manager StackScripts, navigate to Abberit StackScript of your choice and follow UX prompts to install it automatically.

## Manual installation

### Step 1. Install Docker

Follow official Docker instructions to [install Docker Engine](https://docs.docker.com/engine/install/) on your server.

### Step 2. Install Abberit Admin Panel

=== "Debian 9+"
    Set two environment variables for user and password to Abberit Admin Panel:
    
    ``` bash
    set ABBERITUSER=YOUR_USER
    ```

    ``` bash
    set ABBERITPASSWORD=YOUR_PASSWORD
    ```

    Download installation script into local file, inspect its content and then execute it:

    ``` bash
    curl -fsSL https://raw.githubusercontent.com/Abberit/abberit-cloud/master/scripts/abberit.install.sh -o abberit.install.sh
    ```

    ``` bash
    sudo bash abberit.install.sh
    ```

=== "Ubuntu 18+"
    Set two environment variables for user and password to Abberit Admin Panel:
    
    ``` bash
    set ABBERITUSER=YOUR_USER
    ```

    ``` bash
    set ABBERITPASSWORD=YOUR_PASSWORD
    ```

    Download installation script into local file, inspect its content and then execute it:


    ``` bash
    curl -fsSL https://raw.githubusercontent.com/Abberit/abberit-cloud/master/scripts/abberit.install.sh -o abberit.install.sh
    ```

    ``` bash
    sudo bash abberit.install.sh
    ```

=== "CentOS 8 (preview)"
    Contact us at [info@abberit.io](mailto:info@abberit.io?subject=CentOS%20Private%20Preview) to join Private Preview on CentOS.

=== "Fedora 33 (preview)"
    Contact us at [info@abberit.io](mailto:info@abberit.io?subject=Fedora%20Private%20Preview) to join Private Preview on Fedora.

=== "Other"
    We are not testing our software on other Linux distributions and provide no guarantees or support. For any questions please reach out at [info@abberit.io](mailto:info@abberit.io?subject=Other%20Linux%20Distro).