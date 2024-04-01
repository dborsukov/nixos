{ config
, lib
, pkgs
, modulesPath
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelModules = [ "kvm-intel" ];

    initrd = {
      availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };

    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems =
    let
      options = [
        "uid=1000"
        "gid=100"
        "dmask=007"
        "fmask=117"
        "nofail"
        "x-gvfs-show"
      ];
    in
    {
      "/" = {
        device = "/dev/disk/by-uuid/8d47f2d3-f80a-42e7-a921-00e723c41447";
        fsType = "ext4";
      };
      "/boot" = {
        device = "/dev/disk/by-uuid/A8B8-ABB6";
        fsType = "vfat";
      };
      "/mnt/DATA" = {
        device = "/dev/disk/by-label/DATA";
        fsType = "ntfs";
        options = options;
      };
      "/mnt/SLOW" = {
        device = "/dev/disk/by-label/SLOW";
        fsType = "ntfs";
        options = options;
      };
      "/mnt/WINDOWS" = {
        device = "/dev/disk/by-label/WINDOWS";
        fsType = "ntfs";
        options = options;
      };
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
