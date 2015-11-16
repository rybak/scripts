"
" Author: Andrey Rybak
"
" Description: Cycle the color of comments 0 through 100 to see available colors.
"
" Usage: `:source path/to/comment_colors.vim` to launch script
"
let c=0
while c<=100
exec "hi Comment ctermfg=".c
echom c
let c=c+1
redraw
sleep 500m
endwhile
