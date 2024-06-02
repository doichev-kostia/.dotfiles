function fzf_cd
    set selected (find ~/work ~/ ~/personal $(pwd) -mindepth 1 -maxdepth 1 -type d | fzf)

    if test -z "$selected"
        return 0
    end

    set selected_name (basename "$selected" | tr . _) # replace . with _
    set is_tmux_running (pgrep tmux)

    if test -z "$TMUX" -a -z "$is_tmux_running"
        tmux new-session -s "$selected_name" -c "$selected"
        exit 0
    end

    if not tmux has-session -t="$selected_name" ^/dev/null
        tmux new-session -ds "$selected_name" -c "$selected"
    end

    tmux switch-client -t "$selected_name"
end
