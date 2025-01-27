{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Process and I/O inspection
    htop
    lsof
    iotop

    # System inspection
    lshw
    powertop
    usbtop
    usbutils
    pciutils

    # Security
    gnupg
  ];
}
