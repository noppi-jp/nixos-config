{ config, pkgs, ... }:

{
  home = {
    username = "satoshi";
    homeDirectory = "/home/satoshi";

    # link the configuration file in current directory to the specified location in
    # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;
    file.".emacs.d/init.el".source = ./home/.emacs.d/init.el;

    # link all files in `./scripts` to `~/.config/i3/scripts`
    # home.file.".config/i3/scripts" = {
    #   source = ./scripts;
    #   recursive = true;   # link recursively
    #   executable = true;  # make all files executable
    # };

    # encode the file content in nix configuration file directly
    # home.file.".xxx".text = ''
    #     xxx
    # '';

    # set cursor size and dpi for 4k monitor
    # xresources.properties = {
    #   "Xcursor.size" = 16;
    #   "Xft.dpi" = 172;
    # };

    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      # here is some command line tools I use frequently
      # feel free to add your own or remove some of them
    ];

    pointerCursor = {
      enable = true;
      package = pkgs.xorg.xcursorthemes;
      name = "whiteglass";
    };
  };

  # basic configuration of git, please change to your own
  programs = {
    bash = {
      enable = true;
      profileExtra = builtins.readFile ./home/.bash_profile;
    };

    git = {
      enable = true;
      userName = "Noppi";
      userEmail = "noppi@noppi.jp";
      extraConfig = {
        push.default = "nothing";
      };
    };

    neovim = {
      enable = true;
      extraConfig = builtins.readFile ./home/.config/nvim/init.vim;
    };

    vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        ms-vscode-remote.remote-containers
        asvetliakov.vscode-neovim
        ms-ceintl.vscode-language-pack-ja
      ];
    };

    waybar = {
      enable = true;
      settings.main = import ./home/.config/waybar/config.nix;
      style = builtins.readFile ./home/.config/waybar/style.css;
    };

    wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./home/.config/wezterm/wezterm.lua;
    };

    wofi = {
      enable = true;
      settings = import ./home/.config/wofi/config.nix;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = import ./home/.config/hyprland/hyprland.nix;
  };

  # This value determines the home Manager release that your
  # configuration is compmatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
