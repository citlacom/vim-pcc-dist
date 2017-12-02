#!/usr/bin/env bash

# Remove existing tags file.
rm -rf .tags_php
# Create the PHP tags including Drupal custom PHP extensions.
ctags -R -o .tags_php --fields=+aimlS --langmap="php:+.inc.module.install.php" --languages=php --links=no --totals=yes --sort=yes
