{
  description = "Declaratively configure neovim with the magic of nix!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, flake-parts, neovim, ... }: flake-parts.lib.mkFlake { inherit inputs; } {
    perSystem = { inputs', pkgs, system, ... }: {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            mynvim = import ./config/app.nix { pkgs = prev;  };
          })
        ];
      };

      packages.default = pkgs.mynvim;
      apps.default = {
        type = "app";
        program = "${pkgs.mynvim}/bin/nvim";
      };
    };

    systems = [ "x86_64-linux" ];
  };
}
