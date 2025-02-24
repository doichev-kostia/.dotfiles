https://nikitabobko.github.io/AeroSpace/guide

`alt-shift-tab = 'move-workspace-to-monitor --wrap-around next'`

`alt-shift-semicolon = 'mode service'`



The tree structure can be changed with three commands:
-  move
-  join-with
-  split (it’s for compatibility with i3. Please prefer join-with over split)


```
[mode.service.binding]
    f = ['layout floating tiling', 'mode main'] # Toggle between floating and tiling layout

    alt-shift-h = ['join-with left', 'mode main']
    alt-shift-j = ['join-with down', 'mode main']
    alt-shift-k = ['join-with up', 'mode main']
    alt-shift-l = ['join-with right', 'mode main']

    down = 'volume down'
    up = 'volume up'
    shift-down = ['volume set 0', 'mode main']
```
