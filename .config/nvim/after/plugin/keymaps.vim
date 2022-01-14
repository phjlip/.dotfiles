"========================
"| Basic Key Remapping  |
"========================

" No Action for space
nnoremap <Space> <Nop>

" Save on ctrl-s
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Save on esc
nmap <ESC><ESC>                 :w<CR>
imap <ESC><ESC>                 <ESC>:w<CR>

" Jump paragraphs
nnoremap <C-j> }
nnoremap <C-k> {
vnoremap <C-j> }
vnoremap <C-k> {

" Easy newline
nnoremap <CR>              o<esc>k

" Delete trailing whitespaces
nnoremap <Leader>dw  :%s/\s\+$//e<CR><C-o>

" Copy to clipboard
vnoremap <C-y>  "+y
nnoremap <C-p>  "+p
