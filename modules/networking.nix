{ hostname, ... }:
let
  secrets = import ../crypt/networks.nix;
in
{
  networking = {
    hostName = hostname;
    wireless = {
      enable = true;
      networks = secrets;
    };
    firewall = {
      allowedTCPPorts = [ 5355 ];
      allowedUDPPorts = [ 5353 5355 ];
    };
    networkmanager.dns = "systemd-resolved";
  };

  services.resolved.enable = true;
}
