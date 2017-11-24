if exists('g:loaded_vim_pcc_dist')
  finish
endif
let g:loaded_vim_pcc_dist = 1

let s:save_cpo = &cpo
set cpo&vim

" Dyamically set dictionary by project repository so you can generate more
" customized dictionaries for different PHP versions or frameworks like Drupal
" Symfony, CakePHP, etc.
function! NeocompleteConfigureCustomProjectDictionaries()
  let s:project_git_dir = fugitive#extract_git_dir(expand('%:p'))
  " When project is not under version control fugitive returns empty string.
  if s:project_git_dir != ''
    let s:project_root = fnamemodify(s:project_git_dir, ':h')
    let s:dictionaries = join(globpath(s:project_root . '/.dictionaries', '*', 0, 1), ',')
    if has_key(g:neocomplete#sources#dictionary#dictionaries, &l:filetype)
      call remove(g:neocomplete#sources#dictionary#dictionaries, &l:filetype)
    endif
    call neocomplete#set_dictionary_helper(g:neocomplete#sources#dictionary#dictionaries, &l:filetype, s:dictionaries)
    " Rebuild the member source dictionary cache.
    call neocomplete#sources#member#remake_cache(&l:filetype)
    " Rebuild the source dictionary cache.
    call neocomplete#sources#dictionary#remake_cache(&l:filetype)
    echo neocomplete#sources#dictionary#get_dictionaries(&l:filetype)
  else
    echo "The current buffer is not located in a Git repository."
  endif
endfunction
command! NeoCompleteCustomProjectDictionaries call NeocompleteConfigureCustomProjectDictionaries()

" Get the Drupal container services list.
function! vim_pcc_dist#DrupalContainerExecute()
  let s:project_git_dir = fugitive#extract_git_dir(expand('%:p'))
  let s:project_root = fnamemodify(s:project_git_dir, ':h')
  if s:project_git_dir != ''
  let command = s:project_root . '/vendor/bin/drupal debug:container | perl -lane ''print "$F[0]\tUnite tag -input=$F[1]"'''
  echo system(command)
endif
endfunction

" Map function call to a command.
command! DrupalContainer call vim_pcc_dist#DrupalContainerExecute()

" Get the file location of a namespaced class.
function! vim_pcc_dist#LocateNamespaceClass(full_class) " {{{
  let s:classname = matchstr(a:full_class, '\\\zs\w\+$')
  let s:namespace = matchstr(a:full_class,'\(\h\w\+\\\)*\w\+\ze\\')
  echom printf("Locating symbol %s on %s namespace.", s:classname, s:namespace)

  if s:classname == ''
      echom printf('The searched namespaced class %s could not be parsed.', a:full_class)
      return ''
  endif

	" Get all candidates with matched name
	let tags = taglist('^'.s:classname.'$')

  for tag in tags
      " Allow to match classes, interfaces and traits.
      if tag.kind == 'c' || tag.kind == 'i' || tag.kind == 't'
          " Skip candidates without namespace.
          if !has_key(tag, 'namespace')
              continue
          endif
          if tolower(s:namespace) == tolower(tag.namespace)
              let s:full_file_path = fnamemodify(tag.filename, ":p")
              echom s:full_file_path
              return s:full_file_path
          endif
      endif
  endfor

  echo printf("Location for %s was not found.", a:full_class)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
