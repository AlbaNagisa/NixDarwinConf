# NixDarwinConf

### First start

```sh
nix --extra-experimental-features 'nix-command flakes'  run nix-darwin -- switch --flake .#default
```

### Update installed

```sh
nix flake update
```
