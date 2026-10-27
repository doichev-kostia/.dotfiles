function fff_pick --description 'Pick a file to open in nvim, or a directory (query starting or ending with /) to z into'
    # fffq ranks every keystroke through the shared fffd index; fzf only draws.
    set -l search 'fffq pick -- {q} 2>&1'
    set -l selected (fzf --disabled --height=60% --layout=reverse --border \
        --prompt 'fff> ' --header 'file → nvim   /dir → z' \
        --with-shell 'sh -c' \
        --bind "start:reload:$search" \
        --bind "change:reload:$search" \
        --preview 'if [ -d {} ]; then ls -A {}; else bat --color=always --style=numbers --line-range=:200 {} 2>/dev/null || head -200 {}; fi' \
        --preview-window 'right,55%,border-left')

    # Esc, an empty pick, or an error line from fffq.
    if test -z "$selected"; or string match -q 'fffq:*' -- $selected
        commandline -f repaint
        return
    end

    if string match -q '*/' -- $selected
        z $selected
    else
        nvim $selected
    end
    commandline -f repaint
end
