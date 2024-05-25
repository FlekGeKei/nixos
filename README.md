# nixos

(screenshot)[preview/screen-1716658428.png]

## Installing (example)

bla-bla-bla

### [Disco](https://github.com/nix-community/disko)

```console
wget https://raw.githubusercontent.com/FlekGeKei/nixos/main/disco/disco.nix
```
```console
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disk.nix
```

### Nix

> [!WARNING]
> if ESP not mounted to /mnt/boot, do it manualy

```console
sudo wget -P /mnt/etc/nixos https://raw.githubusercontent.com/FlekGeKei/nixos/main/nixos-config/configuration.nix 
```
```console
sudo wget -P /mnt/etc/nixos https://raw.githubusercontent.com/FlekGeKei/nixos/main/flake/flake.nix 
```
```console
sudo nixos-install --flake /mnt/etc/nixos/flake.nix#fgk
```
