if exists('g:loaded_vim_pcc_dist')
    finish
endif
let g:loaded_vim_pcc_dist = 1

let s:save_cpo = &cpo
set cpo&vim

" Get the current buffer project root via fugitive
" using the project GIT repository as root reference.
" Fugitive plugin is a dependency of this function.
function! vim_pcc_dist#GetBufferProjectRoot()
    let s:project_git_dir = fugitive#extract_git_dir(expand('%:p'))
    " When project is not under version control fugitive returns empty string.
    if s:project_git_dir != ''
        let s:project_root = fnamemodify(s:project_git_dir, ':h')
        return s:project_root
    endif

    echo "The current buffer is not located in a Git repository."
    return ''
endfunction

" Dyamically set dictionary by project repository so you can generate more
" customized dictionaries for different PHP versions or frameworks like Drupal
" Symfony, CakePHP, etc.
function! NeocompleteConfigureCustomProjectDictionaries()
    s:project_root = vim_pcc_dist#GetBufferProjectRoot()
    if s:project_root != ''
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
    endif
endfunction
command! NeoCompleteCustomProjectDictionaries call NeocompleteConfigureCustomProjectDictionaries()

" Get the Drupal container services list.
function! vim_pcc_dist#DrupalContainerExecute()
    let s:project_git_dir = fugitive#extract_git_dir(expand('%:p'))
    if s:project_git_dir != ''
        let s:project_root = fnamemodify(s:project_git_dir, ':h')
        let s:current_dir = fnamemodify(getcwd(), ':p')
        " Move to repository root to run the script
        execute "cd " . s:project_root
        " Run the Unite drupal container source command.
        let s:command = $HOME . '/.vim/bundle/vim-pcc-dist/scripts/drupal_container.pl'
        execute "Unite script:perl:" . s:command . ' -buffer-name=Drupal\ Container -start-insert'
        " Return to original directory.
        execute "cd " . s:current_dir
    endif
endfunction

" Map function call to a command.
command! UniteDrupalContainer call vim_pcc_dist#DrupalContainerExecute()

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
                " Open the class code file in horizontal split.
                execute "new " . s:full_file_path
                return
            endif
        endif
    endfor

    echo printf("Location for %s was not found.", a:full_class)
endfunction

" Provides a list of Behat definitions steps within buffer project.
function! vim_pcc_dist#BehatDefinitions()
    let steps = []
    let output = system('../bin/behat -di')
    if v:shell_error == 0
        for line in filter(split(output, "\n"), 'v:val =~ "Given\\|Then\\|When"')
            execute PPmsg(line)
            "let method = matchstr(source, '::\zs\w\+\ze()')
        endfor
    endif
endfunction

" Finds a Behat executable within current buffer project.
function! vim_pcc_dist#FindBehatBin()
    let s:project_root = vim_pcc_dist#GetBufferProjectRoot()

    " Abort if current buffer is not within a Git repository.
    if s:project_root == ''
        return ''
    endif

    let s:find_cmd = printf('find %s -perm +111 -type f | grep ''/behat$''', s:project_root)
    echom printf("Searching behat bin within buffer project %s", s:project_root)
    let s:bin_candidates = system(s:find_cmd)

    " Looks that the project do not have a local Behat dependency.
    if s:bin_candidates == ''
        echom "Behat bin was not found in the project, you need to
                    \ install behat dependency with composer."
        return ''
    endif

    " We could expect multiples candidates but for simplicity
    " just use the first one for now.
    for candidate in split(s:bin_candidates, "\n")
      return candidate
    endfor
endfunction

" Build PHP tags file for current repository project at root directory and set
" the resulting file as current tags file.
function! vim_pcc_dist#GeneratePhpTags()
    let s:project_root = vim_pcc_dist#GetBufferProjectRoot()
    if s:project_root != ''
        let s:current_dir = fnamemodify(getcwd(), ':p')
        " Move to repository root to generate project tags.
        execute "cd " . s:project_root
        " Generate the PHP tags async.
        let s:cmd = $HOME . '/.vim/bundle/vim-pcc-dist/scripts/build_php_tags.sh'
        call vimproc#system_bg(s:cmd)
        " Set tags to this file.
        let s:tags_file = s:project_root . '/.tags_php'
        let &tags = s:tags_file
        echo printf("Generating file and set tags to: %s", s:tags_file)
        " Return to original directory.
        execute "cd " . s:current_dir
    endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
