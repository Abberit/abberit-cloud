#!/bin/bash

if [[ "$ABBERITUSER" == "" ]]
then
  echo 'Error: ABBERITUSER environment variable was not set, exiting'
  exit 1
fi

if [[ "$ABBERITPASSWORD" == "" ]]
then
  echo 'Error: ABBERITPASSWORD environment variable was not set, exiting'
  exit 1
fi

## setup docker log rotation
sudo cat >/etc/docker/daemon.json <<EOL
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3" 
  }
}
EOL

## Configure docker to run as daemon
sudo systemctl enable docker

## Add sudo user
sudo mkdir /etc/abberit/
sudo htpasswd -b -c /etc/abberit/.htpasswd $ABBERITUSER $ABBERITPASSWORD

## Prepare folder for SSL certs
sudo mkdir /etc/letsencrypt/

## common network for all services:
docker network create abnet

docker pull abberit/ab-dev:0.1.7
docker run \
  -d \
  --restart unless-stopped \
  --net abnet \
  -p 8081:8080 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /ab/sites/:/ab/sites \
  -v /etc/abberit/.htpasswd:/etc/abberit/.htpasswd \
  abberit/ab-dev:0.1.7
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
curl --user "$ABBERITUSER:$ABBERITPASSWORD" --request POST --url http://localhost:8081/api/webapp/app/defaultNodeApp \
     --header 'content-type: application/json' \
     --data '{"appType":"node","hostToAppPortMap":{},"envVars":{},"nginxSettings":[{"listen":"80","serverName":"'$vmIP'","proxyPass":"defaultNodeApp"}]}' \
     --max-time 120

# Start the app:
curl --user "$ABBERITUSER:$ABBERITPASSWORD" --request POST --url http://localhost:8081/api/webapp/start/defaultNodeApp \
     --max-time 60

echo "Installation complete!"
