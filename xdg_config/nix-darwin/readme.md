configuration name is "main"

```shell
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .#main
```

rebuild
```
darwin-rebuild switch --flake .#main
```
