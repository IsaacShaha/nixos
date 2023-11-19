{ config, lib, pkgs, ... }:
let
  dockerOverlay = self: super: {
    docker = unstable.docker;
  };
  i3-modifier = "Mod4";
  unstable = import <nixos-unstable> { };
in
{
  # Stable
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
    <nixos-hardware/system76>
  ];
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    authy
    chromium
    ganttproject-bin
    ghc
    gnumake
    lightlocker
    lxqt.lxqt-policykit
    nixpkgs-fmt
    pavucontrol
    shutter
    spotify
    taskwarrior
    teams
    thunderbird
    unityhub
    unzip
    # webcam tweaking
    v4l_utils
    wget
    xorg.xkill
    zip

    #x11docker
    x11docker
    xorg.libxcvt
    catatonit
  ];
  hardware = {
    bluetooth.enable = true;
    bluetooth.settings = {
      General = {
        ControllerMode = "dual";
      };
    };
    pulseaudio.enable = true;
    system76 = {
      enableAll = true;
      kernel-modules.enable = true;
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    users.isaac = { pkgs, ... }: {
      home = {
        file.".git-prompt.sh".source = "${pkgs.git}/share/git/contrib/completion/git-prompt.sh";
        stateVersion = "23.05";
      };
      programs = {
        bash = {
          enable = true;
          # urxvt has a bug that starts text 23ish lines in. Remove clear from initExtra when this is fixed.
          initExtra = ''
            source ~/.git-prompt.sh;
            PS1='\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u:\w\033[35m\]$(__git_ps1 " (%s)")\033[32m\]]\$\[\033[0m\] '
            clear
          '';
          sessionVariables = {
            DIRENV_LOG_FORMAT = null;
          };
          shellAliases = {
            connect-bluetooth-wifi = "bluetoothctl connect 8C:DE:E6:C6:D8:4A && nmcli device connect 8C:DE:E6:C6:D8:4A";
            connect-headphones = "bluetoothctl connect 22:70:19:FC:C4:4E";
            dual-monitor-left = "xrandr --output HDMI-1 --left-of eDP-1 --auto";
            # xrandr --output HDMI-1 --right-of eDP-1 --auto --scale 0.8x0.8
            dual-monitor-right = "xrandr --output HDMI-1 --right-of eDP-1 --auto";
            rebuild = "sudo nixos-rebuild switch";
            single-monitor = "xrandr --output HDMI-1 --off";
          };
        };
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        gh.enable = true;
        git = {
          enable = true;
          extraConfig = {
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
          };
          userEmail = "isaac.shaha64@gmail.com";
          userName = "Isaac Shaha";
        };
        urxvt = {
          enable = true;
          extraConfig = {
            background = "black";
            foreground = "white";
          };
          fonts = [
            "xft:Mono:size=10"
          ];
          iso14755 = false;
          keybindings = {
            "Shift-Control-C" = "eval:selection_to_clipboard";
            "Shift-Control-V" = "eval:paste_clipboard";
          };
          shading = 20;
          transparent = true;
        };
        vscode = {
          enable = true;
          extensions = with pkgs.vscode-extensions; [
            esbenp.prettier-vscode
            github.copilot
            grapecity.gc-excelviewer
            jnoortheen.nix-ide
            justusadam.language-haskell
            ms-python.python
            ms-vscode-remote.remote-ssh
            ms-vsliveshare.vsliveshare
          ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "black-formatter";
              publisher = "ms-python";
              sha256 = "sha256-YBcyyE9Z2eL914J8I97WQW8a8A4Ue6C0pCUjWRRPcr8=";
              version = "latest";
            }
            {
              name = "isort";
              publisher = "ms-python";
              sha256 = "sha256-Ga2gA7dOKzp8FTpp7dS1D8R5g2ZAJU55VaKoijOqsnY=";
              version = "latest";
            }
            {
              name = "remote-containers";
              publisher = "ms-vscode-remote";
              sha256 = "sha256-srSRD/wgDbQo9P1uJk8YtcXPZO62keG5kRnp1TmHqOc=";
              version = "latest";
            }
            {
              name = "stylish-haskell";
              publisher = "vigoo";
              sha256 = "sha256-GGRhaHhpeMgfC517C3kDUZwzdHbY8L/YePPVf6xie/4=";
              version = "latest";
            }
            {
              name = "vscode-thunder-client";
              publisher = "rangav";
              sha256 = "sha256-eEg8UqGQ7AfR2ocBUAEKQH5E4pHBgfqkzWIVLNrMaRI=";
              version = "latest";
            }
            {
              name = "octave";
              publisher = "toasty-technologies";
              sha256 = "sha256-tbqblaBX+wqgasfGLsFp49xYxXi5CF39YPYs0QyANt0=";
              version = "latest";
            }
          ];
          mutableExtensionsDir = false;
          userSettings = {
            "[haskell]" = {
              "editor.defaultFormatter" = "vigoo.stylish-haskell";
              "editor.insertSpaces" = true;
              "editor.tabSize" = 2;
            };
            "[python]" = {
              "editor.defaultFormatter" = "ms-python.black-formatter";
            };
            "black-formatter.args" = [
              "--experimental-string-processing"
            ];
            "editor.codeActionsOnSave" = {
              "source.organizeImports" = true;
            };
            "editor.formatOnSave" = true;
            "editor.inlineSuggest.enabled" = true;
            "editor.rulers" = [
              80
            ];
            "explorer.confirmDelete" = false;
            "update.mode" = "none";
          };
        };
        watson.enable = true;
      };
      services = {
        polybar = {
          enable = true;
          package = pkgs.polybar.override {
            i3Support = true;
            pulseSupport = true;
          };
          script = "polybar &";
          settings = rec {
            "colors" = {
              black = "#000000";
              black50transparent = "#cc000000";
              green = "#00ff00";
              magenta = "#ff00ff";
              red = "#ff0000";
              white = "#ffffff";
              white75 = "#bfbfbf";
              white33transparent = "#54ffffff";
              white25 = "#3f3f3f";
            };
            "bar/bottom" = {
              background = "\${colors.black50transparent}";
              bottom = true;
              font-0 = "TeX Gyre Adventor:pixelsize=20;3";
              font-1 = "Noto Color Emoji:scale=7;3";
              font-2 = "Unifont:pixelsize=10;3";
              font-3 = "Unifont:pixelsize=15;3";
              font-4 = "Tex Gyre Adventor:pixelsize=10;-3";
              height = "35px";
              line-size = 5;
              module-margin = "1";
              modules-left = "i3";
              modules-center = "volume";
              modules-right = "wifi battery datetime";
            };
            "module/battery" = rec {
              cat-bin = "${pkgs.coreutils}/bin/cat";
              exec = pkgs.writeShellScript "polybar-battery.sh" ''
                CHARGE_THRESHOLD=80
                discharge_threshold=20
                battery_path="/sys/class/power_supply/BAT0"
                battery_full=$(${cat-bin} "$battery_path/energy_full")
                battery_now=$(${cat-bin} "$battery_path/energy_now")
                battery_status=$(${cat-bin} "$battery_path/status")
                percent=$((100 * battery_now / battery_full))
                # Color is red if battery is discharging below the discharge
                # threshold or charging above the charge threshold.
                if [[ ($battery_status == "Discharging" && $percent -le $discharge_threshold)
                   || ($battery_status == "Charging" && $percent -ge $CHARGE_THRESHOLD) ]]; then
                    color="${colors.red}"
                else
                    color="${colors.green}"
                fi
                if [[ $battery_status == "Discharging" ]]; then
                    arrow="↓"
                else
                    arrow="↑"
                fi
                echo "🔋%{F$color}$percent%$arrow%{F-}"
              '';
              interval = 1;
              type = "custom/script";
            };
            "module/datetime" = rec {
              date-bin = "${pkgs.coreutils}/bin/date";
              exec = pkgs.writeShellScript "polybar-datetime.sh" ''
                day_of_month_with_zero=$(${date-bin} +%d)
                day_of_month=''${day_of_month_with_zero#0}
                # Get Ordinal Day of Month, taking into account 11th, 12th, 13th
                if [[ $((day_of_month / 10)) == 1 ]]; then
                    ordinal="th"
                else
                    case $((day_of_month % 10)) in
                        1) ordinal="st" ;;
                        2) ordinal="nd" ;;
                        3) ordinal="rd" ;;
                        *) ordinal="th" ;;
                    esac
                fi
                date=$(${date-bin} +"%A, %B $day_of_month%{T5}$ordinal%{T-}, %Y")
                hour=$((10#$(${date-bin} +"%I")))
                time=$(${date-bin} +"$hour:%M:%S%p")
                echo "📅$date 🕛$time"
              '';
              interval = 1;
              type = "custom/script";
            };
            "module/i3" = {
              label-focused = "%index%";
              label-focused-background = "\${colors.white75}";
              label-focused-foreground = "\${colors.black}";
              label-focused-padding = 1;
              label-focused-underline = "\${colors.magenta}";
              label-unfocused = "%index%";
              label-unfocused-background = "\${colors.white25}";
              label-unfocused-foreground = "\${colors.white}";
              label-unfocused-padding = 1;
              label-urgent = "%index%";
              label-urgent-background = "\${colors.white25}";
              label-urgent-foreground = "\${colors.white}";
              label-urgent-padding = 1;
              label-urgent-underline = "\${colors.red}";
              label-visible = "%index%";
              label-visible-background = "\${colors.white25}";
              label-visible-foreground = "\${colors.white}";
              label-visible-padding = 1;
              type = "internal/i3";
            };
            "module/volume" = {
              bar-volume-empty = "█";
              bar-volume-empty-foreground = "\${colors.white33transparent}";
              bar-volume-fill = "█";
              bar-volume-fill-foreground = "\${colors.white75}";
              bar-volume-indicator = "█";
              bar-volume-indicator-font = 4;
              bar-volume-indicator-foreground = "\${colors.white}";
              bar-volume-width = 50;
              # Override the default left-click with a no-op.
              format-volume = "%{A1::}<ramp-volume><bar-volume>     %{A}";
              label-muted = "%{A1::}🔇%{A}";
              ramp-volume-0 = "🔈";
              ramp-volume-1 = "🔉";
              ramp-volume-2 = "🔉";
              ramp-volume-3 = "🔊";
              type = "internal/pulseaudio";
              use-ui-max = false;
            };
            "module/wifi" = {
              interface = "wlp2s0";
              interface-type = "wireless";
              label-connected = "🛜%signal%%";
              label-connected-foreground = "\${colors.green}";
              type = "internal/network";
            };
          };
        };
        picom = {
          enable = true;
          fade = true;
          fadeSteps = [
            0.1
            0.1
          ];
        };
      };
      xsession.windowManager.i3 = {
        config = {
          bars = [ ];
          defaultWorkspace = "workspace number 1";
          keybindings = lib.mkOptionDefault {
            "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5% && $refresh_i3status";
            "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5% && $refresh_i3status";
            "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status";
            "XF86MonBrightnessUp" = "exec --no-startup-id light -A 10";
            "XF86MonBrightnessDown" = "exec --no-startup-id light -U 10";
          };
          modes = {
            resize = {
              "${i3-modifier}+r" = "mode default";
              Down = "resize grow height 10 px or 10 ppt";
              Escape = "mode default";
              Left = "resize shrink width 10 px or 10 ppt";
              Return = "mode default";
              Right = "resize grow width 10 px or 10 ppt";
              Up = "resize shrink height 10 px or 10 ppt";
            };
          };
          modifier = i3-modifier;
          startup = [
            { command = "--no-startup-id light-locker"; }
            { command = "--no-startup-id lxqt-policykit-agent"; }
            {
              always = true;
              command = "systemctl --user restart polybar";
              notification = false;
            }
          ];
          window.commands = [
            {
              command = "move position center";
              criteria = {
                floating = true;
              };
            }
            {
              command = "move window to workspace current";
              criteria = {
                floating = true;
              };
            }
          ];
        };
        enable = true;
        extraConfig = "floating_maximum_size 1920 x 1080";
      };
    };
  };
  i18n.defaultLocale = "en_CA.UTF-8";
  networking = {
    hostName = "isaac-nixos";
    networkmanager.enable = true;
  };
  nix = {
    extraOptions = ''
      experimental-features = nix-command
    '';
    # nixos/nixpkgs garbage collection.
    gc = {
      automatic = true;
      dates = "monthly";
      options = "-d";
    };
  };
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ dockerOverlay ];
  };
  programs = {
    chromium = {
      enable = true;
      extensions = [
        "chlffgpmiacpedhhbkiomidkjlcfhogd"
        "cfhdojbkjhnklbpkdaibdccddilifddb"
      ];
    };
    light.enable = true;
    ssh.startAgent = true;
    steam.enable = true;
    xss-lock = {
      enable = true;
      lockerCommand = "light-locker-command -l";
    };
  };
  security.polkit.enable = true;
  services = {
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
    blueman.enable = true;
    deluge.enable = true;
    gnome.gnome-keyring.enable = true;
    printing = {
      drivers = [ pkgs.brlaser ];
      enable = true;
    };
    udev.extraRules = ''
      SUBSYSTEM == "video4linux", KERNEL=="video0", RUN+="${pkgs.v4l-utils}/bin/v4l2-ctl -d /dev/video0 --set-ctrl=brightness=150"
    '';
    xserver = {
      displayManager = {
        defaultSession = "none+i3";
        sessionCommands = "xrandr --output HDMI-1 --left-of eDP-1 --auto";
      };
      dpi = 120;
      enable = true;
      layout = "us";
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
        ];
      };
    };
  };
  system.stateVersion = "23.05";
  time.timeZone = "America/Vancouver";
  users.users.isaac = {
    description = "Isaac Shaha";
    extraGroups = [ "docker" "networkmanager" "video" "wheel" ];
    isNormalUser = true;
    packages = with pkgs; [ ];
  };
  virtualisation.docker.enable = true;
}
