""""""""""""""""""""""""
" Pathogen configuration
""""""""""""""""""""""""
call pathogen#infect()

"""""""""""""""""""""""""
" General custom mappings
"""""""""""""""""""""""""
map ;z :e ~/.vimrc<CR>
map ;Z :source ~/.vimrc<CR>
" Exit from insert mode with 'jj'
imap jj <Esc>
" Insert => with hh
imap hh =>
" Move within tabs easily.
map <C-pageup> :tabp<cr>
map <C-pagedown> :tabn<cr>
" Map F2 to Omni Complete
imap <C-f2> <c-x><c-o>
" Toggle invisible chars
noremap ,i :set list!<CR>
" Set the current buffer directory as current directory.
map ,pb :cd %:h<CR>
" Set the buffer GIT root as current directory.
map ,pp :Gcd<CR>
" Paste toogle.
nnoremap ,p :set invpaste paste?<CR>
set pastetoggle=,p
set showmode

""""""""""""""""""""""""
" VIM core configuration
""""""""""""""""""""""""
lang en_US.UTF-8
" Determine the OS on os variable.
let os = substitute(system('uname'), "\n", "", "")
" Enable syntax colors.
syntax on
" Customize leader.
let mapleader = "."
" Customize local leader.
let maplocalleader = ','
" No vi compatible.
set nocompatible
set history=200
set complete=.,w,b,u,t
" Status Line
set ruler
set number
set showcmd
set ch=2 " Make command line two lines high
" Will produce the tabstop number of spaces.
set expandtab
" Number of spaces for expandtab.
set tabstop=2
" Number of spaces for the indent operations > <.
set shiftwidth=4
" Milliseconds that is waited for a key code or mapped key sequence to
" complete.
set timeoutlen=500
" When search is scrolling to the right this is the number of cols to keep
" visible at the left.
set sidescrolloff=0
" When search, number of lines to keep from the top and bottom.
set scrolloff=10
" Number of cols for the left lines count.
set numberwidth=4
" Multiple windows, when created, are equal in size.
set equalalways
" By default new window is open above (horizontal split) and left (vertical
" split) so this switch that behavior to below and right.
set splitbelow nosplitright
" Higling cursor line.
set cursorline
" Highlight search results.
set hlsearch
" Incremental search, search while typing.
set incsearch
" Ignore case when searching.
set ignorecase
" Ignore case when searching lowercase.
set smartcase
" Allow to undo changes even after restart VIM.
set undofile
set undodir=/tmp
" Set font type.
set guifont=Menlo:h15.00
" Enable backups.
set backup
set backupdir=/tmp
" Set Swap directory
set directory=/tmp
" File Stuff ******************************************************************
filetype plugin indent on
" Do not insert a comment leader after an enter.
set fo-=r
" Sets what is saved when you save a session
set sessionoptions=buffers,curdir,folds,help,resize,tabpages,winsize
" Misc ************************************************************************
set backspace=indent,eol,start
" Add <> chat to match pairs.
set matchpairs+=<:>
" Configure to 256 colors.
set t_Co=256
" Invisible characters.
set listchars=trail:.,tab:>-,eol:$

" Rezide window to full-screen on GUI mode.
if has("gui_running")
  " Maximize gvim window.
  set lines=999 columns=999
  " Custom colors config file.
  colors wombat
endif

""""""""""""""""""""""""""""
" File types configurations.
""""""""""""""""""""""""""""
" Enable filetype plugins.
filetype plugin on

"---------
" PHP type
"---------
" Do not show sql-syntax highlighting inside php.
"let g:php_sql_query=1
" Do not show html-syntax inside php.
"let g:php_htmlInStrings=1
" Highlighting parent error
"let g:php_parent_error_close=1
"let g:php_parent_error_open=1
" Folds classes and funcions.
let g:php_folding=0
" Sync from start
let g:php_sync_method=0
" Highlight functions with abnormal behaviour.
let g:php_special_functions=0
" Comparison operators in an alternate colour.
let g:php_alt_comparisons=0
" References in alternate colour.
let g:php_alt_assignByReference=0
" Use the pman PHP doc so when pressing K on function name open the PHP manual
" documentation in VIM.
autocmd FileType php set keywordprg=~/Sites/contrib/pman-php-manual/bin/pman
" Enable drupal code snippets for PHP files.
autocmd FileType php UltiSnipsAddFiletypes drupal

augroup php
  autocmd bufread,bufnewfile,bufenter *.tpl.php set filetype=html
  " No more needed, VIM 8 properly auto detects PHP code when start with <?php
  " tag. Uncomment if you have problems with notn standard PHP file extensions.
  "autocmd bufread,bufnewfile,bufenter *.install set filetype=php
  "autocmd bufread,bufnewfile,bufenter *.theme set filetype=php
  "autocmd bufread,bufnewfile,bufenter *.module set filetype=php
