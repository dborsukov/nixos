{ ... }: {
  programs.autojump = {
    enable = true;
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      function fish_greeting;end
      function fish_prompt
        set_color purple
        if [ -n "$IN_NIX_SHELL" ]
          printf '%s ' "(nix-shell)"
        end
        set_color blue
        echo -n (hostname)
        if [ $PWD != $HOME ]
          set_color grey
          echo -n ':'
          set_color yellow
          echo -n (basename $PWD)
        end
        set_color green
        printf '%s ' (__fish_git_prompt)
        set_color red
        echo -n '| '
        set_color normal
      end
    '';
    shellAbbrs = {
      lg = "lazygit";
      tp = "trash put";
      v = "nvim";
      ns = "nix-shell --command fish";
      nd = "nix develop -c fish";
    };
  };
}
