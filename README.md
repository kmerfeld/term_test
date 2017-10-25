# tmux_test 

This is a simple plugin to allow a user to open a tmux pane
from vim and run a command at the press of a button.

## Keybindings
<leader>e = check program
<leader>r = run program
<leader>t = run tests


## Configuration

These three dictionaries are declared in the plugin.
re-define them in your vimrc to get the functionality you want

```
let g:rtmux = {'rust': 'cargo run',
            \ 'vim': 'pwd',
            \} 
let g:ttmux = {'rust': 'cargo test',
            \ 'vim': 'pwd',
            \}
let g:ctmux = {'rust': 'cargo check',
            \ 'vim': 'pwd',
            \}
```


## Disclaimer

I have never really looked into writing vim plugins, I just wanted to not have this in my vimrc.

If I am doing something horrible please let me know
