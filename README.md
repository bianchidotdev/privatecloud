
# Private Home Cloud

This is a setup of a multi-user private cloud, including a NextCloud instance, a Plex media server, and a Traefik reverse proxy to handle the networking and auto-TLS.

## Setup

Rename/copy all the required env files (`.env`, `db.env`, and `usersfile`)

```bash
cp .env.example .env
cp db.env.example db.env
```

Update the following values:
1. Set a db password in `db.env`
1. Update the BASE_DOMAIN and any SUBDOMAINS as desired in `.env`


Encode a secure password and set it in `usersfile`

```bash
echo $(htpasswd -nB user) > usersfile # change user with whatever username you'd lioke
```

Start the docker compose suite:

```bash
docker-compose up    # or docker compose
```


## TODO

1. Variablize data directory
1. Make this repo public
1. Automate backups
