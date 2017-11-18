# vim-pcc-dist
Custom vim distribution oriented to PHP and Python development.

Dependencies
============

- [Unite](https://github.com/Shougo/unite.vim)
- [Neocomplete](https://github.com/Shougo/neocomplete.vim)

Code autocompletion
===================

- We have a PHP internal functions dictionary at ./dictionaries/internal_functions_php but if you have extra PHP extensions is recommended that you regenerate using the ./scripts/generate_php_dictionary.php by executing php ./scripts/generate_php_dictionary.php > ./dictionaries/my_internal_functions_php and extending the g:neocomplete#sources#dictionary#dictionaries 'php' dictionaries.
