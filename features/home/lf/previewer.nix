{ pkgs, ... }:
pkgs.writeShellScriptBin "previewer" ''
  set -e

  draw() {
      ${pkgs.jq}/bin/jq -nc --argjson x "$x" --argjson y "$y" \
          --argjson width "$width" --argjson height "$height" \
          --arg path "$1" '
          {
            "action": "add",
            "identifier": "preview",
            "x": $x,
            "y": $y,
            "width": $width,
            "height": $height,
            "scaler": "contain",
            "scaling_position_x": 0.5,
            "scaling_position_y": 0.5,
            "path": $path
          }' >"$FIFO_UEBERZUG"
      exit 1
  }

  hash() {
      printf '%s/.cache/lf/%s' "$HOME" \
          "$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- \
          "$(readlink -f -- "$1")" | sha256sum | cut -d' ' -f1)"
  }

  cache() {
      if [ -f "$1" ]; then
          draw "$1"
      fi
  }

  file="$1"
  width="$2"
  height="$3"
  x="$4"
  y="$5"

  if ! [ -f "$file" ] && ! [ -h "$file" ]; then
      exit
  fi

  default_x="1920"
  default_y="1080"

  # Try to match using file extension
  ext="$(printf '%s' "$file" | tr '[:upper:]' '[:lower:]')"
  ext="''${ext##*.}"

  case "$ext" in
      7z | a | ace | alz | arc | arj | bz | bz2 | cab | cpio | deb | gz | jar | \
      lha | lrz | lz | lzh | lzma | lzo | rar | rpm | rz | t7z | tar | tbz | \
      tbz2 | tgz | tlz | txz | tZ | tzo | war | xz | Z | zip)
          ${pkgs.atool}/bin/als -- "$file"
          exit 0
      ;;
      [1-8])
          COLUMNS="$width" man -- "$file" | col -b
          exit 0
      ;;
      pdf)
          if [ -n "''${FIFO_UEBERZUG-}" ]; then
              cache="$(hash "$file")"
              cache "$cache.jpg"
              ${pkgs.poppler_utils}/bin/pdftoppm -f 1 -l 1 \
                -scale-to-x "$default_x" \
                -scale-to-y -1 \
                -singlefile \
                -jpeg \
                -- "$file" "$cache"
              draw "$cache.jpg"
          else
              ${pkgs.poppler_utils}/bin/pdftotext -nopgbrk -q -- "$file" -
              exit 0
          fi
      ;;
      djvu | djv)
          if [ -n "''${FIFO_UEBERZUG-}" ]; then
              cache="$(hash "$file").tiff"
              cache "$cache"
              ${pkgs.djvulibre}/bin/ddjvu -format=tiff -quality=90 -page=1 -size="''${default_x}x''${default_y}" \
                - "$cache" <"$file"
              draw "$cache"
          else
              ${pkgs.djvulibre}/bin/djvutxt - <"$file"
              exit 0
          fi
      ;;
      docx | odt | epub)
          ${pkgs.pandoc}/bin/pandoc -s -t plain -- "$file"
          exit 0
      ;;
      htm | html | xhtml)
          ${pkgs.lynx}/bin/lynx -dump -- "$file"
          exit 0
      ;;
      svg)
          if [ -n "''${FIFO_UEBERZUG-}" ]; then
              cache="$(hash "$file").jpg"
              cache "$cache"
              ${pkgs.imagemagick}/bin/convert -- "$file" "$cache"
              draw "$cache"
          fi
      ;;
  esac

  # Try to match using mime type
  mime="$(${pkgs.file}/bin/file -Lb --mime-type -- "$file")"

  case "$mime" in
      text/*)
          ${pkgs.sourceHighlight}/bin/source-highlight -q --outlang-def=esc.outlang\
          --style-file=esc.style -i "$file" || cat -- "$file"
          exit 0
      ;;
      image/*)
          if [ -n "''${FIFO_UEBERZUG-}" ]; then
              orientation="$(${pkgs.imagemagick}/bin/identify -format '%[EXIF:Orientation]\n' -- "$file")"
              if [ -n "$orientation" ] && [ "$orientation" != 1 ]; then
                  cache="$(hash "$file").jpg"
                  cache "$cache"
                  ${pkgs.imagemagick}/bin/convert -- "$file" -auto-orient "$cache"
                  draw "$cache"
              else
                  draw "$file"
              fi
          fi
      ;;
      video/*)
          if [ -n "''${FIFO_UEBERZUG-}" ]; then
              cache="$(hash "$file").jpg"
              cache "$cache"
              ${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "$file" -o "$cache" -s 0
              draw "$cache"
          fi
      ;;
  esac

  # Fallback to general file classification

  # Print pretty header
  header_text="File Type Classification"
  header=""
  len="$(((width - (''${#header_text} + 2)) / 2))"
  if [ "$len" -gt 0 ]; then
      for _ in $(seq "$len"); do
          header="-$header"
      done
      header="$header $header_text "
      for _ in $(seq "$len"); do
          header="$header-"
      done
  else
      header="$header_text"
  fi
  printf '\033[7m%s\033[0m\n' "$header"

  # Print file info
  ${pkgs.file}/bin/file -Lb -- "$file" | fold -s -w "$width"

  exit 0
''
