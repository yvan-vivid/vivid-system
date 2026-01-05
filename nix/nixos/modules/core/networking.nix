{pkgs, ...}: {
  networking = {
    networkmanager.enable = true;
    iproute2.enable = true;
    useDHCP = false;
    hosts = {
      "127.0.0.1" = ["localhost.localdomain" "localhost"];
      "192.168.68.66" = ["red-arrow.localdomain" "red-arrow"];
      "192.168.68.67" = ["wittie-box.localdomain" "wittie-box"];
      "192.168.69.62" = ["yvone.localdomain" "yvone"];
      "192.168.68.59" = ["mini.localdomain" "mini"];
      "192.168.68.56" = ["packard-mill.localdomain" "packard-mill"];
      "192.168.68.72" = [
        "after-velazquez.localdomain"
        "after-velazquez"
        "after-velazquez.vivid"
        "planning.vivid"
        "jellyfin.vivid"
        "dns.vivid"
        "ui.ai.vivid"
      ];
    };

    firewall = {
      enable = true;
    };
  };

  services.resolved.enable = true;

  yvan.users.power-user.groups = [
    "network"
    "networkmanager"
  ];

  environment.systemPackages = with pkgs; [
    curl
    wget
    nmap
    netcat
    websocat
    iftop
    wireguard-tools
  ];
}
