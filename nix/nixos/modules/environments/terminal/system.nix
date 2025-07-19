{pkgs, ...}: {
  programs = {
    htop.enable = true;
    iotop.enable = true;
    iftop.enable = true;
    usbtop.enable = true;
  };
  environment.systemPackages = with pkgs; [
    # Process and I/O inspection
    lsof

    # System inspection
    lshw
    powertop
    usbutils
    pciutils
  ];
}
