"Maintainer: Jacob Yang
" Version: 0.1
" Last Change: 16/04/10 09:17:57
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"使用非vi兼容模式
set nocompatible
"操作系统判断
function! MySys()
  return "linux"
endfunction

"回滚次数
set history=400

" Chinese
if MySys() == "windows"
  set encoding=utf-8
  set langmenu=zh_CN.UTF-8
  language message zh_CN.UTF-8
  set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin1
endif

"Enable filetype plugin
filetype plugin on
filetype indent on

"文件外部改变自动载入变化后的文件
set autoread

"激活鼠标
set mouse=a

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"快速保存
nmap <silent> <leader>ww :w<cr>
nmap <silent> <leader>wf :w!<cr>

"快速退出
nmap <silent> <leader>qw :wq<cr>
nmap <silent> <leader>qf :q!<cr>
nmap <silent> <leader>qq :q<cr>
nmap <silent> <leader>qa :qa<cr>

"Fast remove highlight search
nmap <silent> <leader><cr> :noh<cr>


"快速开tab打开指定文件,下面快速编辑vimrc文件中调用
function! SwitchToBuf(filename)
  "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
  " find in current tab
  let bufwinnr = bufwinnr(a:filename)
  if bufwinnr != -1
    exec bufwinnr . "wincmd w"
    return
  else
    " find in each tab
    tabfirst
    let tab = 1
    while tab <= tabpagenr("$")
      let bufwinnr = bufwinnr(a:filename)
      if bufwinnr != -1
        exec "normal " . tab . "gt"
        exec bufwinnr . "wincmd w"
        return
      endif
      tabnext
      let tab = tab + 1
    endwhile
    " not exist, new tab
    exec "tabnew " . a:filename
  endif
endfunction

"快速打开vimrc文件编辑
if MySys() == 'linux'
  "Fast reloading of the .vimrc
  map <silent> <leader>ss :source ~/.vimrc<cr>
  "Fast editing of .vimrc
  map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
  "When .vimrc is edited, reload it
  autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
  " Set helplang
  set helplang=cn
  "Fast reloading of the _vimrc
  map <silent> <leader>ss :source ~/_vimrc<cr>
  "Fast editing of _vimrc
  map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>
  "When _vimrc is edited, reload it
  autocmd! bufwritepost _vimrc source ~/_vimrc
endif

" For windows version
if MySys() == 'windows'
  source $VIMRUNTIME/mswin.vim
  behave mswin
  set diffexpr=MyDiff()
  function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
      if &sh =~ '\<cmd'
        let cmd = '""' . $VIMRUNTIME . '\diff"'
        let eq = '"'
      else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
      endif
    else
      let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
  endfunction
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"字体
if MySys() == "linux"
  "set gfn=Monaco\ 8
else
  set gfn=Monaco:h10:cANSI
endif

" Avoid clearing hilight definition in plugins
if !exists("g:vimrc_loaded")
  "Enable syntax hl
  syntax enable
  " color scheme
  if has("gui_running")
    set guioptions-=T
    set guioptions-=m
    set guioptions-=L
    set guioptions-=r
    colorscheme railscasts
    "hi normal guibg=#294d4a
  else
    "if $COLORTERM == 'gnome-terminal'
    set t_Co=256
    "set term=gnome-256color
    colorscheme railscasts
    "else
    "colorscheme desert
    "endif
  endif " has
endif " exists(...)



"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>$ :syntax sync fromstart<cr>
autocmd BufEnter * :syntax sync fromstart

"Highlight current
if has("gui_running")
  set cursorline
  hi cursorline guibg=#333333
  hi CursorColumn guibg=#333333
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"快速设置文件类型
set ffs=unix,dos
nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
"set so=7

"带着gui的时候,窗口最大化
if has("gui_running")
  set lines=9999
  set columns=9999
endif

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz


"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
"set whichwrap+=<,>,h,l
set whichwrap+=<,>

"Ignore case when searching
"set ignorecase

"Include search
set incsearch

"Highlight search things
set hlsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

"How many tenths of a second to blink
"set mat=2

""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""
"Always hide the statusline
set laststatus=2
function! CurDir()
  let curdir = substitute(getcwd(), '/home/administrator/', "~/", "g")
  return curdir
endfunction

"Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ 目录:\ %r%{CurDir()}%h\ \ \ 行号:\ %l/%L:%c


""""""""""""""""""""""""""""""
" Visual
""""""""""""""""""""""""""""""
" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around and tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Smart way to move btw. windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

"Actually, the tab does not switch buffers, but my arrows
"Bclose function can be found in "Buffer related" section
map <leader>bd :Bclose<cr>
map <leader>bf :BufExplorer<cr>
"map <down> <leader>bd


"Use the arrows to something usefull
"map <right> :bn<cr>
"map <left> :bp<cr>

"Tab configuration
map <leader>tn :tabnew
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
try
  set switchbuf=useopen
  set stal=1
catch
endtry

"Moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i

"Switch to current dir
map <silent> <leader>cd :cd %:p:h<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap @1 <esc>`>a)<esc>`<i(<esc>
vnoremap @2 <esc>`>a]<esc>`<i[<esc>
vnoremap @3 <esc>`>a}<esc>`<i{<esc>
vnoremap @$ <esc>`>a"<esc>`<i"<esc>
vnoremap @q <esc>`>a'<esc>`<i'<esc>
vnoremap @w <esc>`>a"<esc>`<i"<esc>

"Map auto complete of (, ", ', [
inoremap @1 ()<esc>:let leavechar=")"<cr>i
inoremap @2 []<esc>:let leavechar="]"<cr>i
inoremap @3 {}<esc>:let leavechar="}"<cr>i
inoremap @4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap @q ''<esc>:let leavechar="'"<cr>i
inoremap @w ""<esc>:let leavechar='"'<cr>i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 命令模式配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Bash like
"ctrl+a 行首
"ctrl+e 行尾
"ctrl+k 删除整行
cnoremap <C-A>    <Home> 
cnoremap <C-E>    <End>
cnoremap <C-K>    <C-U>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Open a dummy buffer for paste
map <leader>es :tabnew<cr>:setl buftype=nofile<cr>
if MySys() == "linux"
  map <leader>ec :tabnew ~/tmp/scratch.txt<cr>
else
  map <leader>ec :tabnew $TEMP/scratch.txt<cr>
endif

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")
  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif
  if bufnr("%") == l:currentBufNum
    new
  endif
  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Session options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set sessionoptions-=curdir
set sessionoptions+=sesdir



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb

"set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
set fen
set fdl=0
nmap <silent> <leader>zo zO
vmap <silent> <leader>zo zO


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
map <leader>t2 :set shiftwidth=2<cr>
map <leader>t4 :set shiftwidth=4<cr>
au FileType html,python,vim,javascript setl shiftwidth=2

"au FileType html,python,vim,javascript setl tabstop=2
au FileType java,c,cs setl shiftwidth=4

"au FileType java setl tabstop=4
au FileType txt setl lbr
au FileType txt setl tw=78
set smarttab
"set lbr
"set tw=78


""""""""""""""""""""""""""""""
" Indent
""""""""""""""""""""""""""""""
"Auto indent
set ai

"Smart indet
set si

"C-style indeting
set cindent

"Wrap lines
set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Complete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" options
set completeopt=menu
set complete-=u
set complete-=i


" mapping
inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <C-J>      pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
inoremap <expr> <C-K>      pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
inoremap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>"
inoremap <C-]>             <C-X><C-]>
inoremap <C-F>             <C-X><C-F>
inoremap <C-D>             <C-X><C-D>
inoremap <C-L>             <C-X><C-L>

" Enable syntax
"if has("autocmd") && exists("+omnifunc")
"  autocmd Filetype *
"        if &omnifunc == "" |
"          setlocal omnifunc=syntaxcomplete#Complete |
"        endif
"endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb

  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
  endif
  set csverb
endif

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1. surround
let g:surround_45 = "<% \r %>"  "yss- means <%  %>
let g:surround_61 = "<%= \r %>" "yss= means <%= %>

" 2. matchit (% to bounce from do to end, etc.)
:let loaded_matchit = 1
"runtime! macros/matchit.vim

" 3. nerd_tree
nmap <silent> <Leader>wm :NERDTreeToggle<CR>

" 4.bufexplorer
nnoremap <C-B> :BufExplorer<cr>


"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$


""""""""""""""""""""""""""""""
" 6. Super Tab
""""""""""""""""""""""""""""""
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "<C-P>"


""""""""""""""""""""""""""""""
" 7. file explorer setting
""""""""""""""""""""""""""""""
"Split vertically
let g:explVertical=1

"Window size
let g:explWinSize=35
let g:explSplitLeft=1
let g:explSplitBelow=1

"Hide some files
let g:explHideFiles='^\.,.*\.class$,.*\.swp$,.*\.pyc$,.*\.swo$,\.DS_Store$'

"Hide the help thing..
let g:explDetailedHelp=0



""""""""""""""""""""""""""""""
" bufexplorer setting
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=1       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
let g:bufExplorerMaxHeight=13        " Max height


""""""""""""""""""""""""""""""
" taglist setting
""""""""""""""""""""""""""""""
if MySys() == "windows"
  let Tlist_Ctags_Cmd = 'ctags'
elseif MySys() == "linux"
  let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
nmap <silent> <leader>tl :Tlist<cr>



"Bindings
autocmd FileType tex map <silent><leader><space> :w!<cr> :silent! call Tex_RunLaTeX()<cr>


"Auto complete some things ;)
autocmd FileType tex inoremap $i \indent
autocmd FileType tex inoremap $* \cdot
autocmd FileType tex inoremap $i \item
autocmd FileType tex inoremap $m \[<cr>\]<esc>O

