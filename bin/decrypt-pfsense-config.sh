#!/bin/bash
# Adapted from https://forum.netgate.com/topic/139561
set -o pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $(basename $0) <encrypted-config>"
    exit 1
fi
inpath="$1"
tmpout="$(mktemp)"

cat "$inpath" \
    | sed -e '1d' -e '$d' \
    | base64 -d \
    | openssl enc -d -aes-256-cbc -salt -md sha256 -pbkdf2 \
    > $tmpout
exitstatus=$?

if [[ $exitstatus -eq 0 ]]; then
    cat $tmpout
fi

rm $tmpout
exit $exitstatus
