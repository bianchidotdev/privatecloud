#!/usr/bin/env bash

set -e

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
PROJECT_ROOT=$(dirname "${SCRIPT_DIR}"/..)

for file in "db.env" ".env"; do
  if [ -f ${file} ]; then
    echo "${file} already exists"
  else
    echo "Creating ${file}"
    cp "${file}.example" ${file}
  fi
done

if [ -f usersfile ]; then
  echo "usersfile already exists"
else
  echo "Creating traefik dashboard user - enter basic auth password"
  echo $(htpasswd -nB admin) > usersfile
fi

echo "Ensuring required docker networks exist"
for network in "web" "internal"; do
  if docker network inspect ${network} > /dev/null 2>&1; then
    echo "${network} exists"
  else
    echo "Creating docker network ${network}"
    docker network create ${network}
  fi
done

echo "Initial setup complete - Please update secrets in ./.env and ./db.env"
