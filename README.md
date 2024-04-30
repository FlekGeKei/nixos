# nixos

## Installing

bla-bla-bla

### [Disco](https://github.com/nix-community/disko)

```console
wget https://raw.githubusercontent.com/FlekGeKei/nixos/main/disco/disco.nix

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disk.nix
```

### Nix

> [!WARNING]
> if ESP not mounted to /mnt/boot, do it manual

```console
sudo wget -P /mnt/etc/nixos https://raw.githubusercontent.com/FlekGeKei/nixos/main/nixos-config/configuration.nix 

sudo nixos-install
```
