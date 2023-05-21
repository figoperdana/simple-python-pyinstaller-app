#!/bin/bash
set -e

VOLUME="$(pwd)/sources:/src"
IMAGE="cdrx/pyinstaller-linux:python2"

# Gunakan docker image untuk delivery
docker run --rm -v "${VOLUME}" "${IMAGE}" 'pyinstaller -F add2vals.py'
