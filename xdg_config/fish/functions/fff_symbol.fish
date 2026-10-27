function fff_symbol --description 'Find a definition by name and open it in nvim'
    # fffq ranks names from fffd's symbol index on every keystroke; fzf only draws.
    # The prompt holds the scope, and Tab switches between all symbols and types.
    set -l search 'fffq symbols --plain --max 200 $([ "${FZF_PROMPT%%>*}" = types ] && echo --types) -- {q} 2>&1'
    set -l next_scope 'case "$FZF_PROMPT" in symbols*) echo "types> ";; *) echo "symbols> ";; esac'
    set -l selected (fzf --disabled --height=80% --layout=reverse --border \
        --prompt 'symbols> ' --header 'tab: symbols ↔ types   Type::method narrows by container' \
        --with-shell 'sh -c' --delimiter : --with-nth '4..,1' \
        --bind "start:reload[$search]" \
        --bind "change:reload[$search]" \
        --bind "tab:transform-prompt[$next_scope]+reload[$search]" \
        --preview 'bat --color=always --style=numbers --highlight-line {2} {1}' \
        --preview-window 'right,55%,border-left,+{2}+3/3')

    # Esc, an empty pick, or an error line from fffq.
    if test -z "$selected"; or string match -q 'fffq:*' -- $selected
        commandline -f repaint
        return
    end

    # path:line:column:kind name
    set -l parts (string split --max 3 : -- $selected)
    nvim "+call cursor($parts[2], $parts[3])" -- $parts[1]
    commandline -f repaint
end
