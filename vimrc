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
" Movement for Spanish keyboard
"noremap ñ l
"noremap l k
"noremap k j
"noremap j h

""""""""""""""""""""""""
" VIM core configuration
""""""""""""""""""""""""

lang en_US.UTF-8
" Determine the OS on os variable.
let os = substitute(system('uname'), "\n", "", "")
" Enable syntax colors.
syntax on
let maplocalleader = ','
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
" set "make" command when editing php files for syntax validation
set makeprg=php\ -l\ %
" Format the make errors.
set errorformat=%m\ in\ %f\ on\ line\ %l
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
autocmd FileType php let php_sql_query=0
" Do not show html-syntax inside php.
autocmd FileType php let php_htmlInStrings=0
" Folds functions & methods.
autocmd FileType php let php_folding=1
" Use the pman PHP doc so when pressing K on function name open the PHP manual
" documentation in VIM.
autocmd FileType php set keywordprg=~/Sites/contrib/pman-php-manual/bin/pman
"Enable php completion
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

""""""""""""""""""""""
" Python configuration
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
" Set minimum syntax sources keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 5
" Min length of chars written in order to trigger autocomplete.
let g:neocomplete#auto_completion_start_length = 3
" Buffer names pattern that neocomplete will not complete automatically.
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Enable fuzzy search of suggestion options match, e.x. public_html or
" PublicHtml.
let g:neocomplete#enable_fuzzy_completion = 1
" File size to make a cache of a file.
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
" Number of candidates displayed at suggestions popup.
let g:neocomplete#max_list = 10
" Ignores the upper and lowercase.
let g:neocomplete#enable_ignore_case = 1
" When a capital letter is included in input do not apply ignore case.
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#skip_auto_completion_time = 1
let g:neocomplete#disable_auto_complete = 0
let g:neocomplete#enable_cursor_hold_i = 0
let g:neocomplete#cursor_hold_i_time = 2000
let g:neocomplete#enable_insert_char_pre = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_refresh_always = 1
let g:neocomplete#use_vimproc = 1
"let g:neocomplete#ctags_command
"let g:neocomplete#ctags_arguments
"call neocomplete#custom#source('_', 'matchers', ['matcher_head'])
call neocomplete#custom#source('buffer', 'converters',
            \ ['converter_array_dim', 'remove_lead_trail_quotes', 'converter_remove_last_paren', 'converter_remove_overlap'])
call neocomplete#custom#source('member', 'disabled_filetypes', {'php' : 1})

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ }

if !exists('g:neocomplete#delimiter_patterns')
    let g:neocomplete#delimiter_patterns= {}
endif
let g:neocomplete#delimiter_patterns.php = ['\', '::']

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif

" For PHP only auocomplete variable names.
"let g:neocomplete#keyword_patterns['php'] = '$\h\w*\%(\[[''"][[:alnum:]_\-#]\+[''"]\]\)*'

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

" Enable omni completion for different file types.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

"let g:neocomplete#sources#omni#input_patterns.php = '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
"let g:neocomplete#sources#omni#input_patterns.behat = '\(When\|Then\|Given\|And\)\s.*$'

if !exists('g:neocomplete#sources#member#prefix_patterns')
    let g:neocomplete#sources#member#prefix_patterns = {}
endif

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
call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 5000)

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
" Resume to the last Unite action.
nnoremap <silent> [unite]r : <C-u>UniteResume<CR>
" List a list of current buffer methods, functions and properties.
nnoremap <silent> [unite]o : <C-u>Unite outline<CR>
" List open buffers.
nnoremap <silent> [unite]b : <C-u>Unite buffer<CR>
nnoremap <silent> [unite]re : <C-u>Unite -buffer-name=resume resume<CR>
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
