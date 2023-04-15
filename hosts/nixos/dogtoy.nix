{ config, pkgs, lib, nixos-hardware, suites, ... }:
{

  imports = suites.base ++ suites.personal ++ suites.gaming ++ suites.nvidia-offload ++ suites.hm-heavy;

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/93f94bab-cbfb-4af0-931c-0c75a9f4db82";
      fsType = "xfs";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/925F-1CB3";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/17065d73-8752-4241-8cfd-8777ececdb51"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dogtoy"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "US/Chicago";

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.stumpwm = {
    enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  fonts.fonts = with pkgs; [ powerline-fonts dejavu_fonts nerdfonts noto-fonts noto-fonts-emoji ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "DejaVu Sans Mono for Powerline" ];
    sansSerif = [ "DejaVu Sans" ];
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    firefox
    wget
    spotify
    pkgs.linuxPackages_xanmod_latest.perf
  ];
  services.openssh.enable = true;
  networking.firewall.enable = false;
  # system.copySystemConfiguration = true;
  system.stateVersion = "22.11";
}

