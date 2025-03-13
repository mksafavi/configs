# NixOS configurations
![](https://github.com/mksafavi/configs/actions/workflows/update-flake.yml/badge.svg)
![](https://github.com/mksafavi/configs/actions/workflows/build.yml/badge.svg)
![](https://github.com/mksafavi/configs/actions/workflows/deploy.yml/badge.svg)

## build nixos: 
This will build nixos and also the home-manager configuration as module.

- `build` to build the derivative 
- `switch` create new generation and switch to it
- `boot` switch to it in the next boot

### build the selected config:
- machineName is defined at `flake.nix`
```
nixos-rebuild build  --flake ./#machineName
```

### build the config in this machine and deploy it to the target machine:
This will ask for sudo password multiple times (`[sudo] password for user:`) 
and after entering the correct password will say (`Shared connection to <host_ip> closed.`). 
This is not an error and it's working fine. (There might be a solution for this but idk)

```
nixos-rebuild build  --flake ./#machineName --target-host user@host --use-remote-sudo
```

### build on another machine and copy the result to the target-host:
```
nixos-rebuild build  --flake ./#machineName --build-host user@build-host --target-host user@host --use-remote-sudo
```
