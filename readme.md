# smk's mod development setup

## build image

```bash
docker compose build luanti
```

## accessing database

```bash
# get a shell
docker exec -it postgres_db bash

# login into the database
psql -U smk -d prismo

# list tables
\dt
```

## development workflow

```bash
# clone mod
git clone <repo_url> mods/<mod_name>

# start development environment
docker compose up -d

# run luanti commands on local to access the server
/Applications/MultiCraft.app/Contents/MacOS/MultiCraft --address 127.0.0.1 --port 30000 --name smk_normal --password 1234 --go --quiet
```