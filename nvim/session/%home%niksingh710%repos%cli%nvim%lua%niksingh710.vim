let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/repos/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +26 Readme.md
badd +73 ~/repos/cli/nvim/lua/niksingh710/list.lua
badd +123 ~/repos/cli/nvim/lua/niksingh710/lsp/cmp.lua
badd +17 ~/repos/cli/nvim/lua/niksingh710/lsp/lspsaga.lua
badd +11 ~/repos/cli/nvim/lua/niksingh710/lsp/sagamapping.lua
argglobal
%argdel
$argadd Readme.md
edit ~/repos/cli/nvim/lua/niksingh710/lsp/sagamapping.lua
argglobal
balt ~/repos/cli/nvim/lua/niksingh710/lsp/lspsaga.lua
let s:l = 11 - ((10 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 11
normal! 04|
lcd ~/repos/cli/nvim/lua/niksingh710
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
