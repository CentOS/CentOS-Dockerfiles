#!/usr/bin/env bash
# Fix permissions on the given directory to allow group read/write of
# regular files and execute of directories.
set -eux
find "$1" -exec chown ${2} {} \;
find "$1" -exec chgrp 0 {} \;
find "$1" -exec chmod g+rw {} \;
find "$1" -type d -exec chmod g+x {} +