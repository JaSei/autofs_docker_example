#!/bin/bash
set -e

automount /etc/auto.master

exec /app/some_application $@
