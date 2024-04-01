{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Denis Borsukov";
    userEmail = "borsukov@proton.me";
    signing = {
      signByDefault = true;
      key = "11D989B43A51E2B1763870CB7E7511C411AB7178";
    };
    extraConfig = {
      credential = {
        helper = "libsecret";
      };
    };
  };
  home.packages = with pkgs; [
    libsecret
  ];
}
