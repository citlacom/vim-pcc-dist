""""""""""""""""""""""""
" Pathogen configuration
""""""""""""""""""""""""
call pathogen#infect()

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
" Do not insert a comment leader after an enter or new below line o.
" set formatoptions-=ro
" Sets what is saved when you save a session
set sessionoptions=buffers,help,resize,tabpages,winsize,winpos
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
noremap <localleader>i :set list!<CR>
" Set the current buffer directory as current directory.
map <localleader>pb :cd %:h<CR>
" Set the buffer GIT root as current directory.
map <localleader>pp :Gcd<CR>
" Paste toogle.
nnoremap <localleader>p :set invpaste paste?<CR>
set pastetoggle=<localleader>p
set showmode
" Simplify mappings to on window splits, s(split)dulr(down, up, left, right)
nnoremap <localleader>sd <C-W><C-J>
nnoremap <localleader>su <C-W><C-K>
nnoremap <localleader>sl <C-W><C-K>
nnoremap <localleader>sr <C-W><C-H>
" Close all buffers (quit all).
nnoremap <localleader>qa :bufdo bd%<CR>
" Pretty Formatting mappings
nnoremap <localleader>px : 1,$!tidy -i -xml 2>/dev/null
nnoremap <localleader>ph : 1,$!tidy -i -html 2>/dev/null

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
let g:neocomplete#skip_auto_completion_time = 2
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
" Expire caches every 1 hour, expressed in seconds.
let g:neocomplete#release_cache_time = 3600
" Autoclose preview window automatically.
let g:neocomplete#enable_auto_close_preview = 1
" Fallback on omnicomplete if neocomplete do not found candidates.
let g:neocomplete#fallback_mappings = ["\<C-x>\<C-o>", "\<C-x>\<C-n>"]

" Define filetypes complete dictionaries.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'php' : $HOME.'/.vim/dictionaries/internal_functions_php'
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

" Define PHP prefix patterns for member source that allows namespaces,
" static functions, normal methods and properties and arrays names
" with YAML IDS formats such ['commands.catalog.data.export']
let g:neocomplete#sources#member#prefix_patterns.php = '\.\|->\|::\|\\'

