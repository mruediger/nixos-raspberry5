{ ... }:
{
  services.nullmailer = {
    enable = true;
    setSendmail = true;

    config = {
      adminaddr = "ruediger+nullmailer@blueboot.org";
      remotes = ''

      '';
    };
  };
}
