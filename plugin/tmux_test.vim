map <Leader>e :call Term_test('check')<CR><CR>
map <Leader>r :call Term_test('run')<CR><CR>
map <Leader>t :call Term_test('test')<CR><CR>

"bool whether command window open
let g:pane_open = 0

" Define dicts if the user doesn't set them
if !exists('g:rterm')
    let g:rterm = {'rust': 'cargo run',
                \ 'vim': 'pwd',
                \} 
endif

if !exists('g:tterm')
    let g:tterm = {'rust': 'cargo test',
                \ 'vim': 'pwd',
                \} 
endif
if !exists('g:cterm')
    let g:cterm = {'rust': 'cargo check',
                \ 'vim': 'pwd',
                \} 
endif

function! Term_test(what)
    "make sure you have term open
    let a:cmd = 'clear'
    let a:cmd = 'cargo test'
    "Save the file
    write

    if &buftype =~ 'terminal'
        :setlocal modifiable
        :q!
        :echo "closed"
    else
        if a:what ==# 'run'
            "get the value from dict, default to ls
            let a:cmd = get(g:rterm, &filetype, 'ls')
        elseif a:what ==# 'test'
            let a:cmd = get(g:tterm, &filetype, 'ls')
        elseif a:what ==# 'check'
            let a:cmd = get(g:cterm, &filetype, 'ls')
        endif
        :vnew
        :call termopen(a:cmd)
        :startinsert
    endif
endfunction
