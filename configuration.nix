{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];
  nixpkgs.config.allowUnfree = true;
  console = {
    useXkbConfig = true;
    font = "ter-v32b";
    packages = with pkgs; [ terminus_font ];
  };
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/Sao_Paulo";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.initrd.luks.devices."luks-c7a03bda-692c-44ee-8184-70f9b57a8ee8".device =
    "/dev/disk/by-uuid/c7a03bda-692c-44ee-8184-70f9b57a8ee8";
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="Cam" exclusive_caps=1
  '';

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    alsa-utils
    wireplumber
    dejavu_fonts
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    noto-fonts-color-emoji
    ifuse
    libimobiledevice
    usbmuxd
    home-manager
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.light.enable = true;
  programs.dconf.enable = true;
  programs.xwayland.enable = true;
  programs.chromium = {
    enable = true;
    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "https://google.com/search?q={searchTerms}";
    extraOpts = {
      PasswordManagerEnabled = false;
      RestoreOnStartup = 1;
      NewTabPageLocation = "about:blank";
      "force-device-scale-factor" = "1.5";
    };
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.enableIPv6 = false;
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  security.polkit.enable = true;
  security.rtkit.enable = true;

  services.xserver.xkb.layout = "br";
  services.xserver.xkb.variant = "thinkpad";
  services.displayManager.lemurs.enable = true;
  services.pipewire.enable = true;
  services.pipewire.audio.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;
  services.pipewire.wireplumber.enable = true;

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # home-manager.users.xd = ./home.nix;
  users.users.xd = {
    isNormalUser = true;
    description = "xd";
    extraGroups = [
      "networkmanager"
      "wheel"
      "seat"
      "video"
      "audio"
      "docker"
      "disk"
      "plugdev"
      "fuse"
    ];
    packages = [ ];
  };

  system.stateVersion = "25.11";
}
