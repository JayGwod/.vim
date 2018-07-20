" ----- Color Scheme -----
set term=screen-256color
colorscheme molokai                      " 默认配色方案
if (has("termguicolors"))
	" set Vim-specific sequences for RGB colors
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" 
	set termguicolors                      " True Colors
	colorscheme material-theme             " 更好的配色方案
endif
set background=dark
syntax enable                            " 打开语法高亮

" ----- Status Line -----
set laststatus=2                         " 显示状态行
set noshowmode                           " get rid of -- INSERT --

" ----- Tab & Spaces -----
set shiftwidth=2                         " 设置空格
set tabstop=2                            " 设置制表符
set autoindent                           " 设置自动缩进
" 解决插入模式下delete/backspce键失效问题
set backspace=2

" ----- Searching -----
set number                               " 打开行号
set hls is                               " highlight matches
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" ----- Spell & Length Checking -----
set spell spelllang=en,cjk               " cjk 同时针对中日两种文字的写法
set colorcolumn=81                       " 设置超过80长度提示

" ----- Keyboard Shortcuts -----
" Find the file in the NERDTree window
nmap <F11> :NERDTreeFind<CR>
" F10 key will toggle the NERDTree window
nmap <F10> :NERDTreeToggle<CR>
set pastetoggle=<F9>                     " 按功能键<F9>进入粘贴模式
" F8 key will toggle the Tagbar window
nmap <F8> :TagbarToggle<CR>
" 在打开 markdown 文件后，使用该命令可以打开预览窗口
nmap <F7> <Plug>MarkdownPreview
" 关闭 markdown 预览窗口，并停止开启的服务进程
nmap <F6> <Plug>StopMarkdownPreview

" ----- Plugin Management -----
" using Vim-plug to install plugins
call plug#begin('~/.vim/plugged')
Plug 'gabrielelana/vim-markdown'         " Markdown 语法高亮
Plug 'godlygeek/tabular'                 " Format tables automatically
Plug 'majutsushi/tagbar'                 " outline viewer
Plug 'iamcco/markdown-preview.vim'       " 实时通过浏览器预览 markdown 文件
Plug 'iamcco/mathjax-support-for-mkdp'   " 预览数学公式
Plug 'scrooloose/nerdtree'               " file system explorer
Plug 'rking/ag.vim'                      " 使用 Ag 在 vim 里搜索内容
Plug 'itchyny/lightline.vim'             " statusline/tabline plugin
Plug 'mhinz/vim-startify'                " fancy start screen
Plug 'w0rp/ale'                          " Asynchronous Lint Engine
call plug#end()

" ----- Options -----
" enable conceal for italic, bold, inline-code and link text 
let g:markdown_enable_conceal = 1        " gabrielelana/vim-markdown
" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/.vim/markdown2ctags/markdown2ctags.py',
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
let g:mkdp_path_to_chrome = "cmd.exe /C start" 
    " 设置 chrome 浏览器的路径（或是启动 chrome（或其他现代浏览器）的命令）
    " 如果设置了该参数, g:mkdp_browserfunc 将被忽略
let g:mkdp_auto_close = 0
    " 在切换 buffer 的时候自动关闭预览窗口，设置为 0 则在切换 buffer 的时候不
    " 自动关闭预览窗口
" statusline colorscheme
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }
" 实现python格式或者markdown格式的自动调整
let g:ale_fixers = {
 \  'python': ['add_blank_lines_for_python_control_statements',
			\	'autopep8','isort','yapf','remove_trailing_lines','trim_whitespace'],
 \  'markdown': ['prettier','remove_trailing_lines','trim_whitespace'],
 \}
" 修改 ale 提示符使用 emoji 符号
" let g:ale_sign_error = '✗'
" let g:ale_sign_warning = '⚡'
