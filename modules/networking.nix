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

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = false;
    ipv4 = true;
    ipv6 = false;
  };
}
