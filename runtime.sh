#!/bin/sh
set -e
socat TCP4-LISTEN:41182,fork TCP4:127.0.0.1:41184 &

if [ -f '/joplin/options.json' ]; then
   jq --raw-output '. | to_entries | .[] | "/usr/local/bin/joplin --profile /joplin/profile config " + .key + " \"" + .value + "\""' /joplin/options.json > /tmp/setoptions.sh
   sh /tmp/setoptions.sh
fi

/usr/local/bin/joplin --profile /joplin/profile $@
