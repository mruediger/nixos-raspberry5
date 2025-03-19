{ roles, pkgs, ... }:
let
  kubeMasterHostname = "pi5-a.local";
  kubeMasterAPIServerPort = 6443;
  certmgrPort = 8888;
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

  networking.firewall.allowedTCPPorts = if ( builtins.elem "master" roles)
                                        then [ certmgrPort kubeMasterAPIServerPort ]
                                        else [ certmgrPort ];

  services.kubernetes = {
    roles = roles;
    easyCerts = true;
    masterAddress = kubeMasterHostname;
    apiserverAddress = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
  };
}
