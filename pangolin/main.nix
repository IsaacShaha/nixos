{ lib
, pkgs
, ...
}:
let
  i3-modifier = "Mod4";
in
{
  imports = [
    # <nixos-hardware/system76>
    ./SENG440.nix
    ./blender.nix
    ./gaming.nix
  ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  environment.systemPackages = with pkgs; [

    # audio
    lmms

    # installation media creator
    ventoy

    # git
    git-lfs

    # haskell <3
    ghc

    # libera
    hexchat

    # windows applications
    lutris
    wineWowPackages.stable
    winetricks

    # monitoring
    glances

    # mouse configuration
    piper

    # sql
    mysql-client

    # obs
    obs-studio

    # putty
    putty

    # screenshots
    shutter

    # security
    lightlocker
    lxqt.lxqt-policykit

    # uvic vpn
    openconnect

    # video editing
    kdenlive
    losslesscut-bin

    # virtual machine
    quickemu

    # wallpaper
    feh

    # web browsing
    chromium
    google-chrome

    # webcam tweaking
    v4l-utils

    #x11docker
    catatonit
    x11docker
    xorg.libxcvt

    # other
    audacity
    discord
    inkscape
    mangohud
    nixpkgs-fmt
    pavucontrol
    spotify
    taskwarrior
    unityhub
    unzip
    wget
    xorg.xkill
    zip

  ];
  hardware = {
    bluetooth.enable = true;
    bluetooth.settings = {
      General = {
        ControllerMode = "bredr";
      };
    };
    graphics.enable = true;
    # pulseaudio.enable = true;
    # system76 = {
    #   enableAll = true;
    #   kernel-modules.enable = true;
    # };
  };
  home-manager = {
    users.isaac = { pkgs, ... }: {
      home.file.".git-prompt.sh".source = "${pkgs.git}/share/git/contrib/completion/git-prompt.sh";
      programs = {
        bash = {
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
            connect-tv-right = "xrandr --output HDMI-1 --right-of eDP-1 --mode 1680x1050";
            connect-uvic-vpn = "sudo openconnect -b --useragent=AnyConnect --no-dtls --user=ishaha vpn.uvic.ca/student";
            dual-monitor-left = "xrandr --output HDMI-A-0 --left-of eDP --auto";
            dual-monitor-right = "xrandr --output HDMI-A-0 --right-of eDP --auto";
            mirror-monitor = "xrandr --output HDMI-A-0 --same-as eDP --auto";
            single-monitor = "xrandr --output HDMI-A-0 --off";
          };
        };
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        ssh = {
          matchBlocks = {
            "aws-sirocco" = {
              identityFile = "/home/isaac/.ssh/sirocco-ec2-login.pem";
              hostname = "ec2-54-201-255-137.us-west-2.compute.amazonaws.com";
              user = "ec2-user";
            };
          };
          enable = true;
        };
        urxvt = {
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
              sha256 = "sha256-EPtxcp42KunVwVdT/xhVzuwvQ+5VswGNnOZpYXZOP04=";
              version = "latest";
            }
            {
              name = "isort";
              publisher = "ms-python";
              sha256 = "sha256-UBV9i3LPVv60+toy+kJvESAuJHRmH/uEIwjTidYUXLc=";
              version = "latest";
            }
            {
              name = "remote-containers";
              publisher = "ms-vscode-remote";
              sha256 = "sha256-W5mlyn3pjbBYFko19DtytvhIaaOnL4PovlAEog3t6C8=";
              version = "latest";
            }
            {
              name = "stylish-haskell";
              publisher = "vigoo";
              sha256 = "sha256-GGRhaHhpeMgfC517C3kDUZwzdHbY8L/YePPVf6xie/4=";
              version = "latest";
            }
            {
              name = "octave";
              publisher = "toasty-technologies";
              sha256 = "sha256-tbqblaBX+wqgasfGLsFp49xYxXi5CF39YPYs0QyANt0=";
              version = "latest";
            }
            {
              name = "vstuc";
              publisher = "VisualStudioToolsForUnity";
              sha256 = "sha256-iE/o6hkDwT7jLTVvJbviQZgV+KnhSAGEZ2mf3gsua38=";
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
            "[literate haskell]" = {
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
            "extensions.ignoreRecommendations" = true;
            "search.followSymlinks" = false;
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
              font-2 = "DejaVuSans:pixelsize=10;3";
              font-3 = "DejaVuSans:pixelsize=15;3";
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
              bar-volume-width = 40;
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
            "XF86AudioRaiseVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && $refresh_i3status";
            "XF86AudioLowerVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && $refresh_i3status";
            "XF86AudioMute" = "exec --no-startup-id wpctl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status";
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
            { command = "feh --bg-scale ~/.background-image"; }
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
  # Binary Cache for Haskell.nix
  nix.settings = {
    substituters = [
      "https://cache.iog.io"
    ];
    trusted-public-keys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
  };
  networking.hostName = "isaac-pangolin";
  programs = {
    chromium.enable = true;
    light.enable = true;
    xss-lock = {
      enable = true;
      lockerCommand = "light-locker-command -l";
    };
  };
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
  services = {
    # printing
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    blueman.enable = true;
    deluge.enable = true;

    displayManager.defaultSession = "none+i3";

    gnome.gnome-keyring.enable = true;

    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    printing = {
      drivers = [ pkgs.brlaser ];
      enable = true;
    };

    # mouse configuration
    ratbagd.enable = true;

    udev.extraRules = ''
      SUBSYSTEM == "video4linux", KERNEL=="video0", RUN+="${pkgs.v4l-utils}/bin/v4l2-ctl -d /dev/video0 --set-ctrl=brightness=150"
    '';
    xserver = {
      displayManager.gdm.wayland = true;
      dpi = 120;
      enable = true;
      videoDrivers = [ "amdgpu" ];
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
        ];
      };
      xkb.layout = "us";
    };
  };
  system.autoUpgrade.enable = true;
  users.users.isaac.extraGroups = [ "video" ];
}