augroup end

" Set PHP make and error format syntax validation
autocmd FileType php set makeprg=php\ -l\ %
autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l

"-----------
"Python type
"-----------
augroup python
  autocmd BufRead,BufNewFile,BufEnter *.py set filetype=python
augroup END

" Set make and error format syntax validation
autocmd FileType python set makeprg=pylint\ -r\ y\ %
autocmd FileType python set errorformat=%+P[%f],%t:\ %#%l:%m,%Z,%+IYour\ code%m,%Z,%-G%.%#

"""""""""""""""""""""""""""""""
" Omni Completion configuration
"""""""""""""""""""""""""""""""
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

""""""""""""""""""""""
" Python plugins fixes
""""""""""""""""""""""
python << EOF
import os
import sys
import vim
for p in sys.path:
    # Add each directory in sys.path, if it exists.
    if os.path.isdir(p):
        # Command 'set' needs backslash before each space.
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

" Fix debugger encoding issue
python reload(sys)
python sys.setdefaultencoding('big5')

"""""""""""""""""""""""""""
" Neocomplete configuration
"""""""""""""""""""""""""""
" Use neocomplete
let g:neocomplete#enable_at_startup = 1
" General min keyword length for the suggestions.
let g:neocomplete#min_keyword_length = 5
" Set minimum target keyword length for syntax and buffer sources.
let g:neocomplete#sources#syntax#min_keyword_length = 5
let g:neocomplete#sources#buffer#min_keyword_length = 5
" Set a big maximum for buffer for the multi-dimensional array names.
let g:neocomplete#sources#buffer#max_keyword_width = 200
" Min length of chars written in order to trigger autocomplete.
let g:neocomplete#auto_completion_start_length = 3
" Buffer names pattern that neocomplete will not complete automatically.
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Enable fuzzy search of suggestion options match, e.x. public_html or
" PublicHtml.
let g:neocomplete#enable_fuzzy_completion = 1
" Wait milliseconds after last typed char to start autocomplete.
let g:neocomplete#auto_complete_delay = 250
" File size to make a cache of a file.
let g:neocomplete#sources#buffer#cache_limit_size = 100*1024*1024
" Number of candidates displayed at suggestions popup.
let g:neocomplete#max_list = 1000
" Ignores the upper and lowercase.
let g:neocomplete#enable_ignore_case = 1
" When a capital letter is included in input do not apply ignore case.
let g:neocomplete#enable_smart_case = 1
" If completion takes longer than this seconds autocomplete is skip.
let g:neocomplete#skip_auto_completion_time = 3
" Ensure autocompletion is not disabled.
let g:neocomplete#disable_auto_complete = 0
" Enable camel case candidates match.
let g:neocomplete#enable_camel_case = 1
" Select the first candidate element automatically.
let g:neocomplete#enable_auto_select = 1
" Enable auto-insert delimiter on sources that use delimiters (as files source).
let g:neocomplete#enable_auto_delimiter = 1
" If enabled will refresh search results as you type and completion delay
" exceed, when not enabled just narrow match on existing results.
let g:neocomplete#enable_refresh_always = 0
" Will make cache async using vimproc plugin.
let g:neocomplete#use_vimproc = 1

" Define dictionaries dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \ }

" Define delimiter patterns dictionary.
if !exists('g:neocomplete#delimiter_patterns')
    let g:neocomplete#delimiter_patterns= {}
endif

" Define keyword patterns dictionary.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

" Define member source prefix patterns dictionary.
if !exists('g:neocomplete#sources#member#prefix_patterns')
    let g:neocomplete#sources#member#prefix_patterns = {}
endif

