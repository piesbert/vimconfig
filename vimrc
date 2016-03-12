syntax on

execute pathogen#infect()

set backspace=indent,eol,start
set cmdheight=2
set noautoindent
set nosmartindent
set fileencoding=utf-8
set fileformats=unix,dos,mac
set nu

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set laststatus=2
set statusline=
set statusline+=%1*\ %n\ %*                            "buffer number
set statusline+=%5*[%{&ff},%*                          "file format
set statusline+=%5*%{strlen(&fenc)?&fenc:&enc},%*      "file encoding
set statusline+=%5*%{strlen(&ft)?&ft:'unknown'}]%*     "file type
set statusline+=%4*\ %<%F%*                            "full path
set statusline+=%3*%m%*                                "modified flag
set statusline+=%1*%=%5l%*                             "current line
set statusline+=%2*/%L%*                               "total lines
set statusline+=%2*\ (%p%%)                            "page %
set statusline+=%1*%4v\ %*                             "virtual column number
set statusline+=%2*0x%04B\ %*                          "character under cursor

set completeopt-=preview

set t_Co=256
colorscheme moonshine

hi User1 ctermfg=green ctermbg=black
hi User2 ctermfg=blue ctermbg=black
hi User3 ctermfg=red ctermbg=black
hi User4 ctermfg=yellow ctermbg=black
hi User5 ctermfg=brown ctermbg=black

set backupdir=~/.vim/backup/backup      "backup files
set directory=~/.vim/backup/swap        "swap files
set undodir=~/.vim/backup/undo          "undo files

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/youcompleteme/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_enable_diagnostic_signs = 0 
let g:ycm_enable_diagnostic_highlighting = 0 
let g:syntastic_echo_current_error = 0 
let g:ycm_add_preview_to_completeopt = 0 
