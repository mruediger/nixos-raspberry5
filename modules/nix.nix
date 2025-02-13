{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixos-option
  ];

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    optimise.automatic = true;
    settings.trusted-users = [ "@wheel" ];

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  systemd.services.nix-gc.serviceConfig = {
    CPUSchedulingPolicy = "batch";
    IOSchedulingClass = "idle";
    IOSchedulingPriority = 7;
  };
}
