{ ... }:
{
  environment = {
    # Print the URL instead on servers
    variables.BROWSER = "echo";
    # Don't install the /lib/ld-linux.so.2 and /lib64/ld-linux-x86-64.so.2
      # stubs. Server users should know what they are doing.
    stub-ld.enable = false;
  };

  programs.command-not-found.enable = false;

  xdg = {
    autostart.enable = false;
    icons.enable = false;
    menus.enable = false;
    mime.enable = false;
    sounds.enable = false;
  };

  systemd = {
    # Given that our systems are headless, emergency mode is useless.
    # We prefer # TODO: he system to attempt to continue booting so
    # that we can hopefully still access it remotely.
    enableEmergencyMode = false;

    sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
    '';
  };
}
