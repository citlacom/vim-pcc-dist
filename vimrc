call pathogen#infect()
map ;z :e ~/.vimrc<CR>
map ;Z :source ~/.vimrc<CR>

" Movement for Spanish keyboard
"noremap ñ l
"noremap l k
"noremap k j
"noremap j h
lang en_US.UTF-8

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

filetype plugin on
" Use the pman PHP doc
autocmd FileType php set keywordprg=~/Sites/contrib/pman-php-manual/bin/pman

" Neocomplete plugin
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#sources#syntax#min_keyword_length = 4
let g:neocomplete#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#enable_fuzzy_completion = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#sources#buffer#max_keyword_width = 200
let g:neocomplete#manual_completion_start_length = 0
let g:neocomplete#max_list = 1000
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 0
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
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
let g:neocomplete#keyword_patterns['php'] = '$\h\w*\%(\[[''"][[:alnum:]_\-#]\+[''"]\]\)*'
let g:neocomplete#keyword_patterns['php'] = '[[:alnum:]_#\$\-\/%''"\[\]]\+'
"let keyword_patterns = {}
"let keyword_patterns._ = '\h\w*'
"let keyword_patterns.php = '[[:alnum:]_\-''"\[\]]\+'
"call neocomplete#custom#source('buffer', 'keyword_patterns', keyword_patterns)
" Pattern for select PHP multi dimension arrays
" \$\h\w*\%(\[['"][[:alnum:]_\-#]\+['"]\]\)\+

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"

" Shell like behavior(not recommended).
set completeopt+=longest
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
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

"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Vim Reload plugin
let g:reload_on_write = 0

" Unite plugin
let g:unite_source_find_max_candidates = 1000
let g:unite_source_rec_max_cache_files = 0
let g:unite_source_grep_max_candidates = 1000
let g:unite_source_history_yank_enable = 1
call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 0)

if !exists('g:unite_source_menu_menus')
  let g:unite_source_menu_menus = {}
endif

let g:unite_source_menu_menus.git = {
    \ 'description' : '            gestionar repositorios git
        \                            ⌘ [espacio]g',
    \}
let g:unite_source_menu_menus.git.command_candidates = [
    \['▷ tig                                                        ⌘ ,gt', 'normal ,gt'],
    \['▷ git status       (Fugitive)                                ⌘ ,gs', 'Gstatus'],
    \['▷ git diff         (Fugitive)                                ⌘ ,gd', 'Gdiff'],
    \['▷ git commit       (Fugitive)                                ⌘ ,gc', 'Gcommit'],
    \['▷ git log          (Fugitive)                                ⌘ ,gl', 'exe "silent Glog | Unite quickfix"'],
    \['▷ git blame        (Fugitive)                                ⌘ ,gb', 'Gblame'],
    \['▷ git stage        (Fugitive)                                ⌘ ,gw', 'Gwrite'],
    \['▷ git checkout     (Fugitive)                                ⌘ ,go', 'Gread'],
    \['▷ git rm           (Fugitive)                                ⌘ ,gr', 'Gremove'],
    \['▷ git mv           (Fugitive)                                ⌘ ,gm', 'exe "Gmove " input("destino: ")'],
    \['▷ git push         (Fugitive, salida por buffer)             ⌘ ,gp', 'Git! push'],
    \['▷ git pull         (Fugitive, salida por buffer)             ⌘ ,gP', 'Git! pull'],
    \['▷ git prompt       (Fugitive, salida por buffer)             ⌘ ,gi', 'exe "Git! " input("comando git: ")'],
    \['▷ git cd           (Fugitive)', 'Gcd'],
    \]

