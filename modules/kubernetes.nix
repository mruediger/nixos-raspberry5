{ pkgs, ... }:
let
  kubeMasterHostname = "main.kube";
  kubeMasterIP = "127.0.0.1";
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

  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";

  services.etcd.enable = true;

  #/nix/store/z88hhaq46sdqzkm0zas1sn284h7w87k9-source/nixos/modules/services/cluster/kubernetes/default.nix

#  services.kubernetes = {
#    roles = [ "master" ];
#    easyCerts = true;
#    masterAddress = kubeMasterHostname;
#    apiserverAddress = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
#  };
}
