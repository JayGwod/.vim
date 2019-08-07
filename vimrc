" ----- Encoding Scheme -----
set enc=utf8
" 去掉BOM标记
set nobomb

" ----- Color Scheme -----
" extends the color scheme's background color to the whole terminal screen
set term=screen-256color
colorscheme molokai                      " 默认配色方案
if (has("termguicolors"))
	" set Vim-specific sequences for RGB colors
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" 
	set termguicolors                      " True Colors
	" 更好的配色方案
	" colorscheme material-theme            
	colorscheme solarized8_flat
endif
set background=dark                      " light 为亮色方案
syntax enable                            " 打开语法高亮

" ----- Status Line -----
set laststatus=2                         " 显示状态行
set noshowmode                           " get rid of -- INSERT --
set showtabline=2                        " forces the tabline to always show

" ----- Tab & Spaces -----
set shiftwidth=2                         " 自动缩进所使用的空白长度
set tabstop=2                            " number of visual spaces per TAB
set softtabstop=2                        " number of spaces in tab when editing
set expandtab                            " tabs are spaces
set autoindent                           " 设置自动缩进
" 解决插入模式下delete/backspce键失效问题
set backspace=2

" ----- Searching -----
set number                               " 打开行号
set is hls                               " highlight matches
" press return to temporarily get out of the highlighted search
:nnoremap <CR> :nohlsearch<CR><CR>
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" ----- Spell & Length Checking -----
set spell spelllang=en,cjk               " cjk 同时针对中日两种文字的写法
set colorcolumn=81                       " 设置超过80长度提示

" ----- Split Layouts -----
set splitbelow
set splitright

" ----- Conceal Modes -----
set concealcursor=

" ----- undo/redo -----
" 在你的 vimrc 加入
set undofile                             " Maintain undo history between sessions
" 设置你的undo保存位置，你需要先 mkdir ~/.vim/undodir
set undodir=~/.vim/undodir

" ----- Preview Setting -----
set completeopt=menu                     " prevent the pymode window from opening

" ----- Folding Setting -----
set foldmethod=manual                    " 启用手工折叠

"----- Keyboard Shortcuts -----
" Find the file in the NERDTree window
nmap <F5> :NERDTreeFind<CR>
" F6 key will toggle the NERDTree window
nmap <F6> :NERDTreeToggle<CR>
" 按功能键<F9>进入粘贴模式
set pastetoggle=<F9>
" <F10> run python code
let g:pymode_run_bind = '<F10>'
" F11 key will toggle the Tagbar window
nmap <F11> :TagbarToggle<CR>
" 用 <F12> 在当前窗口下面打开一个终端
noremap <F12> :below term<cr>
" 生成pdf文件
" 默认情况下，生成的 PDF 不含目录，同时各级标题不含编号，仅仅字体大小有变化，
" 要给各个 section 加上编号，可以用 --number-sections 选项；加上目录，可以使用 --toc 选项。
" 使用默认设置生成的 PDF margin 太大，根据 Pandoc 官方
" FAQ，可以使用下面的选项更改 margin：
" -V geometry:"top=2cm, bottom=1.5cm, left=2cm, right=2cm"
nmap <F8> :Pandoc! pdf -F pandoc-crossref -F pandoc-citeproc
      \ -V geometry:margin=1in
      \ --pdf-engine=xelatex
      \ -V CJKmainfont:'Source Han Serif SC'<cr>
nmap <F7> :Pandoc! -s -F pandoc-crossref -F pandoc-citeproc 
      \ --mathjax=https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML<cr>
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" close run window in vim's python mode
:nnoremap <C-z> <C-w>z
" 使用 leader+w 在插入和normal模式下保存文件，我经常在 insert 模式下代替 Esc
inoremap <leader>w <Esc>:w<cr>
noremap <leader>w :w<cr>
noremap <leader>p :ALEFix<cr>
" Quickly open/reload vim
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" provide hjkl movements in Insert mode and Command-line mode via the <Alt>
" modifier key
noremap! <ESC>h <Left>
noremap! <ESC>j <Down>
noremap! <ESC>k <Up>
noremap! <ESC>l <Right>
" change pydocstring default keymapping
nmap <silent> <ESC>l <Plug>(pydocstring)

