{ inputs, pkgs, config, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
in
{
  imports = [
    ./modules/home
    ./features/home
    inputs.nix-index-database.hmModules.nix-index
    inputs.nix-colors.homeManagerModules.default
  ];

  home = {
    username = "db";
    homeDirectory = "/home/${config.home.username}";
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.cargo/bin"
    ];
    packages = with pkgs; [
      gimp
      just
      keepassxc
      lazygit
      mate.engrampa
      nsxiv
      ripgrep
      scrot
      telegram-desktop
      trashy
      ungoogled-chromium
    ];
    stateVersion = "23.11";
  };

  colorscheme = colorSchemes.atelier-estuary;

  programs.nix-index.enable = true;

  news.display = "silent";
  programs.home-manager.enable = true;
}
