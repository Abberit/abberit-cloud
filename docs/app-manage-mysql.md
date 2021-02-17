# Manage MySQL

Abberit Admin Panel provide experiences which allow you to manage MongoDB.

`Hosting Environment` provides the information such as `Private Connection String` and `Public Connection String`.

`Environment Variables` allows to add and change database environment variables.
 
`Terminal` provides an access to MySQL CLI and allows to do the maintenance and configuration tasks.

## Hosting Environment
`Hosting Environment` can be access by clicking on `Hosting Environment` tab on `App details` view.

It provides `Private Connection String`, which is recommended to be used for secure access by the applications running on the same server or cluster.

When public port was configured to access MySQL outside of the server or cluster - then `Public Connection String` will be shared as well. That is strongly recommended to protect your database with username and password in that case and rotate them regularly.

![mysql hosting env](./img/mysql-hosting-env.png)

## Environment Variables

`Environment Variables` can be accessed by clicking on `settings` link on `App list` view on the application card or by clicking on `Environment Variables` tab in `App details` view.

This tab allows to manage environment variables which define the behavior of MySQL database.

![mysql env variables](./img/mysql-env-variables.png)

## Terminal

`Terminal` can be accessed by clicking on `Terminal` tab in `App Details` view. It is `bash` terminal to OS hosting your MySQL database. From it you can accesss `mysql` and other MySQL and Debian utilities.

![mongodb terminal](./img/mysql-terminal.png)

## Additional Guides:
1. [:material-launch: MySQL Command-Line Client](https://dev.mysql.com/doc/refman/8.0/en/mysql.html){target=_blank}
1. [:material-launch: MySQL Environment Variables](https://dev.mysql.com/doc/refman/8.0/en/environment-variables.html){target=_blank}
2. [:material-launch: MySQL backups](https://dev.mysql.com/doc/refman/8.0/en/backup-methods.html){target=_blank}
