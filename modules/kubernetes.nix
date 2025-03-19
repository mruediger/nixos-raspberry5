{ hostname, pkgs, lib, ... }:
let
  kubeMasterHostname = "pi5-a.local";
  kubeMasterAPIServerPort = 6443;
in
{
  environment.systemPackages = with pkgs; [
    kubectl
  ];

  programs.bash.shellAliases = {
    k = "kubectl";
  };

  programs.bash.interactiveShellInit = ''
    source ${pkgs.complete-alias}/bin/complete_alias
    complete -F _complete_alias k
  '';

#  services.etcd.enable = true;

  #/nix/store/z88hhaq46sdqzkm0zas1sn284h7w87k9-source/nixos/modules/services/cluster/kubernetes/default.nix



  #roles = lib.mkIf ( hostname != "pi5-a" ) [ "node" ];

  networking.firewall.allowedTCPPorts = [ 8888 ];

  services.kubernetes = {
    roles = if ( hostname == "pi5-a" ) then [ "master" ] else [ "node" ];
    easyCerts = true;
    masterAddress = kubeMasterHostname;
    apiserverAddress = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
  };
}
