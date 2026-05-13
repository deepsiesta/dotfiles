# dotfiles

NixOS flake-based dotfiles managed with [flake-parts](https://github.com/hercules-ci/flake-parts) and [import-tree](https://github.com/vic/import-tree).

## Hosts

| Host          | Type    | Hardware                                      |
|---------------|---------|-----------------------------------------------|
| **stargazer** | Desktop | Intel i9-13900KF, Nvidia GeForce RTX 4090     |
| **kanami**    | Desktop | Intel CPU, legacy Nvidia drivers              |
| **satella**   | Laptop  | AMD Framework 13 (7040 series)                |
| **warg**      | Server  | Raspberry Pi                                  |

## Structure

```bash
├── flake.nix              # Flake entrypoint with host definitions
├── hosts                  # Per-host configuration
│   └── ...
├── modules                # Shared NixOS & home-manager modules
│   ├── common.nix         # Base system + user config
│   ├── hyprland.nix       # Compositor
│   └── ...                # Etc
├── lib                    # Helper functions
│   └── ...
└── overlays
    └── ...
```

## Usage

(From the repo folder)

Apply a host configuration:

```bash
sudo nixos-rebuild boot --flake .
```

After that, use `nh`:

```bash
nh os switch
```

## Formatting

```bash
nix fmt
```
