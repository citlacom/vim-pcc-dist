let s:save_cpo = &cpo
set cpo&vim

" Dyamically set dictionary by project repository so you can generate more
" customized dictionaries for different PHP versions or frameworks like Drupal
" Symfony, CakePHP, etc.

function! NeocompleteConfigureCustomProjectDictionaries()
  if call fugitive#is_git_dir(expand('%:p'))
    let s:project_root = fnamemodify(fugitive#extract_git_dir(expand('%:p')), ':h')
    let s:dictionaries = join(globpath(s:project_root . '/.dictionaries', '*', 0, 1), ',')
    if has_key(g:neocomplete#sources#dictionary#dictionaries, &l:filetype)
      call remove(g:neocomplete#sources#dictionary#dictionaries, &l:filetype)
    endif
    call neocomplete#set_dictionary_helper(g:neocomplete#sources#dictionary#dictionaries, &l:filetype, s:dictionaries)
    echo neocomplete#sources#dictionary#get_dictionaries(&l:filetype)
  else
    echo "The current buffer is not located in a Git repository."
  endif
endfunction
command! NeocompleteCustomProjectDictionaries call NeocompleteConfigureCustomProjectDictionaries()
