# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, modulesPath, pkgs, ... }:

{
  imports = [ "${modulesPath}/installer/scan/not-detected.nix" ];

  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ "amdgpu" ];
      systemd.enable = true;
    };

    kernelParams = [ "quiet" ];
    kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = [ ];
    supportedFilesystems = [ "ntfs" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    tmp.cleanOnBoot = true;
  };

  hardware.graphics = {
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva
    ];
    enable = true;
  };

  environment.variables.AMD_VULKAN_ICD = "RADV";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/apocrypha";
      fsType = "btrfs";
      options = [ "subvol=@" "defaults" "noatime" "compress=zstd" "commit=120" ];
    };

    "/nix" = {
      device = "/dev/disk/by-label/apocrypha";
      fsType = "btrfs";
      options = [ "subvol=@nix" "defaults" "noatime" "compress=zstd" "commit=120" ];
    };

    "/home" = {
      device = "/dev/disk/by-label/apocrypha";
      fsType = "btrfs";
      options = [ "subvol=@home" "defaults" "noatime" "compress=zstd" "commit=120" ];
    };

    "/tmp" = {
      device = "/dev/disk/by-label/apocrypha";
      fsType = "btrfs";
      options = [ "subvol=@tmp" "defaults" "noatime" "compress=zstd" "commit=120" ];
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp11s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp12s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
