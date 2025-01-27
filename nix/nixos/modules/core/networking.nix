{pkgs, ...}: {
  networking = {
    networkmanager.enable = true;
    iproute2.enable = true;
    useDHCP = false;
    hosts = {
      "127.0.0.1" = ["localhost.localdomain" "localhost"];
      "192.168.68.88" = ["burning-pope.localdomain" "burning-pope"];
      "192.168.68.77" = ["pinky.localdomain" "pinky"];
      "192.168.68.78" = ["wittie-box.localdomain" "wittie-box"];
      "192.168.69.88" = ["yvone.localdomain" "yvone"];
    };

    # From burning-pope
    # hostName = "burning-pope";
    # interfaces = {"wlp59s0" = {useDHCP = true;};};

    # From red-arrow
    # hostName = "red-arrow";

    # From wittie-box
    # hostName = "wittie-box";
    # hosts = {
    #  "127.0.1.1" = ["wittie-box"];
    # };
    # interfaces = {
    #  "wlp2s0" = {useDHCP = true;};
    # };

    firewall = {
      enable = true;
    };
  };

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
