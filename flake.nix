{
  inputs = {
    blank.url = "github:divnix/blank";

    flake-compat.url = "github:edolstra/flake-compat";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs = {
        nixpkgs-lib.follows = "nixpkgs";
      };
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs = {
        systems.follows = "systems";
      };
    };

    make-shell = {
      url = "github:nicknovitski/make-shell";
      inputs = {
        flake-compat.follows = "flake-compat";
      };
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixpkgs-python = {
      # url = "github:cachix/nixpkgs-python";
      # TODO: until <https://github.com/cachix/nixpkgs-python/pull/69>
      url = "github:cachix/nixpkgs-python/create-pull-request/patch";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };

    nixpkgs-ruby = {
      url = "github:bobvanderlinden/nixpkgs-ruby";
      inputs = {
        flake-compat.follows = "flake-compat";
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    systems.url = "github:nix-systems/default";
  };

  outputs = inputs:
    {
      mkFlake = self:
        let
          self' = self // { inherit inputs; };
          inputs' = inputs // { self = self'; };
        in
        inputs.flake-parts.lib.mkFlake { inputs = inputs'; };
    };
}