nnoremap <silent>[menu]g :Unite -silent -start-insert menu:git<CR>
nnoremap [unite] <Nop>
nmap f [unite]
"nnoremap <silent> /  :<C-u>Unite -buffer-name=search \ line:forward -start-insert -no-quit<CR>
nnoremap <silent> [unite]cdf  : <C-u>UniteWithCurrentDir -buffer-name=files buffer bookmark file<CR>
nnoremap <silent> [unite]pf   : <C-u>UniteWithProjectDir -buffer-name=files buffer bookmark file<CR>
nnoremap <silent> [unite]bdf  : <C-u>UniteWithBufferDir -buffer-name=files -prompt=%\ buffer bookmark file<CR>
nnoremap <silent> [unite]bdd  : <C-u>UniteWithBufferDir -buffer-name=directories -prompt=%\ directories directory<CR>
nnoremap <silent> [unite]r    : <C-u>UniteResume<CR>
nnoremap <silent> [unite]o    : <C-u>Unite outline<CR>
nnoremap <silent> [unite]b    : <C-u>Unite buffer<CR>
nnoremap <silent> [unite]re   : <C-u>Unite -buffer-name=resume resume<CR>
nnoremap <silent> [unite]li   : <C-u>Unite line<CR>
nnoremap <silent> [unite]ma   : <C-u>Unite mapping<CR>
nnoremap <silent> [unite]me   : <C-u>Unite output:message<CR>
nnoremap <silent> [unite]ch   : <C-u>Unite change<CR>
nnoremap <silent> [unite]ju   : <C-u>Unite jump<CR>
nnoremap <silent> [unite]qf   : <C-u>Unite qf<CR>
nnoremap <silent> [unite]ct   : <C-u>Unite ctags<CR>
nnoremap <silent> [unite]wt   : <C-u>UniteWithCursorWord ctags<CR>
nnoremap <silent> [unite]mf   : <C-u>Unite file_mru<CR>
nnoremap <silent> [unite]md   : <C-u>Unite directory_mru<CR>
nnoremap <silent> [unite]tl   : <C-u>Unite tasklist<CR>
nnoremap <silent> [unite]vc   : <C-u>Unite commands<CR>
nnoremap <silent> [unite]vf   : <C-u>Unite commands<CR>
nnoremap <silent> [unite]vm   : <C-u>Unite mapping<CR>
nnoremap <silent> [unite]vr   : <C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]hc   : <C-u>Unite history/commands<CR>
nnoremap <silent> [unite]hs   : <C-u>Unite history/search<CR>
nnoremap <silent> [unite]hy   : <C-u>Unite history/yank<CR>
" Unite Drupal
nnoremap <silent> [unite]dw   : <C-u>Unite drupal/watchdog<CR>
nnoremap <silent> [unite]dd   : <C-u>Unite drupal/dirs<CR>
nnoremap [unite]f             : <C-u>Unite source<CR>
" Smart Mappings
"imap <buffer><expr><C-f><C-q> unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
"imap <buffer> <C-[> <Plug>(unite_choose_action)
"imap <buffer> <TAB> <Plug>(unite_choose_action)

" Start insert.
let g:unite_enable_start_insert = 1
let g:unite_enable_short_source_names = 1

" Like ctrlp.vim settings.
let g:unite_winheight = 10
let g:unite_split_rule = 'topleft'

" Prompt choices.
let g:unite_prompt = '» '

let g:unite_cursor_line_highlight = 'PmenuSel'
let g:unite_abbr_highlight = 'Pmenu'
let g:unite_source_grep_search_word_highlight = 'Search'
let g:unite_source_line_enable_highlight = 1
let g:unite_source_line_search_word_highlight = 'Search'

" For ack.
if executable('ack')
  let g:unite_source_grep_command = 'ack'
  let g:unite_source_grep_default_opts = '--no-heading --no-color'
  "let g:unite_source_grep_recursive_opt = ''
  "let g:unite_source_grep_default_opts = '-iRHn'
endif

" Unite ctags source
let g:ctags_util#ctags_command = "/usr/local/bin/ctags"

" Unite Tig
let g:unite_tig_default_line_count = 500
let g:unite_tig_default_fold = 1

" Unite Sessions
let g:unite_source_session_options = "blank,buffers,curdir,folds,help,resize,tabpages,winsize"

" Fix debugger encoding issue
python reload(sys)
python sys.setdefaultencoding('big5')

"""""""""""""""""""""""""""
" Easy Motion configuration
"""""""""""""""""""""""""""

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" Move to search char
map  mf <Plug>(easymotion-bd-f)
nmap mf <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map ml <Plug>(easymotion-bd-jk)
nmap ml <Plug>(easymotion-overwin-line)

" Move to word
map  gw <Plug>(easymotion-bd-w)
nmap gw <Plug>(easymotion-overwin-w)

" Line forward / backward movements
map l <Plug>(easymotion-lineforward)
map j <Plug>(easymotion-j)
map k <Plug>(easymotion-k)
map h <Plug>(easymotion-linebackward)
