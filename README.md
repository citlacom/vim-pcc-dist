# vim-pcc-dist
Custom vim distribution oriented to PHP and Python development.

Dependencies
============

* [Unite](https://github.com/Shougo/unite.vim)
* * [Unite colorscheme](https://github.com/ujihisa/unite-colorscheme)
* * [Unite Grep VCS](https://github.com/lambdalisue/unite-grep-vcs)
* * [NeoMRU](https://github.com/Shougo/neomru.vim)
* [Neocomplete](https://github.com/Shougo/neocomplete.vim)
* * [Neoinclude](https://github.com/Shougo/neoinclude.vim)
* * [neopairs](https://github.com/Shougo/neopairs.vim)
* [Fugitive](https://github.com/tpope/vim-fugitive)
* [PDV - PHP Documentor](https://github.com/tobyS/pdv)
* [phpcomplete](https://github.com/shawncplus/phpcomplete.vim)
* [PHP Indenting](https://github.com/2072/PHP-Indenting-for-VIm)
* [YankRing](https://github.com/vim-scripts/YankRing.vim)
* [easymotion](https://github.com/easymotion/vim-easymotion)
* [nerdcommenter](https://github.com/scrooloose/nerdcommenter)
* [scss-syntax](https://github.com/cakebaker/scss-syntax.vim)
* [splitjoin](https://github.com/AndrewRadev/splitjoin.vim)
* [airline](https://github.com/vim-airline/vim-airline)
* [pydoc](https://github.com/fs111/pydoc.vim)
* [surround](https://github.com/tpope/vim-surround)
* [tabular](https://github.com/godlygeek/tabular)
* [ultisnips](https://github.com/SirVer/ultisnips)
* * [ultisnips-php](https://github.com/algotech/ultisnips-php)

VIM scripts development
=======================

* [restart.vim](https://github.com/tyru/restart.vim)

Code autocompletion
===================

- We have a PHP internal functions dictionary at ./dictionaries/internal_functions_php but if you have extra PHP extensions is recommended that you regenerate using the ./scripts/generate_php_dictionary.php by executing php ./scripts/generate_php_dictionary.php > ./dictionaries/my_internal_functions_php and extending the g:neocomplete#sources#dictionary#dictionaries 'php' dictionaries.

Instructions
============

To use this VIM distribution you need to install the listed dependencies under your .vim/bundle directory, you can git clone each plugin or use [Vundle](https://github.com/VundleVim/Vundle.vim) to automate the process. We will provide a Vundle dependencies file soon.
