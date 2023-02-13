#!/usr/bin/env sh
set -eu

envsubst '${BACK_END_URL}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

exec "$@"