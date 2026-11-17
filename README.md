[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/siyuan-3?utm_medium=integration&utm_source=button&utm_campaign=siyuan)

# SiYuan on Railway

This repo is the source of the **SiYuan** template on Railway. It deploys [SiYuan](https://github.com/siyuan-note/siyuan), a privacy-first, self-hosted knowledge base with block-level references and a Markdown WYSIWYG editor, from the official image `b3log/siyuan`.

- **Version:** SiYuan v3.8.10, pinned as `b3log/siyuan:v3.8.10@sha256:44ee53c45cde3a252c6d913de9b0ff79bf9bb0a5e336e5cc36c06357d6757919`.
- **Service:** one service built from this repo's `Dockerfile`, public on port 6806, health check `GET /api/system/version`.
- **Data:** a Railway volume at `/siyuan/workspace` holds every notebook, asset, setting and snapshot.
- **Login:** SiYuan's lock screen, protected by `SIYUAN_ACCESS_AUTH_CODE` (generated at deploy). The wrapper refuses to start without it and ignores `SIYUAN_ACCESS_AUTH_CODE_BYPASS`.

## Variables

| Variable | Default | What it does |
|---|---|---|
| `SIYUAN_ACCESS_AUTH_CODE` | `${{secret(32)}}` | Lock-screen password. Find it in the service's Variables tab after deploy. |
| `PORT` | `6806` | Port Railway routes the public domain to. SiYuan always listens on 6806 in a container; don't change it. |
| `TZ` | `UTC` | Time zone, as an IANA name such as `Europe/Berlin`. Optional. |

## After deploy

1. Open the service's Variables tab and copy `SIYUAN_ACCESS_AUTH_CODE`.
2. Open the generated `*.up.railway.app` domain and enter it on the lock screen.
3. To change the password, edit the variable and redeploy.

SiYuan's upstream docs list the limits of Docker hosting: browser use only (the desktop and mobile apps can't connect to it), no PDF, HTML or Word export, and no Markdown file import. Run one replica only.

## Updates

When this repo's `main` branch moves to a new SiYuan release, Railway shows deployers an "update available" notice. Read [CHANGELOG.md](CHANGELOG.md) first, take a snapshot or export in SiYuan, then apply the update. Your volume is kept.

## Local test

```sh
docker build -t siyuan-railway .
docker run --rm -p 6806:6806 -e SIYUAN_ACCESS_AUTH_CODE=change-me -v siyuan-data:/siyuan/workspace siyuan-railway
```

SiYuan is licensed AGPL-3.0 by its authors. This wrapper is not affiliated with the SiYuan project.
