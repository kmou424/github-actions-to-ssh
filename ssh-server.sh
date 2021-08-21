#!/bin/bash

if [[ -z "$NGROK_TOKEN" ]]; then
  echo "Please set 'NGROK_TOKEN'"
  exit 2
fi

if [[ -z "$SSH_PASSWORD" ]]; then
  echo "Please set 'SSH_PASSWORD' for user: $USER"
  exit 3
fi

wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip
unzip ngrok-stable-linux-386.zip
chmod +x ./ngrok

echo -e "$SSH_PASSWORD\n$SSH_PASSWORD" | sudo passwd "$USER"

rm -f .ngrok.log
echo "authtoken: $NGROK_TOKEN
tunnels:
  a:
    addr: 22
    proto: tcp
  b:
    addr: 6800
    proto: http" > ngrok.yml
./ngrok start -config ngrok.yml --all --log ".ngrok.log" &

sleep 10

HAS_ERRORS=$(grep "command failed" < .ngrok.log)

if [[ -z "$HAS_ERRORS" ]]; then
  echo ""
  echo "SSH:"
  echo "To connect: $(grep -o -E "tcp://(.+)" < .ngrok.log | sed "s/tcp:\/\//ssh $USER@/" | sed "s/:/ -p /")"
  echo ""
  echo "HTTP:"
  echo "$(grep -o -E "addr=http://(.+)" < .ngrok.log | sed "s/addr=//" | sed "s/ url=/ -> /")"
  echo ""
else
  echo "$HAS_ERRORS"
  exit 4
fi
