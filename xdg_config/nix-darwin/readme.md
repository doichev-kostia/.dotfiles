configuration name is "main"

```shell
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .#main
```

rebuild
```
darwin-rebuild switch --flake .#main
```

search for packages (https://search.nixos.org/packages)
```
nix search nixpkgs <pkg_name>
```

### Update

```shell
nix flake update
```

```
darwin-rebuild switch --flake .#main
```