" Use the specified convertes in that order for buffer words candidates.
call neocomplete#custom#source('buffer', 'converters', ['converter_array_dim', 'remove_lead_trail_quotes', 'converter_remove_last_paren', 'converter_remove_overlap'])
" Delimiters of namespaces, class static functions and methods.
let g:neocomplete#delimiter_patterns.php = ['\', '::', '->']
" For PHP only auocomplete variable names.
"let g:neocomplete#keyword_patterns['php'] = '$\h\w*\%(\[[''"][[:alnum:]_\-#]\+[''"]\]\)*'
" Pattern to find compound multidimensional arrays variables and method
" properties on PHP.
"let g:neocomplete#keyword_patterns['php'] = '\h\w*\%\(\[\S*\]\)*'
" Improved PHP keyword patter able to cover multi-dimensional arrays
" as: $entity_info['commerce_coupon']['label callback']
let g:neocomplete#keyword_patterns['php'] = '\h[0-9A-Za-z_\-]*\%\([\[\{][0-9A-Za-z_''"\-\$/% ]*[\]\}]\)*'

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
imap <C-q> <Plug>(neocomplete_start_unite_quick_match)
map <C-k> <Plug>(neocomplete_start_unite_complete)

" Make Neocomplete caches mappings.
"----------------------------------
" Make the element source cache from current buffer and the element cache from
" current buffer filetype dictionaries.
nnoremap <localleader>ce : call neocomplete#sources#member#make_cache_current_buffer() \| call neocomplete#sources#member#remake_cache(&l:filetype)<CR>
" Make the buffer source cache for current buffer.
nnoremap <localleader>cb : call neocomplete#sources#buffer#make_cache('')<CR>
" Make the dictionaries source cache for current buffer filetype.
nnoremap <localleader>cd : call neocomplete#sources#dictionary#remake_cache(&l:filetype)<CR>
" Make the tags source cache for current buffer, the tags cache is only
" enabled in the buffers that have generated the tags cache because in big
" projects the codebase could have thousands of tags.
nnoremap <localleader>ct : call neocomplete#sources#tag#make_cache(1)<CR>
" Switch to buffer project custom dictionaries that could be generated
" to list project specific functions, classes, namespaces, etc.
nnoremap <localleader>cp : NeoCompleteCustomProjectDictionaries<CR>

" Debug Neocomplete mappings.
"----------------------------
nnoremap <localleader>ndi :call neocomplete#init#enable()<CR>
nnoremap <localleader>nds :PP(neocomplete#variables#get_sources())<CR>
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

" Configure the grep tool based on availability and speed performance.
if executable('hw')
    " Use hw (highway)
    " https://github.com/tkengo/highway
    let g:unite_source_grep_command = 'hw'
    let g:unite_source_grep_default_opts = '--no-group --no-color'
    let g:unite_source_grep_recursive_opt = ''
elseif executable('ag')
    " Use ag (the silver searcher)
    " https://github.com/ggreer/the_silver_searcher
    let g:unite_source_grep_command = 'ag'
    "let g:unite_source_grep_default_opts = '--column --nogroup --nocolor --follow --skip-vcs-ignores'
    let g:unite_source_grep_default_opts =
                \ '-i --vimgrep --hidden --ignore ' .
                \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
    " Use ag for rec_async with ignore of VCS rules and hidden files.
    let g:unite_source_rec_async_command =
                \ ['ag', '--follow', '--skip-vcs-ignores', '--nocolor', '--nogroup', '--ignore', '.hg',
                \ '--ignore', '.svn', '--ignore', '.git', '--ignore', '.bzr', '-g', '']
elseif executable('ack-grep')
    " Use ack
    " http://beyondgrep.com/
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts =
                \ '-i --no-heading --no-color -k -H'
    let g:unite_source_grep_recursive_opt = ''
elseif executable('ack')
    let g:unite_source_grep_command = 'ack'
    let g:unite_source_grep_default_opts = '--no-heading --no-color'
    let g:unite_source_grep_recursive_opt = '-r'
    "let g:unite_source_grep_default_opts = '-iRHn'
elseif executable('jvgrep')
    " Use jvgrep
    " https://github.com/mattn/jvgrep
    let g:unite_source_grep_command = 'jvgrep'
    let g:unite_source_grep_default_opts =
                \ '-i --exclude ''\.(git|svn|hg|bzr)'''
    let g:unite_source_grep_recursive_opt = '-R'
endif

"-------------------------------
" Custom Unite sources mappings.
"-------------------------------
" Remove default unite mapping and map 'f' to it.
nnoremap [unite] <Nop>
nmap f [unite]
" List files within the current directory.
nnoremap <silent> [unite]ed : <C-u>UniteWithCurrentDir -buffer-name=files file<CR>
" Recursive list on current project directory to search files.
nnoremap <silent> [unite]ep : <C-u>UniteWithProjectDir -start-insert file_rec/async<CR>
" List files within the current buffer directory.
nnoremap <silent> [unite]bf : <C-u>UniteWithBufferDir -buffer-name=files file<CR>
" List directories within the current buffer directory.
nnoremap <silent> [unite]bd : <C-u>UniteWithBufferDir directories directory<CR>
" List task list buffer tasks: TODO, FIXME, etc.
nnoremap <silent> [unite]bt : <C-u>Unite tasklist<CR>
" Resume to the last Unite action.
nnoremap <silent> [unite]r : <C-u>UniteResume<CR>
" List a list of current buffer methods, functions and properties.
nnoremap <silent> [unite]o : <C-u>Unite outline<CR>
" List open buffers.
nnoremap <silent> [unite]h : <C-u>Unite buffer<CR>
" List all current buffer lines in a filter mode.
nnoremap <silent> [unite]la : <C-u>Unite line<CR>
" List all current buffer lines with cursor word.
nnoremap <silent> [unite]lw : <C-u>UniteWithCursorWord line<CR>
" Start Unite line command with customizable input keyword.
nnoremap <silent> [unite]li : <C-u>UniteWithInput line<CR>
" List all VIM messages in filter mode.
nnoremap <silent> [unite]m : <C-u>Unite output:message<CR>
" List the buffer line changes in filter mode.
nnoremap <silent> [unite]c : <C-u>Unite change<CR>
" List the cursor jumps.
nnoremap <silent> [unite]j : <C-u>Unite jump<CR>
" List the quick fix list.
nnoremap <silent> [unite]q : <C-u>Unite qf<CR>
" List project tags.
nnoremap <silent> [unite]tl : <C-u>Unite tag<CR>
" List current buffer ctags filtering by cursor word.
nnoremap <silent> [unite]tw : <C-u>UniteWithCursorWord tag<CR>
" List ctags filtered by customizable input keyword.
nnoremap <silent> [unite]ti : <C-u>UniteWithInput tag<CR>
" List most recent used files.
nnoremap <silent> [unite]uf : <C-u>Unite file_mru<CR>
" List most recent used directories.
nnoremap <silent> [unite]ud : <C-u>Unite directory_mru<CR>
" List all VIM mappings.
nnoremap <silent> [unite]vm : <C-u>Unite mapping<CR>
" List all VIM registers.
nnoremap <silent> [unite]p : <C-u>Unite -buffer-name=register register<CR>
" List last used VIM commands.
nnoremap <silent> [unite]hc : <C-u>Unite history/command<CR>
" List last used searches.
nnoremap <silent> [unite]hs : <C-u>Unite history/search<CR>
" Go to next used source result item.
nnoremap <silent> [unite]gn : <C-u>UniteNext<CR>
" Go to previous used source result item.
nnoremap <silent> [unite]gp : <C-u>UnitePrevious<CR>
" Start a unite do action for current source items.
nnoremap <silent> [unite]gd : <C-u>UniteDo
" Start a Unite grep search.
nnoremap <silent> [unite]gg : <C-u>Unite grep<CR>
" Start a Unite grep using cursor word.
nnoremap <silent> [unite]gw : <C-u>UniteWithCursorWord grep<CR>
" Unite Drupal
nnoremap <silent> [unite]dw : <C-u>Unite drupal/watchdog<CR>
nnoremap <silent> [unite]dd : <C-u>Unite drupal/dirs<CR>
nnoremap <silent> [unite]ds : <C-u>Unite output:DrupalContainer<CR>
" List all Unite sources.
nnoremap [unite]f : <C-u>Unite source<CR>

""""""""""""""""
" Unite sessions
""""""""""""""""
" Things to include in saved session.
let g:unite_source_session_options = 'buffers,curdir,help,tabpages,winpos,winsize'

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
nnoremap <localleader>lv : call PhpRenameLocalVariable()<CR>
nnoremap <localleader>cv : call PhpRenameClassVariable()<CR>
nnoremap <localleader>rm : call PhpRenameMethod()<CR>
nnoremap <localleader>np : call PhpCreateProperty()<CR>
nnoremap <localleader>du : call PhpDetectUnusedUseStatements()<CR>
vnoremap <localleader>== : call PhpAlignAssigns()<CR>
nnoremap <localleader>sg : call PhpCreateSettersAndGetters()<CR>
nnoremap <localleader>cg : call PhpCreateGetters()<CR>
lnoremap <localleader>da : call PhpDocAll()<CR>
" First ste mode using pastetoggle and run the refactor function.
nnoremap <localleader>eu : <C-U>set formatoptions-=ro\|call PhpExtractUse()\|set formatoptions+=ro<CR>
vnoremap <localleader>ec : <C-U>set formatoptions-=ro\|call PhpExtractConst()\|set formatoptions+=ro<CR>
nnoremap <localleader>ep : <C-U>set formatoptions-=ro\|call PhpExtractClassProperty()\|set formatoptions+=ro<CR>
vnoremap <localleader>em : <C-U>set formatoptions-=ro\|call PhpExtractMethod()\|set formatoptions+=ro<CR>

"""""""""""""""""""""""""
" UltiSnips configuration
"""""""""""""""""""""""""
" Expand the snippet with when hit tab.
let g:UltiSnipsExpandTrigger="<tab>"
" Move within the snippets popup with control-k and control-j.
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
" Open the snippets custom language edit file in horizontal buffer.
let g:UltiSnipsEditSplit="horizontal"
" Custom mapping to open snippets edit buffer.
nnoremap <localleader>se : UltiSnipsEdit<CR>

"""""""""""""""""""""""
" Airline configuration
"""""""""""""""""""""""
let g:airline#extensions#tabline#fnamemod = ':p:~'
let g:airline#extensions#tabline#fnamecollapse = 1

function! AirlineInit()
    " Show current directory under section_b, useful when running grep.
    let g:airline_section_b = airline#section#create(['%{getcwd()}'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

""""""""""""""""""""""""""""""""
" Multiples cursor configuration
""""""""""""""""""""""""""""""""
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-a>'
let g:multi_cursor_prev_key='<C-s>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Following functions avoid Neocomplete completes on multiples cursors by
" switching a lock during multiple cursors usage.
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction
