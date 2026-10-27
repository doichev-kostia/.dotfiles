function zcargo
    set -l workspace (realpath "$HOME/work/stxr/workspace")
    set -l here (realpath (pwd))

    if test "$here" = "$workspace"; or string match -q "$workspace/*" "$here"
        set -l concurrency 4
        if set -q CARGO_TARGET_CONCURRENCY
            set concurrency $CARGO_TARGET_CONCURRENCY
        end

        set -l pane_id 0
        if set -q ZELLIJ_PANE_ID
            set pane_id $ZELLIJ_PANE_ID
        end

        set -l slot (math "$pane_id % $concurrency")

        env CARGO_TARGET_DIR="$workspace/target/parallel-$slot" command cargo $argv
    else
        command cargo $argv
    end
end
