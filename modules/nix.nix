{ ... }:
{
  nix.optimise.automatic = true;
  nix.settings.trusted-users = [ "@wheel" ];

  systemd.services.nix-gc.serviceConfig = {
    CPUSchedulingPolicy = "batch";
    IOSchedulingClass = "idle";
    IOSchedulingPriority = 7;
  };
}