" Use the specified convertes in that order for buffer words candidates.
call neocomplete#custom#source('buffer', 'converters', ['converter_array_dim', 'remove_lead_trail_quotes', 'converter_remove_last_paren', 'converter_remove_overlap'])
" Try to complete methods, namespaces, and multi-dimensional arrays based on
" context words via converter_delimiter filter.
let g:neocomplete#delimiter_patterns.php = ['\', '::', '->', '[''', '[']
" For PHP only auocomplete variable names.
"let g:neocomplete#keyword_patterns['php'] = '$\h\w*\%(\[[''"][[:alnum:]_\-#]\+[''"]\]\)*'
" Pattern to find compound multidimensional arrays variables and method
" properties on PHP.
let g:neocomplete#keyword_patterns['php'] = '\h\w*\%\(\[\S*\]\)*'

"let g:neocomplete#sources#omni#input_patterns.php = '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
"let g:neocomplete#sources#omni#input_patterns.behat = '\(When\|Then\|Given\|And\)\s.*$'

" Undo the inserted completion.
inoremap <expr><C-g> neocomplete#undo_completion()
" When multiples suggestions have common string part, complete until the common
" part: my_sun, my_moon, my_real will result completing 'my_' common part.
inoremap <expr><C-l> neocomplete#complete_common_string()
" Close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" Close using completion selection.
inoremap <expr><C-y> neocomplete#close_popup()
" Close canceling the suggested completion.
inoremap <expr><C-e> neocomplete#cancel_popup()
" Enable neocomplete quick match and complete with Unite.
imap <C-q>  <Plug>(neocomplete_start_unite_quick_match)
map <C-k>  <Plug>(neocomplete_start_unite_complete)
" Debug Neocomplete mappings.
nnoremap <localleader>ni :call neocomplete#init#enable()<CR>
nnoremap <localleader>ns :PP(neocomplete#variables#get_sources())<CR>
"let g:neocomplete#enable_debug=1
" LUA fix: line = line:gsub("'(%p-)'", "\\'")

"""""""""""""""""""""
" Unite configuration
"""""""""""""""""""""
let g:unite_source_find_max_candidates = 1000
let g:unite_source_rec_max_cache_files = 0
let g:unite_source_grep_max_candidates = 1000
let g:unite_source_history_yank_enable = 1
" Start insert.
let g:unite_enable_start_insert = 1
let g:unite_enable_short_source_names = 1
" Unite window height.
let g:unite_winheight = 15
" Position of the Unite buffer.
let g:unite_split_rule = 'topleft'
" Prompt start char.
let g:unite_prompt = '» '
let g:unite_cursor_line_highlight = 'PmenuSel'
let g:unite_abbr_highlight = 'Pmenu'
let g:unite_source_grep_search_word_highlight = 'Search'
let g:unite_source_line_enable_highlight = 1
let g:unite_source_line_search_word_highlight = 'Search'
" Unite ctags source
let g:ctags_util#ctags_command = "/usr/local/bin/ctags"
" Unite Tig
let g:unite_tig_default_line_count = 500
let g:unite_tig_default_fold = 1
" Unite Sessions
let g:unite_source_session_options = "blank,buffers,curdir,folds,help,resize,tabpages,winsize"
" Limit the number candidates list for file recursive and file recursive async.
call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 500)
" Congirue 'ag' for search and files list.
if executable('ag')
  " Configure ag for rec_async sources to respect the version control ignores
  " and hidden files.
  let g:unite_source_rec_async_command =
        \ ['ag', '--follow', '--skip-vcs-ignores', '--nocolor', '--nogroup', '--ignore', '.hg',
        \ '--ignore', '.svn', '--ignore', '.git', '--ignore', '.bzr', '-g', '']
  " Also use ag for files search.
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--column --nogroup --nocolor --follow --skip-vcs-ignores'
  let g:unite_source_grep_recursive_opt = ''
endif

"-------------------------------
" Custom Unite sources mappings.
"-------------------------------
" Remove default unite mapping and map 'f' to it.
nnoremap [unite] <Nop>
nmap f [unite]
" List files within the current directory.
nnoremap <silent> [unite]cdf : <C-u>UniteWithCurrentDir -buffer-name=files file<CR>
" List files within the current buffer directory.
nnoremap <silent> [unite]bdf : <C-u>UniteWithBufferDir -buffer-name=files -prompt=%\ file<CR>
" List directories within the current buffer directory.
nnoremap <silent> [unite]bdd : <C-u>UniteWithBufferDir -buffer-name=directories -prompt=%\ directories directory<CR>
" Recursive list on current project directory to search files.
nnoremap <silent> [unite]e : <C-u>UniteWithProjectDir -start-insert file_rec/async<CR>
" Resume to the last Unite action.
nnoremap <silent> [unite]r : <C-u>UniteResume<CR>
" List a list of current buffer methods, functions and properties.
nnoremap <silent> [unite]o : <C-u>Unite outline<CR>
" List open buffers.
nnoremap <silent> [unite]b : <C-u>Unite buffer<CR>
" List all current buffer lines in a filter mode.
nnoremap <silent> [unite]li : <C-u>Unite line<CR>
" List all VIM messages in filter mode.
nnoremap <silent> [unite]me : <C-u>Unite output:message<CR>
" List the buffer line changes in filter mode.
nnoremap <silent> [unite]ch : <C-u>Unite change<CR>
" List the cursor jumps.
nnoremap <silent> [unite]ju : <C-u>Unite jump<CR>
" List the quick fix list.
nnoremap <silent> [unite]qf : <C-u>Unite qf<CR>
" List current buffer ctags.
nnoremap <silent> [unite]ct : <C-u>Unite ctags<CR>
" List current buffer ctags filtering by cursor word.
nnoremap <silent> [unite]wt : <C-u>UniteWithCursorWord ctags<CR>
" List most recent used files.
nnoremap <silent> [unite]mf : <C-u>Unite file_mru<CR>
" List most recent used directories.
nnoremap <silent> [unite]md : <C-u>Unite directory_mru<CR>
" List task list of TODO, FIXME, etc.
nnoremap <silent> [unite]tl : <C-u>Unite tasklist<CR>
" List all VIM mappings.
nnoremap <silent> [unite]vm : <C-u>Unite mapping<CR>
" List all VIM registers.
nnoremap <silent> [unite]vr : <C-u>Unite -buffer-name=register register<CR>
" List last used VIM commands.
nnoremap <silent> [unite]hc : <C-u>Unite history/command<CR>
" List last used searches.
nnoremap <silent> [unite]hs : <C-u>Unite history/search<CR>
" Go to next unite item on last used source.
nnoremap <silent> [unite]n : <C-u>UniteNext<CR>
" Go to previous unite item on last used source.
nnoremap <silent> [unite]p : <C-u>UnitePrevious<CR>
" Unite Drupal
nnoremap <silent> [unite]dw : <C-u>Unite drupal/watchdog<CR>
nnoremap <silent> [unite]dd : <C-u>Unite drupal/dirs<CR>
" List all Unite sources.
nnoremap [unite]f : <C-u>Unite source<CR>

"""""""""""""""""""
" Ack configuration
"""""""""""""""""""
if executable('ack')
    let g:unite_source_grep_command = 'ack'
    let g:unite_source_grep_default_opts = '--no-heading --no-color'
    "let g:unite_source_grep_recursive_opt = ''
    "let g:unite_source_grep_default_opts = '-iRHn'
endif

"""""""""""""""""""""""""""
" Easy Motion configuration
"""""""""""""""""""""""""""
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" Move to search 1 char pattern.
map mf <Plug>(easymotion-bd-f)
nmap mf <Plug>(easymotion-overwin-f)
" Move to search 2 chars pattern.
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map ml <Plug>(easymotion-bd-jk)
nmap ml <Plug>(easymotion-overwin-line)
" Move to word
map gw <Plug>(easymotion-bd-w)
nmap gw <Plug>(easymotion-overwin-w)
" Line forward / backward movements
map l <Plug>(easymotion-lineforward)
map j <Plug>(easymotion-k)
map k <Plug>(easymotion-j)
map h <Plug>(easymotion-linebackward)
" Movement for Spanish keyboard
map ñ <Plug>(easymotion-linebackward)

"""""""""""""""""""""""""""
" phpcomplete configuration
"""""""""""""""""""""""""""
let g:phpcomplete_cache_taglists = 0
let g:phpcomplete_enhance_jump_to_definition = 1
let g:phpcomplete_cache_taglists = 1
let g:phpcomplete_mappings = {
      \'jump_to_def': 'zx',
      \'jump_to_def_split': 'zc',
      \'jump_to_def_vsplit': 'zv',
      \}

""""""""""""""""""""""""""""""""""""
" PDV PHP Documentator configuration
""""""""""""""""""""""""""""""""""""
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
" Custom PDV mapping.
nnoremap ,d :call pdv#DocumentWithSnip()<CR>

"""""""""""""""""""""""""""""""""""""""
" Php Refactoring Toolbox configuration
"""""""""""""""""""""""""""""""""""""""
" Disable custom mappings.
let g:vim_php_refactoring_use_default_mapping = 0
" Customize the refactor function mappings..
nnoremap <unique> <localleader>rlv : PhpRenameLocalVariable()<CR>
nnoremap <unique> <localleader>rcv : PhpRenameClassVariable()<CR>
nnoremap <unique> <localleader>rm : PhpRenameMethod()<CR>
nnoremap <unique> <localleader>np : PhpCreateProperty()<CR>
nnoremap <unique> <localleader>du : PhpDetectUnusedUseStatements()<CR>
vnoremap <unique> <localleader>== : PhpAlignAssigns()<CR>
nnoremap <unique> <localleader>sg : PhpCreateSettersAndGetters()<CR>
nnoremap <unique> <localleader>cog : PhpCreateGetters()<CR>
lnoremap <unique> <localleader>da : PhpDocAll()<CR>
" First switch paste mode using pastetoggle and run the refactor function.
nnoremap <unique> <localleader>eu : normal ,p<CR> : PhpExtractUse()<CR>
vnoremap <unique> <localleader>ec : normal ,p<CR> : PhpExtractConst()<CR>
nnoremap <unique> <localleader>ep : normal ,p<CR> : PhpExtractClassProperty()<CR>
vnoremap <unique> <localleader>em : normal ,p<CR> : PhpExtractMethod()<CR>
