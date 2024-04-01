{ pkgs, ... }:
pkgs.writeShellScriptBin "cleaner" ''
  set -e
  if [ -n "''${FIFO_UEBERZUG-}" ]; then
    printf '{"action":"remove","identifier":"preview"}\n' >"''$FIFO_UEBERZUG"
  fi
''
