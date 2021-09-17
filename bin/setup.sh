#!/usr/bin/env bash

set -e

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
PROJECT_ROOT=$(dirname "${SCRIPT_DIR}"/..)

for file in "db.env" ".env"; do
  if [ -z ${file} ]; then
    echo "Creating ${file}"
    cp "${file}.example" ${file}
  else
    echo "${file} already exists"
  fi
done

if [ -z usersfile ]; then
  echo "Creating traefik dashboard user - enter basic auth password"
  echo $(htpasswd -nB admin) > usersfile
else
  echo "usersfile already exists"
fi

echo "Initial setup complete - Please update secrets in ./.env and ./db.env"