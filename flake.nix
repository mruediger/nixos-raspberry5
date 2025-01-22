{
  description = "Raspberry Pi 5";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    raspberry-pi-nix.url = "github:nix-community/raspberry-pi-nix";
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
    {
      nixpkgs,
      raspberry-pi-nix,
    }:
    let
      basic-config =
        { ... }:
        {
          raspberry-pi-nix.board = "bcm2712";
          time.timeZone = "Europe/Berlin";
          system.stateVersion = "24.11";
        };
    in
    {
      nixosConfigurations = {
        pi5-test = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            raspberry-pi-nix.nixosModules.raspberry-pi
            raspberry-pi-nix.nixosModules.sd-image
            basic-config

            ./modules/networking.nix
            ./modules/users.nix
            ./modules/openssh.nix
            ./modules/nix.nix
            ./modules/headless.nix
            ./modules/prometheus.nix
            ./modules/grafana.nix
            ./modules/smtp.nix
          ];
        };
      };
    };

}
