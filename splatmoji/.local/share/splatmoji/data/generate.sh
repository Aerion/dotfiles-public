#!/bin/sh
curl -s 'https://raw.githubusercontent.com/carloscuesta/gitmoji/master/src/data/gitmojis.json' | jq -r '.gitmojis | map([.emoji, .description, .name])[] | @tsv' > gitmojis.tsv
