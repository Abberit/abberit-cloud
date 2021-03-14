#!/bin/bash

echo 'Checking docker is installed'
docker -v
if [[ "$?" != "0" ]]
then 
  echo 'Error: not found docker installed, exiting'
  exit 1
fi

echo 'Please enter username for Abberit Admin Panel:'
read -p 'Username: ' ABBERITUSER

echo 'Please enter password for Abberit Admin Panel:'
read -sp 'Password: ' ABBERITPASSWORD

## configure docker to run as daemon
sudo systemctl enable docker

## install htpasswd utility as part of apache2-utils
sudo apt-get update
sudo apt-get install -y apache2-utils

## add Abberit Admin Panel user
sudo mkdir /etc/abberit/
sudo htpasswd -b -c /etc/abberit/.htpasswd $ABBERITUSER $ABBERITPASSWORD

## common network for all services:
docker network create abnet

docker pull abberit/ab-dev:1.0.2
docker run \
  -d \
  --restart unless-stopped \
  --net abnet \
  -p 8081:8080 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /ab/sites/:/ab/sites \
  -v /etc/abberit/.htpasswd:/etc/abberit/.htpasswd \
  abberit/ab-dev:1.0.2
# `-d ` run detached, i.e. no console output will be shown in main console \
# `--restart unless-stopped ` restart always, unless the customer specifically stopped it \
# `-p 80:8080` map port 80 to container's port 8080 \
# `-v /var/run/docker.sock:/var/run/docker.sock` share `/var/run/docker.sock` to allow connecting to docker from within container \
# `-v /ab/sites/:/ab/sites` share `/ab/sites`` to allow managing websites folder (this folder is shared with app containers) \
# '-v /etc/abberit/.htpasswd:/etc/abberit/.htpasswd' to authenticate users to Admin Panel

vmIP=$(curl -4 https://icanhazip.com)

# wait for appmanager to start
retry=0
while true ;
do
  if [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:8081)" == "200" ]] 
  then
    echo 'localhost:8081 is ready (returned 200)'
    break;
  fi

  ((retry++));
  if [[ $retry -le 10 ]]
  then
    echo "localhost:8081 is not ready (did not return 200), retrying in 2 seconds"
    sleep 2;
  else
    >&2 echo "ERROR: localhost:8081 is not ready (did not return 200)."
    break;
  fi
done

# Create the initial node app:
curl --user "$ABBERITUSER:$ABBERITPASSWORD" --request POST --url http://localhost:8081/api/webapp/app/defaultApp \
     --header 'content-type: application/json' \
     --data '{"appType":"node","hostToAppPortMap":{},"envVars":{"PORT": "80"},"nginxSettings":[{"listen":"80","serverName":"'$vmIP'","proxyPass":"defaultApp"}]}' \
     --max-time 120

# Start the app:
curl --user "$ABBERITUSER:$ABBERITPASSWORD" --request POST --url http://localhost:8081/api/webapp/start/defaultApp \
     --max-time 60

echo ""
echo ""
echo "Installation complete! Your Abberit Admin Panel is available at http://$vmIP:8081"
