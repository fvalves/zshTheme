" Autodetect changes to .[g]vimrc and activate new configuration
augroup myvimrc
    au!
    au BufWritePost ~/.vimrc,~/.gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Hard mode
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>
noremap h <NOP>
noremap j <NOP>
noremap k <NOP>
noremap l <NOP>

" Use F3 to find out syntax group
map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Use F10 to replace character under cursor throughout buffer
map <F10> "ay :%s/<C-R>a/

" Display options
set number
syntax on

" Set syntax file for URScript
autocmd BufNewFile,BufRead *.script set ft=urscript

" Set syntax file for PacScript
autocmd BufNewFile,BufRead *.pcs set ft=pacscript

" Set syntax for zsh themes
autocmd BufNewFile,BufRead *.zsh-theme set syn=sh

" Set syntax for vrapper
autocmd BufNewFile,BufRead .vrapperrc set syn=vim

" Set syntax for URP
autocmd BufNewFile,BufRead *.urp set syn=xml

" Set TAB to indent with 4 spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
" Except for Makefiles, which need actual TABs
autocmd BufNewFile,BufRead Makefile set noexpandtab shiftwidth=8

" Faster recognition of 'O' command
set timeoutlen=100

" Set incremental search
set incsearch

" Split new windows below/right
set splitbelow
set splitright

" Remap + and - to resize windows
map + <C-W>+
map - <C-W>-

" Fancy status line
set statusline=%<%t%y%m\ \ %a\ 
    \%=line:%l/%L,\ col:%c%V\ %P
" Always display status line
set laststatus=2

" Dynamic filetype check
function! CheckFileType()
    " Declare buffer counter variable
    if exists("b:countCheck") == 0
        let b:countCheck = 0
    endif

    " Increment counter
    let b:countCheck += 1

    " Perform detection only if no filetype
    "  has already been assigned; wait for
    "  about 20 characters to be input before detection
    if &filetype == "" && b:countCheck > 20 && b:countCheck < 200
        filetype detect
    " Delete autocmd once detection is successful or
    "  about 200 characters have been entered and the
    "  detection has not been successful
    elseif b:countCheck >= 200 || &filetype != ""
        autocmd! newFileDetection
        augroup! newFileDetection
    endif
endfunction

augroup newFileDetection
autocmd CursorMovedI * call CheckFileType()
augroup END

" Set foldmethod, foldcolumn and smartindent for programming
autocmd bufNew,bufRead set foldcolumn=0 "Set zero foldcolumn to all other file types
autocmd Syntax c,cpp,vim set foldmethod=syntax foldcolumn=10 smartindent | normal zR
autocmd Syntax python set foldmethod=indent foldcolumn=10 smartindent | normal zR
