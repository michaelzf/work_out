

""""""""""""""""""""""""""""
"""		Bundle
""""""""""""""""""""""""""""
set nocompatible    " be iMproved
filetype off        " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

" vim-scripts repos
Plugin 'The-NERD-Commenter'
Plugin 'ctags.vim'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'a.vim'
Plugin 'superSnipMate' 
Plugin 'winmanager'
Plugin 'taglist.vim'
Plugin 'Tagbar'
Plugin 'vimwiki' 
"Plugin 'OmniCppComplete'
Plugin 'clang-complete'
Plugin 'minibufexplorerpp'
Plugin 'TimeTap'
"Plugin 'powerline'
Plugin 'Syntastic'
Plugin 'SuperTab'
Plugin 'TagHighlight'
" 配色方案
Plugin 'Solarized'
Plugin 'neocomplcache'
Plugin 'surround.vim'
"Plugin 'Google-translator'
Plugin 'Pydiction'
Plugin 'Tabular'
" for js
Plugin 'jshint.vim'
Plugin 'vim-coffee-script'
Plugin 'node.js'
Plugin 'JavaScript-syntax'

" for php
Plugin 'alvan/vim-php-manual'

Plugin 'michaelzf/vim-log-syntax'

call vundle#end()  

let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"



filetype plugin indent on    " required!

"powerline{
 set guifont=PowerlineSymbols\ for\ Powerline
 set nocompatible
 set t_Co=256
 let g:Powerline_symbols = 'fancy'
 let g:Powerline_colorscheme='solarized256'
"}

" FuzzyFinder – Ctrl +  E
map <C-E> :FufFileRecursive<CR>
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp|pyc)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'

" 不要使用vi的键盘模式，而是vim自己的
set nocompatible

" 设定解码
"if has("multi_byte")
    "" When 'fileencodings' starts with 'ucs-bom', don't do this manually
    ""set bomb
    "set fileencodings=ucs-bom,utf-8,chinese,taiwan,japan,korea,latin1
    "" CJK environment detection and corresponding setting
    "if v:lang =~ "^zh_CN"
        "" Simplified Chinese, on Unix euc-cn, on MS-Windows cp936
        ""set encoding=utf-8
        ""set termencoding=utf-8
        ""if &fileencoding == ''
            ""set fileencoding=utf-8
        ""endif
		"set encoding=GBK
		"set termencoding=GBK
		"if &fileencoding == ''
			"set fileencoding=GBK
		"endif
    "elseif v:lang =~ "^zh_TW"
        "" Traditional Chinese, on Unix euc-tw, on MS-Windows cp950
        "set encoding=euc-tw
        "set termencoding=euc-tw
        "if &fileencoding == ''
            "set fileencoding=euc-tw
        "endif
    "elseif v:lang =~ "^ja_JP"
        "" Japanese, on Unix euc-jp, on MS-Windows cp932
        "set encoding=euc-jp
        "set termencoding=euc-jp
        "if &fileencoding == ''
            "set fileencoding=euc-jp
        "endif
    "elseif v:lang =~ "^ko"
        "" Korean on Unix euc-kr, on MS-Windows cp949
        "set encoding=euc-kr
        "set termencoding=euc-kr
        "if &fileencoding == ''
            "set fileencoding=ecu-kr
        "endif
    "endif
    "" Detect UTF-7 locale, and override CJK setting if needed
    "if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        "set encoding=utf-8
    "endif
"else
    "echoerr 'Sorry, this version of (g)Vim was not compiled with "multi_byte"'
"endif

" 自动格式化设置
filetype indent on
set autoindent
set smartindent

" 显示未完成命令
set showcmd
" 侦测文件类型
filetype on

" 载入文件类型插件
filetype plugin on
set nocp

" 为特定文件类型载入相关缩进文件
filetype indent on

" 语法高亮
syntax on

" 显示行号
set number

" tab宽度
set tabstop=4
set cindent shiftwidth=4
set autoindent shiftwidth=4
set expandtab


" 设置距离底部始终保持5行
set scrolloff=5

" 保存文件格式
set fileformats=unix,dos

" 文件被其他程序修改时自动载入
set autoread

" 命令行补全
set wildmenu

" 打开文件时，总是跳到退出之前的光标处
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

"修改vimrc 自动加载
autocmd! bufwritepost vimrc source ~/.vimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            PYTHON 相关的设置                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Python 文件的一般设置，比如不要 tab 等
"设置自动缩进为4,插入模式里: 插入 <Tab> 时使用合适数量的空格。
"要插入实际的制表，可用 CTRL-V<Tab>
autocmd FileType python setlocal expandtab | setlocal shiftwidth=4 |
    \setlocal softtabstop=4 | setlocal textwidth=76 |
    \setlocal tabstop=4

"搜索逐字符高亮
set hlsearch
set incsearch

"设置代码样式
colorscheme desert

"设置tags查找位置
set tags=tags;
"set autochdir

let g:pydiction_location = '~/.vim/after/ftplugin/complete-dict'

"TagList
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
"set tags=~/work/mohuan/tags;

"winmanager
let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWidth=35
let g:persistentBehaviour=0 
let g:bufExplorerMaxHeight=30
let g:miniBufExplorerMoreThanOne=0

nmap wm :WMToggle<cr>
set ignorecase
set pastetoggle=<F9>



" cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" vimwiki
"set mouse=a
let g:vimwiki_use_mouse = 1
let g:vimwiki_list = [{'path': '~/.vim/vimwiki/',
\ 'path_html': '~/.vim/vimwiki/html/',
\ 'html_header': '~/.vim/vimwiki/template/header.tpl',}]

" 设置配色
"syntax enable
"if has('gui_running')
	"set background=light
"else
	"set background=dark
"endif
""let g:solarized_termcolors=256
colorscheme solarized

"clang-complete {
let g:clang_complete_auto = 0 
let g:clang_complete_copen = 1 
"let g:clang_periodic_quickfix=1
let g:clang_snippets=1
let g:clang_close_preview=1
let g:clang_use_library=1
let g:clang_user_options='-stdlib=libstdc++ -std=c++11 -I/usr/include'
let g:clang_complete_macros=1
"let g:clang_auto_user_options='path, ~/.clang_complete'
"}

"neocomplcache{
" :help neocomplcache-faq
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objc =
      \ '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.objcpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
"let g:clang_use_library = 1
let g:neocomplcache_enable_at_startup = 1
"}


"===============================SYNTASTICSETTINGS================================================
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_cpp_include_dirs = ['shared/include']
let g:syntastic_cpp_check_header = 1
let g:syntastic_enable_signs=1
"let g:syntastic_quiet_warnings=0
set wildchar=<Tab> wildmenu wildmode=full

au BufNewFile,BufRead *.log         setfiletype=log


:nmap <F8> :Tabularize /=<Enter>
