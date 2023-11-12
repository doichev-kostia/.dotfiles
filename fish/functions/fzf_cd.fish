function fzf_cd
    set selected (find ~/work ~/ ~/personal $(pwd) -mindepth 1 -maxdepth 1 -type d | fzf)

    if test -z "$selected"
        return 0
    end

    cd "$selected"; or return 1
end

bind \cO 'fzf_cd'
