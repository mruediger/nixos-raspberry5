{ config, ... }:
let
  secrets = import ../crypt/smtp.nix;
in
{
  services.grafana = {
    enable = true;

    settings = {
      smtp = {
        enabled = true;
        host = secrets.host;
        user = secrets.user;
        password = secrets.password;
      };

      server = {
        domain = "rpi5.local";
        http_port = 3000;
        http_addr = "0.0.0.0";
      };
    };
  };

  services.grafana.provision.datasources.settings = {
    datasources = [
      {
        name = "Prometheus localhost";
        url = "http://localhost:${toString config.services.prometheus.port}";
        type = "prometheus";
        isDefault = true;
        jsonData.timeInterval = "2m";
      }
    ];
  };

  services.grafana.provision.dashboards.settings.providers = [
    {
      name = "Node Exporter Full";
      folder = "Base";
      options.path = ../dashboards/node-exporter-full.json;
    }
  ];

  networking.firewall.allowedTCPPorts = [ 3000 ];
}
