# vim-pcc-dist
Custom vim distribution oriented to PHP and Python development.

Dependencies
============

# Files and data exploration

* [Unite](https://github.com/Shougo/unite.vim)
* [Unite colorscheme](https://github.com/ujihisa/unite-colorscheme)
* [Unite Grep VCS](https://github.com/lambdalisue/unite-grep-vcs)
* [Unite colorscheme](https://github.com/ujihisa/unite-colorscheme)
* [Unite Outline](https://github.com/Shougo/unite-outline)
* [Unite Session](https://github.com/Shougo/unite-session)
* [Unite Settings](https://github.com/YamasakiKenta/unite-setting.vim)
* [Unite Tag](https://github.com/tsukkee/unite-tag)
* [Unite Tasklist](https://github.com/junkblocker/unite-tasklist)
* [NeoMRU](https://github.com/Shougo/neomru.vim)

# Code auto-completion

* [Neocomplete](https://github.com/Shougo/neocomplete.vim)
* [Neoinclude](https://github.com/Shougo/neoinclude.vim)
* [neopairs](https://github.com/Shougo/neopairs.vim)

# Git integration

* [Fugitive](https://github.com/tpope/vim-fugitive)
* [Git Gutter](https://github.com/airblade/vim-gitgutter)

# Copy / Paste record and historical list

* [YankRing](https://github.com/vim-scripts/YankRing.vim)

# Fast movement, manipulation and insertion

* [easymotion](https://github.com/easymotion/vim-easymotion)
* [nerdcommenter](https://github.com/scrooloose/nerdcommenter)
* [surround](https://github.com/tpope/vim-surround)
* [tabular](https://github.com/godlygeek/tabular)
* [splitjoin](https://github.com/AndrewRadev/splitjoin.vim)
* [matchit](https://github.com/adelarsq/vim-matchit)

# Code snippets

* [ultisnips](https://github.com/SirVer/ultisnips)

# SASS development

* [scss-syntax](https://github.com/cakebaker/scss-syntax.vim)

# PHP development

* [PDV - PHP Documentor](https://github.com/tobyS/pdv)
* [phpcomplete](https://github.com/shawncplus/phpcomplete.vim)
* [PHP Indenting](https://github.com/2072/PHP-Indenting-for-VIm)
* [PHP Refactoring Toolbox](https://github.com/adoy/vim-php-refactoring-toolbox)
* [Behat](https://github.com/veloce/vim-behat)
* [ultisnips-php](https://github.com/algotech/ultisnips-php)

# Python development

* [pydoc](https://github.com/fs111/pydoc.vim)
* [Indent Object](https://github.com/michaeljsmith/vim-indent-object)

# Colors and status line customization

* [Color Schemes Collection](https://github.com/citlacom/vim-colors-collection)
* [airline](https://github.com/vim-airline/vim-airline)

# Drupal develoment

* [Drupal Snippets](https://github.com/dsdeiz/vim-drupal-snippets.git)

# Arduino development

* [Arduino](https://github.com/stevearc/vim-arduino)

# VIM scripts development

* [restart.vim](https://github.com/tyru/restart.vim)
* [VIM Misc](https://github.com/xolox/vim-misc)

Code autocompletion
===================

- We have a PHP internal functions dictionary at ./dictionaries/internal_functions_php but if you have extra PHP extensions is recommended that you regenerate using the ./scripts/generate_php_dictionary.php by executing php ./scripts/generate_php_dictionary.php > ./dictionaries/my_internal_functions_php and extending the g:neocomplete#sources#dictionary#dictionaries 'php' dictionaries.

Instructions
============

To use this VIM distribution you need to install the listed dependencies under your .vim/bundle directory, you can git clone each plugin or use [Vundle](https://github.com/VundleVim/Vundle.vim) to automate the process. We will provide a Vundle dependencies file soon.
