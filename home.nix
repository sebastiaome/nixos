{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home.username = "xd";
  home.homeDirectory = "/home/xd";
  home.file."pic/screenshots/.keep".text = "";
  home.file."pro/.keep".text = "";
  home.packages = with pkgs; [
    net-tools
    lsof
    nmap
    bottom
    atool
    httpie
    nixfmt
    nixd
    grim
    swaybg
    slurp
    light
    vscodium
    fastfetch
    pavucontrol
    wev
    signal-desktop
    telegram-desktop
    apple-cursor
    imagemagick
    w3m
    zip
    unzip
    tldr
    yq
    jq
    blockdiag
    firefox
    vesktop
    htop
    anki
    rendercv
    dig
    openfortivpn
    openfortivpn-webview
    javaPackages.compiler.openjdk25
    geckodriver
    mitmproxy
    wl-clipboard
    kdePackages.kdeconnect-kde
    alarm-clock-applet
    bundler
    hugo
    ncdu
    openssl
  ];

  stylix = {
    enable = true;
    polarity = "light";
    override = {
      base00 = "282936";
      base01 = "3a3c4e";
      base02 = "4d4f68";
      base03 = "626483";
      base04 = "62d6e8";
      base05 = "e9e9f4";
      base06 = "f1f2f8";
      base07 = "f7f7fb";
      base08 = "ea51b2";
      base09 = "b45bcf";
      base0A = "00f769";
      base0B = "ebff87";
      base0C = "a1efe4";
      base0D = "62d6e8";
      base0E = "b45bcf";
      base0F = "00f769";
    };
    image = ./.wallpaper;
    opacity.terminal = 0.88;
    cursor = {
      name = "macOS-White";
      package = pkgs.apple-cursor;
      size = 32;
    };
    fonts = {
      sizes.desktop = 18;
      sizes.terminal = 18;
      sizes.popups = 18;
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

  };

  wayland.windowManager.sway.enable = true;
  wayland.windowManager.sway.wrapperFeatures.gtk = true;
  wayland.windowManager.sway.config = {
    modifier = "Mod4";
    terminal = "kitty";
    window.border = 1;
    window.titlebar = false;
    window.hideEdgeBorders = "smart";
    floating.border = 1;
    floating.modifier = "Mod4";
    focus.followMouse = false;
    gaps.smartGaps = false;
    input = {
      "*" = {
        xkb_layout = "br";
        xkb_model = "thinkpad60";
      };
      "type:touchpad" = {
        tap = "enabled";
        natural_scroll = "enabled";
      };
    };
    keybindings = lib.mkOptionDefault {
      "Mod4+Shift+space" = "floating toggle";
      "Mod4+q" = "kill";
      "Mod4+f" = "fullscreen toggle";
      "Mod4+space" = "focus mode_toggle";
      "Mod4+a" = "focus parent";

      "Print" = "exec grim ~/pic/screenshots/$(date +%Y-%m-%d_%H-%M-%S-%N).png";

      "Ctrl+Mod1+Delete" = "exec swaymsg exit";
      "Mod4+Shift+c" = "reload";

      "Mod4+h" = "focus left";
      "Mod4+j" = "focus down";
      "Mod4+k" = "focus up";
      "Mod4+l" = "focus right";

      "Mod4+Shift+h" = "move left";
      "Mod4+Shift+j" = "move down";
      "Mod4+Shift+k" = "move up";
      "Mod4+Shift+l" = "move right";

      "Mod4+g" = "split h";
      "Mod4+v" = "split v";

      "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
      "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

      "XF86MonBrightnessUp" = "exec light -A 5";
      "XF86MonBrightnessDown" = "exec light -U 5";

      "Mod4+1" = "workspace number 1";
      "Mod4+2" = "workspace number 2";
      "Mod4+3" = "workspace number 3";
      "Mod4+4" = "workspace number 4";
      "Mod4+5" = "workspace number 5";
      "Mod4+6" = "workspace number 6";
      "Mod4+7" = "workspace number 7";
      "Mod4+8" = "workspace number 8";
      "Mod4+9" = "workspace number 9";
      "Mod4+0" = "workspace number 10";

      "Mod4+Shift+1" = "move container to workspace number 1";
      "Mod4+Shift+2" = "move container to workspace number 2";
      "Mod4+Shift+3" = "move container to workspace number 3";
      "Mod4+Shift+4" = "move container to workspace number 4";
      "Mod4+Shift+5" = "move container to workspace number 5";
      "Mod4+Shift+6" = "move container to workspace number 6";
      "Mod4+Shift+7" = "move container to workspace number 7";
      "Mod4+Shift+8" = "move container to workspace number 8";
      "Mod4+Shift+9" = "move container to workspace number 9";
      "Mod4+Shift+0" = "move container to workspace number 10";
    };
    bars = [ ];
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Sebastiao Ribeiro";
        email = "me@sebsatiao.me";
      };
      init.defaultBranch = "main";
    };
  };
  programs.bash = {
    enable = true;
    historySize = -1;
    historyFileSize = -1;
    shellAliases = {
      my-system-rebuild = "sudo nixos-rebuild switch --flake /home/xd/nixos";
      my-home-rebuild = "home-manager switch --flake /home/xd/nixos#xd";
      my-rebuild = "sudo nixos-rebuild switch --flake /home/xd/nixos && home-manager switch --flake /home/xd/nixos#xd";
    };
  };
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions =
      with pkgs.vscode-extensions;
      [
        esbenp.prettier-vscode
        bbenoist.nix
        jnoortheen.nix-ide
        eamodio.gitlens
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-mermaid-chart";
          publisher = "mermaidchart";
          version = "2.5.7";
          sha256 = "70cfc4fde70d45aa4f2053e9bda379f807126391909f2f9ff33e75e628de410a";
        }
      ];
    profiles.default.userSettings = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.formatOnSave" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.minimap.enabled" = false;
      "editor.renderWhitespace" = "none";
      "explorer.confirmDragAndDrop" = false;
      "files.eol" = "\n";
      "javascript.updateImportsOnFileMove.enabled" = "always";
      "terminal.integrated.scrollback" = 99999;
      "typescript.updateImportsOnFileMove.enabled" = "always";
      "workbench.activityBar.location" = "bottom";
      "workbench.editor.editorActionsLocation" = "hidden";
      "workbench.sideBar.location" = "right";
      "workbench.statusBar.visible" = false;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
    };
  };
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = -1;
      enable_audio_bell = false;
    };
  };
  programs.ranger = {
    enable = true;
    settings = {
      show_hidden = true;
    };
    extraConfig = ''
      set preview_images true
      set preview_images_method kitty
    '';
  };
  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
    ];
  };
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;

    extensions =
      let
        createChromiumExtensionFor =
          browserVersion:
          {
            id,
            sha256,
            version,
          }:
          {
            inherit id;
            crxPath = builtins.fetchurl {
              url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
              name = "${id}.crx";
              inherit sha256;
            };
            inherit version;
          };
        createChromiumExtension = createChromiumExtensionFor (
          lib.versions.major pkgs.ungoogled-chromium.version
        );
      in
      [
        (createChromiumExtension {
          # ublock origin
          id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          sha256 = "sha256:0ksbby7sim15b6ym8m3yjw3zz0942r9sg43grqpv1cckb55c4ha8";
          version = "1.69.0";
        })
      ];
  };

  home.stateVersion = "25.11";
}
