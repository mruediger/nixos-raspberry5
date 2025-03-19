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
    inputs:
    with inputs;
    {
      nixosConfigurations =
        let
          configure = hostname: roles: nixpkgs.lib.nixosSystem {
            specialArgs = { inherit hostname roles inputs; };
            system = "aarch64-linux";
            modules = [
              raspberry-pi-nix.nixosModules.raspberry-pi
              raspberry-pi-nix.nixosModules.sd-image
              ./modules/base-config.nix
              ./modules/networking.nix
              ./modules/users.nix
              ./modules/openssh.nix
              ./modules/nix.nix
              ./modules/headless.nix
              ./modules/prometheus.nix
              ./modules/grafana.nix
              ./modules/kubernetes.nix
            ];
          };
          in {
            pi5-a = configure "pi5-a" [ "node" "master" ];
            pi5-b = configure "pi5-b" [ "node" ];
          };
    };
}
