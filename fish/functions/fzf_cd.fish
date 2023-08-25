function fzf_cd
    set selected (find ~/work ~/ ~/personal $(pwd) -mindepth 1 -maxdepth 1 -type d | fzf)

    cd "$selected"; or return 1
end