" ----- Plugin Management -----
" using Vim-plug to install plugins
call plug#begin('~/.vim/plugged')
Plug 'gabrielelana/vim-markdown'         " Markdown 语法高亮
Plug 'godlygeek/tabular'                 " Format tables automatically
Plug 'majutsushi/tagbar'                 " outline viewer
Plug 'scrooloose/nerdtree'               " file system explorer
Plug 'rking/ag.vim'                      " 使用 Ag 在 vim 里搜索内容
Plug 'itchyny/lightline.vim'             " statusline/tabline plugin
Plug 'itchyny/vim-gitbranch'             " Provides the branch name
Plug 'mengelbrecht/lightline-bufferline' " display the list of buffers
Plug 'mhinz/vim-startify'                " fancy start screen
Plug 'w0rp/ale'                          " Asynchronous Lint Engine
Plug 'mzlogin/vim-markdown-toc'          " Markdown 的文章目录生成和更新
Plug 'mattn/webapi-vim'                  " An Interface to WEB APIs
Plug 'mattn/gist-vim'                    " a vimscript for creating gists
Plug 'airblade/vim-gitgutter'            " shows a git diff
Plug 'vim-pandoc/vim-pandoc'             " pandoc integration and utilities
Plug 'vim-pandoc/vim-pandoc-syntax'      " pandoc markdown syntax
Plug 'lyokha/vim-xkbswitch'              " automatic keyboard layout switching
Plug 'Yggdroot/indentLine'               " display the indention levels
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'aperezdc/vim-template'             " Simple templates plugin for Vim
Plug 'previm/previm'                     " Realtime preview by Vim.
Plug 'tyru/open-browser.vim'             " Open URI with your favorite browser
Plug 'lervag/vimtex'                     " A modern plugin for editing LaTeX
Plug 'jiangmiao/auto-pairs'              " insert or delete brackets etc. in pair
Plug 'heavenshell/vim-pydocstring'       " Generate Python docstring
Plug 'tpope/vim-endwise'                 " wisely add 'end'
Plug 'tpope/vim-ragtag'                  " ghetto HTML/XML mappings
Plug 'tpope/vim-surround'                " quoting/parenthesizing made simple
Plug 'tpope/vim-repeat'                  " enable '.' supported plugin
Plug 'tpope/vim-commentary'              " comment stuff out
Plug 'maximbaz/lightline-ale'            " ALE indicator for the lightline
Plug 'farmergreg/vim-lastplace'          " reopen files at last edit position
Plug 'Valloric/ListToggle'               " toggle the quickfix and location-list
call plug#end()

" ----- Plugin Options -----
" enable conceal for italic, bold, inline-code and link text 
let g:markdown_enable_conceal = 1        " gabrielelana/vim-markdown
" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : 'markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
" In the case of .md, filetype becomes a modula2. If so, please describe in
" .vimrc this setting
augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
" To enable pandoc functionality for markdown files while using  the markdown
" filetype and syntax, use
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
" opt out of syntax file for markdown files
" vim-pandoc-syntax 与 markdown linter 冲突
let g:pandoc#filetypes#pandoc_markdown = 0
" set gists to be private by default
let g:gist_post_private = 1
" 解决中文输入法切换的问题
let g:XkbSwitchEnabled = 1
" E-mail address of the current user.
let g:email = "dejie.guo@gmail.com"
" Current logged-in user name.
let g:username = "GUO DEJIE"
let g:XkbSwitchEnabled = 1
" prevent vim from detecting a file with the `tex` suffix as a |plaintex|.
let g:tex_flavor = 'latex'

" ----- Browser Setting -----
	" If it looks like URI, open an URI under cursor.
	" Otherwise, search a word under cursor.
nmap gx <Plug>(openbrowser-smart-search)
	" If it looks like URI, open selected URI.
	" Otherwise, search selected word.
