#!/bin/sh
# Small Railway wrapper around the official SiYuan entrypoint.
set -e

# All notes, settings, assets and history live here (a Railway volume).
export SIYUAN_WORKSPACE_PATH="${SIYUAN_WORKSPACE_PATH:-/siyuan/workspace}"
export TZ="${TZ:-UTC}"
export PUID="${PUID:-1000}"
export PGID="${PGID:-1000}"

mkdir -p "$SIYUAN_WORKSPACE_PATH"

# Never start a public instance without a lock-screen password.
if [ -z "$(printf '%s' "${SIYUAN_ACCESS_AUTH_CODE:-}" | tr -d '[:space:]')" ]; then
  echo "SIYUAN_ACCESS_AUTH_CODE is empty. Set it to a long random value; refusing to start an unprotected instance." >&2
  exit 1
fi
case "$(printf '%s' "${SIYUAN_ACCESS_AUTH_CODE_BYPASS:-}" | tr 'A-Z' 'a-z')" in
  1|t|true)
    echo "SIYUAN_ACCESS_AUTH_CODE_BYPASS is set; ignoring it so the instance stays behind the lock screen." >&2
    ;;
esac
unset SIYUAN_ACCESS_AUTH_CODE_BYPASS

# Run one replica only: SiYuan locks its workspace for a single kernel.
exec /opt/siyuan/entrypoint.sh serve "$@"
