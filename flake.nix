{
  description = "Nixos config flake";

  nixConfig = {
    # override the default substituters
    substituters = [
      "https://cache.nixos.org"
      # nix community's cache server
      "https://nix-community.cachix.org"
      # CUDA maintainers cache
      "https://cuda-maintainers.cachix.org"
      # AAGL
      "https://ezkea.cachix.org"
      # Ghostty
      "https://ghostty.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
    ];
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    ghostty.url = "github:ghostty-org/ghostty";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    aagl = {
      url = "github:ezKEA/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations.stargazer = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./overlays/neovim.nix
        ./hosts/stargazer/configuration.nix
        inputs.home-manager.nixosModules.default
        ./inputs/aagl.nix
      ];
    };
    nixosConfigurations.kanami = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./overlays/neovim.nix
        ./hosts/kanami/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
    nixosConfigurations.satella = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./overlays/neovim.nix
        ./hosts/satella/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.nixos-hardware.nixosModules.framework-13-7040-amd
      ];
    };
  };
}
