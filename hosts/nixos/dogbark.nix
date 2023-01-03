{ config, pkgs, lib, nixos-hardware, suites, ... }:
{
  imports = suites.base ++ suites.hm-minimal;
  nixpkgs.hostPlatform = "aarch64-linux";

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  boot = {
    # kernelPackages = lib.mkDefault pkgs.linuxPackages_rpi3;
    tmpOnTmpfs = true;
    initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
    loader = {
      raspberryPi = { enable = true; version = 3; };
      grub.enable = false;
      generic-extlinux-compatible.enable = lib.mkForce false;
    };
  };
  hardware.enableRedistributableFirmware = true;
  networking.hostName = "dogbark";
  system.stateVersion = "22.11";
  fileSystems."/".device = "/dev/sda1";
}
