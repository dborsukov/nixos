{ ... }: {
  imports = [
    ./nix.nix
    ./polkit.nix
    ./printing.nix
    ./sound.nix
    ./time+locale.nix
  ];
}
