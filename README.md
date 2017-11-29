# vim-pcc-dist

Custom vim distribution oriented to PHP and Python development.

# Plugins

## Code styling

* [EditorConfig](https://github.com/editorconfig/editorconfig-vim)

## Code auto-completion

* [Neocomplete](https://github.com/Shougo/neocomplete.vim)
* [Neoinclude](https://github.com/Shougo/neoinclude.vim)
* [neopairs](https://github.com/Shougo/neopairs.vim)
* [Emmet Autocompleter](https://github.com/TaDaa/vim-emmet-autocompleter)

## Code validation

* [Syntastic](https://github.com/vim-syntastic/syntastic)
* [vimlint](https://github.com/syngan/vim-vimlint)
* [vimlparser](https://github.com/vim-jp/vim-vimlparser)

## Files and data exploration

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

## Git integration

* [Fugitive](https://github.com/tpope/vim-fugitive)
* [Fugitive Github](https://github.com/tpope/vim-rhubarb)
* [Git Gutter](https://github.com/airblade/vim-gitgutter)

## Copy / Paste record and historical list

* [YankRing](https://github.com/vim-scripts/YankRing.vim)

## Fast movement, manipulation, repetition and insertion

* [easymotion](https://github.com/easymotion/vim-easymotion)
* [nerdcommenter](https://github.com/scrooloose/nerdcommenter)
* [surround](https://github.com/tpope/vim-surround)
* [tabular](https://github.com/godlygeek/tabular)
* [splitjoin](https://github.com/AndrewRadev/splitjoin.vim)
* [matchit](https://github.com/adelarsq/vim-matchit)
* [qfreplace](https://github.com/thinca/vim-qfreplace)
* [repeat](https://github.com/tpope/vim-repeat)
* [unimpaired](https://github.com/tpope/vim-unimpaired)
* [hardmode](https://github.com/wikitopian/hardmode)

## Colors and status line customization

* [Color Schemes Collection](https://github.com/citlacom/vim-colors-collection)
* [airline](https://github.com/vim-airline/vim-airline)

## Code snippets

* [ultisnips](https://github.com/SirVer/ultisnips)
* [Snippets Mixed Languages](https://github.com/honza/vim-snippets)
* [Snippets Drupal](https://github.com/dsdeiz/vim-drupal-snippets.git)
* [Snippets PHP](https://github.com/algotech/ultisnips-php)
* [Snippets React](https://github.com/epilande/vim-react-snippets)

## SASS development

* [scss-syntax](https://github.com/cakebaker/scss-syntax.vim)

## HTML development

* [emmet](https://github.com/mattn/emmet-vim)

## PHP development

* [PDV - PHP Documentor](https://github.com/tobyS/pdv)
* [phpcomplete](https://github.com/shawncplus/phpcomplete.vim)
* [PHP Indenting](https://github.com/2072/PHP-Indenting-for-VIm)
* [PHP Refactoring Toolbox](https://github.com/adoy/vim-php-refactoring-toolbox)
* [PHP namespace](https://github.com/arnaud-lb/vim-php-namespace)
* [Behat](https://github.com/veloce/vim-behat)
* [Twig](https://github.com/lumiliet/vim-twig)

## Python development

* [pydoc](https://github.com/fs111/pydoc.vim)
* [Indent Object](https://github.com/michaeljsmith/vim-indent-object)

## C / C++ development

* [clang complete](https://github.com/Rip-Rip/clang_complete)

## Arduino development

* [Arduino](https://github.com/stevearc/vim-arduino)

## VIM scripts development

* [restart.vim](https://github.com/tyru/restart.vim)
* [VIM Misc](https://github.com/xolox/vim-misc)
* [PrettyPrint](https://github.com/thinca/vim-prettyprint)
* [Reload](https://github.com/xolox/vim-reload)
* [Scriptease](https://github.com/tpope/vim-scriptease)

## DevOps (configuration files)

* [Dockerfile](https://github.com/ekalinin/Dockerfile.vim)
* [Ansible](https://github.com/pearofducks/ansible-vim)

## Documentation

* [Markdown](https://github.com/plasticboy/vim-markdown)

# Code autocompletion

- We have a PHP internal functions dictionary at ./dictionaries/internal_functions_php but if you have extra PHP extensions is recommended that you regenerate using the ./scripts/generate_php_dictionary.php by executing php ./scripts/generate_php_dictionary.php > ./dictionaries/my_internal_functions_php and extending the g:neocomplete#sources#dictionary#dictionaries 'php' dictionaries.

# Instructions

To use this VIM distribution you need to install the listed dependencies under your .vim/bundle directory, you can git clone each plugin or use [Vundle](https://github.com/VundleVim/Vundle.vim) to automate the process. We will provide a Vundle dependencies file soon.
