# Installation

To install Abberit Admin Panel on your Linux server you could follow automated installation or manual. We recommend to use automated installation whenever possible.

## Automated installation

Currently automated installation is supported on Linode Linux servers.

Navigate to [:material-launch: Abberit StackScript on Linode](https://cloud.linode.com/stackscripts/759545){target=_blank}, click the button "Deploy New Linode" and follow UX prompts to install Abberit Admin Panel automatically.

## Manual installation

### Step 1. Install Docker

Follow official Docker instructions to [:material-launch: install Docker Engine](https://docs.docker.com/engine/install/){target=_blank} on your server.

### Step 2. Install Abberit Admin Panel

!!! important
    All the instructions below must be executed under `root` user.

=== "Debian 9+"
    Download installation script into local file and inspect its content.

    ``` bash
    curl -fsSL \
      https://raw.githubusercontent.com/Abberit/abberit-cloud/master/scripts/abberit.install.sh \
      -o abberit.install.sh
    ```

    Now execute the installation script. It will prompt for username and password to login into Abberit Admin Panel later.

    ``` bash
    sudo bash abberit.install.sh
    ```

=== "Ubuntu 18+"
    Download installation script into local file and inspect its content.

    ``` bash
    curl -fsSL \
      https://raw.githubusercontent.com/Abberit/abberit-cloud/master/scripts/abberit.install.sh \
      -o abberit.install.sh
    ```

    Now execute the installation script. It will prompt for username and password to login into Abberit Admin Panel later.

    ``` bash
    sudo bash abberit.install.sh
    ```

=== "CentOS 8 (preview)"
    Contact us at [info@abberit.io](mailto:info@abberit.io?subject=CentOS%20Private%20Preview) to join Private Preview on CentOS.

=== "Fedora 33 (preview)"
    Contact us at [info@abberit.io](mailto:info@abberit.io?subject=Fedora%20Private%20Preview) to join Private Preview on Fedora.

=== "Other"
    We are not testing our software on other Linux distributions and provide no guarantees or support. For any questions please reach out at [info@abberit.io](mailto:info@abberit.io?subject=Other%20Linux%20Distro).