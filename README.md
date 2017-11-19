# vim-pcc-dist
Custom vim distribution oriented to PHP and Python development.

Dependencies
============

* [Unite](https://github.com/Shougo/unite.vim)
** [NeoMRU](https://github.com/Shougo/neomru.vim)
* [Neocomplete](https://github.com/Shougo/neocomplete.vim)
** [Neoinclude](https://github.com/Shougo/neoinclude.vim)
* [Fugitive](https://github.com/tpope/vim-fugitive)


Code autocompletion
===================

- We have a PHP internal functions dictionary at ./dictionaries/internal_functions_php but if you have extra PHP extensions is recommended that you regenerate using the ./scripts/generate_php_dictionary.php by executing php ./scripts/generate_php_dictionary.php > ./dictionaries/my_internal_functions_php and extending the g:neocomplete#sources#dictionary#dictionaries 'php' dictionaries.

Instructions
============

To use this VIM distribution you need to install the listed dependencies under your .vim/bundle directory, you can git clone each plugin or use [Vundle](https://github.com/VundleVim/Vundle.vim) to automate the process. We will provide a Vundle dependencies file soon.
