{ pkgs, ... }:
let
  ueberzugWrapper = import ./ueberzug-wrapper.nix { inherit pkgs; };
  previewer = import ./previewer.nix { inherit pkgs; };
  cleaner = import ./cleaner.nix { inherit pkgs; };
in
{
  programs.lf = {
    enable = true;
    package = ueberzugWrapper;
    settings = {
      drawbox = true;
      hidden = true;
      scrolloff = 10;
      shell = "sh";
      shellopts = "-eu";
      previewer = "${previewer}/bin/previewer";
      cleaner = "${cleaner}/bin/cleaner";
    };
    commands = {
      autojump = ''
        %lf -remote "send $id cd '$(${pkgs.autojump}/bin/autojump $1 | sed 's/\\/\\\\/g;s/"/\\"/g')'"
      '';
      trash = ''
        &{{
          mapfile -t files < <(printf %s "$fx")
          ${pkgs.trashy}/bin/trash put "''${files[@]}"
        }}
      '';
      delete = ''
        &{{
          mapfile -t files < <(printf %s "$fx")
          rm -rf "''${files[@]}"
        }}
      '';
      extract = ''
        ''${{
          set -f
          case $f in
            *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) tar xjvf "$f";;
            *.tar.gz|*.tgz) tar xzvf "$f";;
            *.tar.xz|*.txz) tar xJvf "$f";;
            *.7z|*.zip|*.zst) ${pkgs.p7zip}/bin/7z x "$f";;
            *.tar) tar xf "$f";;
          esac
        }}
      '';
    };
    keybindings = {
      E = "extract";
      J = "push :autojump<space>";
      X = "!\"$f\"";
      x = "$\"$f\"";
    };
  };
}
