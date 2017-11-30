#!/usr/bin/env bash

# Remove existing tags file.
rm -rf .tags_js
# Create JS tags.
/usr/local/bin/ctags -R -V -o .tags_js --fields=+afmikKlnsStzd --languages=javascript --totals=yes --sort=yes
