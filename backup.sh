#!/usr/bin/env bash
set -e

date
echo "Starting data backup"

source "$( dirname "${BASH_SOURCE[0]}" )/kopia.env"

kopia repository connect b2 --bucket=${KOPIA_B2_BUCKET}  --key-id=${KOPIA_B2_KEY_ID} --key=${KOPIA_B2_KEY}

kopia snapshot create ${KOPIA_NEXTCLOUD_DATA_DIR}
echo "Data backup complete"

echo "Starting db backup"

cd /home/ubuntu/workspace/plexcloud/

# Backup PostgreSQL database
echo "Backing up Nextcloud database"

now=$(date +"%m_%d_%Y")

set -o allexport
source "$( dirname "${BASH_SOURCE[0]}" )/db.env"
set +o allexport

docker-compose exec db pg_dump -U ${POSTGRES_USER} ${POSTGRES_DB} > ${KOPIA_NEXTCLOUD_DB_BACKUP}/nextcloud-db.sql

kopia repository connect b2 --bucket=${KOPIA_B2_DB_BUCKET}  --key-id=${KOPIA_B2_KEY_ID} --key=${KOPIA_B2_KEY}

kopia snapshot create ${KOPIA_NEXTCLOUD_DATA_DIR}

echo "DB backup complete

