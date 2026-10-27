function fff_grep --description 'Fuzzy search file contents and open the match in nvim'
    # fffq searches the shared fffd index on every keystroke; fzf only draws.
    # The prompt holds the search kind, and Tab cycles fuzzy → plain → regex.
    set -l search 'fffq live-grep --kind "${FZF_PROMPT%%>*}" -- {q} 2>&1'
    set -l next_kind 'case "$FZF_PROMPT" in fuzzy*) echo "plain> ";; plain*) echo "regex> ";; *) echo "fuzzy> ";; esac'
    set -l selected (fzf --disabled --height=80% --layout=reverse --border \
        --prompt 'fuzzy> ' --header 'tab: fuzzy → plain → regex' \
        --with-shell 'sh -c' --delimiter : \
        --bind "start:reload[$search]" \
        --bind "change:reload[$search]" \
        --bind "tab:transform-prompt[$next_kind]+reload[$search]" \
        --preview 'bat --color=always --style=numbers --highlight-line {2} {1}' \
        --preview-window 'right,55%,border-left,+{2}+3/3')

    # Esc, an empty pick, or an error line from fffq.
    if test -z "$selected"; or string match -q 'fffq:*' -- $selected
        commandline -f repaint
        return
    end

    # path:line:column:text
    set -l parts (string split --max 3 : -- $selected)
    nvim "+call cursor($parts[2], $parts[3])" -- $parts[1]
    commandline -f repaint
end