vmap gx <Plug>(openbrowser-smart-search)
if has("unix")
  " WSL 用户如果使用chrome
  let g:gist_browser_command = 'cmd.exe /C start %URL%'
  let g:previm_open_cmd = "ws"
  let g:previm_enable_realtime=1
  if has('macunix')
    " Do Mac stuff here
    " 苹果 用户如果使用chrome
    let g:gist_browser_command = "open -a Google\\ Chrome"
    let g:previm_open_cmd = "open -a Google\\ Chrome"
    let g:netrw_browsex_viewer="open -a Google\\ Chrome"
  endif
endif

" ----- Statusline/Tabline Setting -----
" show git branch using lightline.vim, configure as follows.
let g:lightline = {
  \ 'colorscheme': 'selenized_dark',
  \ 'enable': {
  \   'statusline': 1,
  \   'tabline': 1
  \ },
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
  \   'right': [[ 'lineinfo' ],
  \             [ 'percent' ],
  \             [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex'  ],
  \             [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'  ]]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'gitbranch#name',
  \ }
\ }
" Bufferline Configuration
let g:lightline#bufferline#min_buffer_count = 2
let g:lightline#bufferline#unicode_symbols = 1
let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)
" Bufferline Integration
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers',
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type   = {'buffers': 'tabsel',
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "

" ----- Code Checking -----
" 实现python格式或者markdown格式的自动调整
let g:ale_fixers = {
 \  'python': ['add_blank_lines_for_python_control_statements',
			\	'autopep8','isort','yapf','remove_trailing_lines','trim_whitespace',
      \ 'ale#fixers#generic_python#BreakUpLongLines'],
 \  'markdown': ['prettier','remove_trailing_lines','trim_whitespace'],
 \  'javascript': ['prettier'],
 \}
" configure linters
let g:ale_linters = {
\   'python': ['pylint'],
\   'markdown': ['mdl'],
\}
" 如果你觉得默认的 ale 提示符不好看，我们可以修改 ale 提示符使用 emoji 符号，
" 换成萌萌的 emoji 表情
let g:ale_sign_error = '😡'
let g:ale_sign_warning = '😠'
" ALE sets some background colors automatically for warnings and errors in the
" sign gutter. These colors can be customised, or even removed completely:
highlight clear ALEErrorSign
highlight clear ALEWarningSign
"普通模式下，前往上一个错误或警告
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
" 前往下一个错误或警告
nmap <silent> <leader>j <Plug>(ale_next_wrap)
" Disable auto-detection of virtualenvironments
let g:ale_virtualenv_dir_names = []
" Environment variable ${VIRTUAL_ENV} is always used"
" prettier options:
" 	'always' - Wrap prose if it exceeds the print width.
" 	'never' - Do not wrap prose.
" 	'preserve' - Wrap prose as-is. available in v1.9.0+
let g:ale_javascript_prettier_options = '--prose-wrap always'
" enable running ALEFix when files are saved
let g:ale_fix_on_save = 0

" ----- Pymode Setting -----
" Pymode检查代码太卡了，所以这里关掉了pymode的代码检查功能。插件Ale实现了代码的
" 异步检查，这样在代码检测的时候不会影响到其它操作。
let g:pymode_lint = 0
" Turn on the rope script
let g:pymode_rope = 1
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_rope_show_doc_bind = '<leader>rd'
" By default when you press *<C-C>g* on any object in your code you will be moved
" to definition.
let g:pymode_rope_goto_definition_bind = '<leader>g'
" Organize imports sorts imports, too. It does that according to PEP8. Unused
" imports will be dropped.
let g:pymode_rope_organize_imports_bind = '<leader>ro'
" Keymap for rename method/function/class/variables under cursor
let g:pymode_rope_rename_bind = '<leader>rr'
let g:pymode_python = 'python3'
"自动检测并启用virtualenv
let g:pymode_virtualenv = 1
"使用PEP8风格的缩进
let g:pymode_indent = 1
"取消代码折叠
let g:pymode_folding = 0
"不在父目录下查找.ropeproject，能提升响应速度
let g:pymode_rope_lookup_project = 0
"项目修改后重新生成缓存
let g:pymode_rope_regenerate_on_write = 0
"开启python所有的语法高亮
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
"高亮缩进错误
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_rope_complete_on_dot = 0
