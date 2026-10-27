status is-interactive; or exit

# Ghostty sends Alt+P for Cmd+Shift+O, Alt+G for Cmd+Shift+F and Alt+R for
# Cmd+Option+O (see the ghostty config). All pass through zellij untouched.
# Alt+P replaces fish's preset `__fish_paginate`; Alt+G and Alt+R are unbound
# by default.
for mode in default insert visual
    bind -M $mode alt-p fff_pick
    bind -M $mode alt-g fff_grep
    bind -M $mode alt-r fff_symbol
end
