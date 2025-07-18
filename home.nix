# ~/.config/home-manager/home.nix

{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "philetus";
  home.homeDirectory = "/home/philetus";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # set git config
  programs.git = {
    enable = true;
    userName  = "michael philetus weller";
    userEmail = "philetus@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull = {
        ff = "only";
      };
    };
  };

  # set starship config
  programs.starship = {
    enable = true;

    # configuration written to ~/.config/starship.toml
    settings = {
      add_newline = true;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };

  # setup bashrc
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # add custom commands here
      # eval "$(starship init bash)"
    '';
  };

  # the home.packages option allows you to install nix packages into your
  # environment.
  home.packages = with pkgs; [
    bat
    cargo
    clang-tools
    clippy
    fd
    gcc
    gnumake
    go
    just
    libgcc
    lua5_1
    lua51Packages.jsregexp
    lua51Packages.luarocks
    neovim
    nerd-fonts._0xproto
    nodejs_24
    python313
    python313Packages.pip
    ripgrep
    rustc
    rust-analyzer
    sublime4
    starship
    tree-sitter
    vimPlugins.blink-cmp-git
    xclip
  ];

  # allow unfree packages (for sublime)
  # allow openssl 1.1 (for sublime)
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "openssl-1.1.1w"
      ];
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/philetus/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "subl";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
