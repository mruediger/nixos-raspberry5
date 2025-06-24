{
  description = "Raspberry Pi 5";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs =
    inputs:
    with inputs;
    {
      nixosConfigurations.pi5-test = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          {
            system.stateVersion = "25.05";
            boot.kernelPackages = nixpkgs.legacyPackages.aarch64-linux.linuxPackages_latest;
          }
          nixos-generators.nixosModules.all-formats
          nixos-hardware.nixosModules.raspberry-pi-5
        ];
      };
    };
}
