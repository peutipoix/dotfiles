" VIM Configuration File
" Description: Optimized for C/C++ development, but useful also for other things.
" Author: Gerhard Gappmeier
"
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=8        " tab width is 4 spaces
set softtabstop=8
set shiftwidth=8     " indent also with 4 spaces
set noexpandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
" set textwidth=120
" turn syntax highlighting on
set t_Co=256
syntax on
colorscheme wombat256
" turn line numbers on
"set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
" use intelligent file completion like in the bash
set wildmode=longest:full
set wildmenu

" vim-git plugin
"set laststatus=2
"set statusline=%{GitBranch()}

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing '.' '->' or <C-o>
" Load standard tag files
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4
set tags+=~/work/sidust/tags
set tags+=~/work/opcua/tags
set tags+=~/work/Performance_4149/miniweb/tags

" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
"let g:DoxygenToolkit_briefTag_pre=""
"let g:DoxygenToolkit_paramTag_pre="@param "
"let g:DoxygenToolkit_returnTag="@return "
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
"let g:DoxygenToolkit_authorName="Gerhard Gappmeier <gerhard.gappmeier@ascolab.com>" 
"let g:DoxygenToolkit_licenseTag="My own license"

" Enhanced keyboard mappings
"
" in normal mode F2 will save the file
nmap <S-F10> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <S-F10> <ESC>:w<CR>i
" map F3 and SHIFT-F3 to toggle spell checking
nmap <S-F3> :setlocal spell spelllang=en<CR>
imap <S-F3> <ESC>:setlocal spell spelllang=en<CR>i
nmap <S-F3> :setlocal spell spelllang=<CR>
imap <S-F3> <ESC>:setlocal spell spelllang=<CR>i
" switch between header/source with F4 C++
"map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" switch between header/source with F4 C
map <S-F9> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
" recreate tags file with F5
map <S-F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" create doxygen comment
map <S-F6> :Dox<CR>
" build using makeprg with <F7>
nmap <S-F7> :make<CR>
" build using makeprg with <F7>, in insert mode exit to command mode, save and compile
imap <S-F7> <ESC>:w<CR>:make<CR>
" build using makeprg with <S-F7>
map <S-F7> :make clean <CR>
" macro recording
nmap <S-F8> qq
"nmap <S-F8> @q
" goto definition with F12
map <S-F12> <C-]>
" in diff mode we use the spell check keys for merging
"if &diff
"  " diff settings
"  map <M-Down> ]c
"  map <M-Up> [c
"  map <M-Left> do
"  map <M-Right> dp
"  map <S-F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
"else
"  " spell settings
"  :setlocal spell spelllang=en
"  " set the spellfile - folders must exist
"  set spellfile=~/.vim/spellfile.add
"  map <M-Down> ]s
"  map <M-Up> [s
"endif

" template functionality
function! CreateHeaderFile()
    silent! 0r ~/.vim/skel/templ.h
    silent! exe "%s/%INCLUDEPROTECTION%/__".toupper(expand("<afile>:r"))."_H__/g"
endfunction

function! CreateCSourceFile()
    if expand("<afile>") == "main.c"
        return
    endif
    silent! 0r ~/.vim/skel/templ.c
    " :r removes file extension
    silent! exe "%s/%FILE%/".expand("<afile>:r").".h/g"
endfunction

autocmd BufNewFile main.c 0r ~/.vim/skel/main.c
autocmd BufNewFile main.cpp 0r ~/.vim/skel/main.cpp
autocmd BufNewFile *.c call CreateCSourceFile()
autocmd BufNewFile *.h call CreateHeaderFile()

" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

