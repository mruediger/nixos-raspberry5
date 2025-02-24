{ ... }:
{
  security.sudo.wheelNeedsPassword = false;
  users.mutableUsers = false;
  users.users.bag = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFsvZoC8Cl2by+hHJWhZYPLKGfM50Y6OgUXehSwFGVt1 bag@josephine"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJFZoyPLGIlSzI5zA8MLvLM3P2rEUPAtgXYFhv0Y+8Nd bag@farting-unicorn"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPgc+zDAB4Y1HcvewdiKdKlcRo2wf4iO5aWIYab7EroV bag@butterfly"
    ];
  };
}
