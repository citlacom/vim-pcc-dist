#!/bin/bash

# Some VIM features depend on external tools that are used via
# system calls, here we attempt to automate the installation
# of those dependencies.
##############################################################

if ! command -v perl >/dev/null 2>&1; then
    echo >&2 "perl is not available, trying to install with brew."
    brew install perl
fi

if [[ $? -ne 0 ]]; then
    echo "perl installation failed, please try to install manually."
    exit 1;
fi

# Install perl critic, used for Perl coding standard.
cpan Perl::Critic

# NOTE: Drupal code is only compatible with squizlabs/php_codesniffer: >=2.8.1 <3.0
# so in case there is a recent installed version will cause a conflict.
# Install Drupal Coder that provides Drupal coding standard.
composer global require drupal/coder:^8.2.12
# Install PHP_CodeSniffer coding standards (rulesets).
composer global require dealerdirect/phpcodesniffer-composer-installer

# TODO: Handle a validation to check if there is a installed coder_sniffer.
# TODO: Automatically add composer directory to PATH environment var.
#export PATH="$PATH:$HOME/.composer/vendor/bin"

# TODO: Handle installation of bash completion which is very useful complement.
# stecman/composer-bash-completion-plugin
# bamarni/symfony-console-autocomplete

# Install Universal Ctags which has better PHP parsing than Exuberan Ctags and
# is under active maintainance.
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags
