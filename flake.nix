{
  description = "Raspberry Pi 5";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    rpi-linux-6_12-src = {
      flake = false;
      url = "github:raspberrypi/linux/rpi-6.12.y";
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs = args@{ self, nixpkgs, nixos-generators, nixos-hardware, ... }:
    let
      pkgs = import nixpkgs {
        system = "aarch64-linux";
        overlays = [ self.overlays.kernels ];
      };
    in
    {
      overlays = {
        kernels = import ./overlays/kernels.nix (builtins.removeAttrs args ["self"] );
      };
      nixosConfigurations.pi5-test = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          {
            system.stateVersion = "25.05";
            boot.kernelPackages = pkgs.linuxPackagesFor pkgs.rpi5-kernel;
          }
          nixos-generators.nixosModules.all-formats
          nixos-hardware.nixosModules.raspberry-pi-5
        ];
      };
    };
}
