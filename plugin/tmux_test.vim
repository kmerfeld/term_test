map <Leader>e :call Tmux_test('check')<CR><CR>
map <Leader>r :call Tmux_test('run')<CR><CR>
map <Leader>t :call Tmux_test('test')<CR><CR>

"bool whether command window open
let g:pane_open = 0

" Define dicts if the user doesn't set them
if !exists('g:rtmux')
    let g:rtmux = {'rust': 'cargo run',
            \ 'vim': 'pwd',
            \} 
endif

if !exists('g:ttmux')
    let g:rtmux = {'rust': 'cargo test',
            \ 'vim': 'pwd',
            \} 
endif
if !exists('g:ctmux')
    let g:rtmux = {'rust': 'cargo check',
            \ 'vim': 'pwd',
            \} 
endif

function! Tmux_test(what)
    "make sure you have tmux open
    if exists('$TMUX')
        let a:cmd = 'clear'
        if a:what ==# 'run'
            "get the value from dict, default to ls
            let a:cmd = get(g:rtmux, &filetype, 'ls')
        elseif a:what ==# 'test'
            let a:cmd = get(g:ttmux, &filetype, 'ls')
        elseif a:what ==# 'check'
            let a:cmd = get(g:ctmux, &filetype, 'ls')
        endif

        if g:pane_open == 0
            execute '! tmux splitw -h -d'
            execute "! tmux send-keys -t .right \"" . a:cmd . "\" C-m"
            execute '! tmux last pane' 
            let g:pane_open = 1

        else  
            echo 'Closing pane'
            execute '! tmux kill-pane -t .right'
            let g:pane_open = 0
        endif
    else
        echo 'This needs to be run in tmux'
    endif
endfunction
