map <Leader>e :call RemoteSendCommand('check')<CR><CR>
map <Leader>r :call RemoteSendCommand('run')<CR><CR>
map <Leader>t :call RemoteSendCommand('test')<CR><CR>

"bool whether command window open
let g:pane_open = 0

let g:rtmux = {'rust': 'cargo run',
            \ 'vim': 'pwd',
            \} 
let g:ttmux = {'rust': 'cargo test',
            \ 'vim': 'pwd',
            \}
let g:ctmux = {'rust': 'cargo check',
            \ 'vim': 'pwd',
            \}

function! RemoteSendCommand(what)
    if exists('$TMUX')
        let a:cmd = 'clear'
        if a:what ==# 'run'
            let a:cmd = get(g:rtmux, &filetype, 'ls')
        elseif a:what ==# 'test'
            let a:cmd = get(g:ttmux, &filetype, 'ls')
        elseif a:what ==# 'check'
            let a:cmd = get(g:ctmux, &filetype, 'ls')
        endif

        if g:pane_open == 0
            execute '! tmux splitw -h -d'
            execute "! tmux send-keys -t .2 \"" . a:cmd . "\" C-m"
            execute '! tmux last pane' 
            let g:pane_open = 1

        else  
            echo 'Closing pane'
            execute '! tmux kill-pane -t .2'
            let g:pane_open = 0
        endif
    else
        echo 'This needs to be run in tmux'
    endif

    echo a:cmd
endfunction
