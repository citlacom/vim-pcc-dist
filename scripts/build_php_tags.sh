#!/usr/bin/env bash

# Remove existing tags file.
rm -rf .tags_php
# Create the PHP tags including Drupal custom PHP extensions.
/usr/local/bin/ctags -R -V -o .tags_php --fields=+aimlS --langmap="php:+.inc.module.install.php" --languages="php" --totals=yes --sort=yes
