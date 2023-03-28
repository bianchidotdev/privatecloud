#!/usr/bin/env sh

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_ROOT="${SCRIPT_DIR}/.."

# Source the domains set 
set -o allexport
source "${PROJECT_ROOT}/.env"
set +o allexport

echo "Setting DNS Overrides for ${BASE_DOMAIN}"
echo "127.0.0.1 ${NEXTCLOUD_SUBDOMAIN}${BASE_DOMAIN} \
  ${ROUTER_SUBDOMAIN}${BASE_DOMAIN} \
  ${TRAEFIK_SUBDOMAIN}${BASE_DOMAIN}" | sudo tee -a /etc/hosts
