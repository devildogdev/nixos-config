{ config, lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    kernelModules = [ "kvm-amd" "amdgpu" ];
    initrd = {
      kernelModules = [ "dm-snapshot" ];
      availableKernelModules = [
      "nvme"
      "xhci_pci_renesas"
      "xhci_pci"
      "usb_storage"
      "usbhid"
      "sd_mod"
      "rtsx_pci_sdmmc"
      "cryptd"
      ];
      luks.devices."cryptroot".device = "/dev/disk/by-label/nixos-encrypted";
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos-root";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/nixos-boot";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };

  swapDevices = [ { device = "/dev/disk/by-label/nixos-swap"; } ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
