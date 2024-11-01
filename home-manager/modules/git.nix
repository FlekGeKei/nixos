{
  programs.git = {
    enable = true;
    userName = "FlekGeKei";
    userEmail = "FlekGeKei@outlook.com";
    lfs.enable = true;
    signing = {
      signByDefault = true;
      key = "AC25D0A1773D2E4BB82C80635240C6494ECA345F";
    };
    extraConfig = {
      safe.directory = "~/Documents/nixos";
    };
  };
}
