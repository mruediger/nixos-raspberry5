{ config,  ... }:
{
  services.prometheus.exporters.node = {
    enable = true;
    port = 9100;
    enabledCollectors = [
      "logind"
      "systemd"
      "wifi"
    ];
    disabledCollectors = [
      "textfile"
    ];
  };

  services.prometheus = {
    enable = true;
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [{
          targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
    ];
  };

  networking.firewall.allowedTCPPorts = [ 9090 ];
}
