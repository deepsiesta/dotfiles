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
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";

    aagl = {
      url = "github:ezKEA/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      imports = let
        inherit (inputs.nixpkgs.lib) hasSuffix hasInfix;
        treeModules = inputs.import-tree.initFilter (
          path:
            hasSuffix ".nix" path
            && !hasInfix "/_" path
            && !hasSuffix "/hardware-configuration.nix" path
        );
      in [
        inputs.flake-parts.flakeModules.modules
        inputs.treefmt-nix.flakeModule
        (treeModules ./modules)
        (treeModules ./hosts)
        (treeModules ./lib)
      ];

      perSystem = {config, ...}: {
        treefmt.config = {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
          programs.deadnix.enable = true;
          programs.statix.enable = true;
        };
        formatter = config.treefmt.build.wrapper;
      };

      flake.nixosConfigurations = {
        stargazer = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [inputs.self.modules.nixos.stargazer];
        };
        kanami = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [inputs.self.modules.nixos.kanami];
        };
        satella = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [inputs.self.modules.nixos.satella];
        };
        warg = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [inputs.self.modules.nixos.warg];
        };
      };
    };
}
